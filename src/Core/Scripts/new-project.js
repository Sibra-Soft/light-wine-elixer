class NewProjectActions {
    /**
     * 
     * @param {NewProject} module
     */
    constructor(module) {
        this.module = module;
    }

    /** Generates a new project */
    async GenerateProject() {
        const name = $("input[name='project_name']").val();
        const environment = $("select[name='project_environment']").val();
        const domain = $("input[name='project_domain']").val();
        const connectionString = Object.keys(this.module.connections[0]).map((k) => { return k + "=" + this.module.connections[0][k] }).join(";");
        const tracing = false;
        const logAllTraffic = false;
        const createDebugLog = false;
        const logAllErrors = false;
        const gZipCompression = false;

        const request = await elixer.request.post("/project/new", {
            "name": name,
            "env": environment,
            "domain": domain,
            "connection": connectionString,
            "checkbox_tracing": tracing,
            "checkbox_log_all_traffic": logAllTraffic,
            "checkbox_debug_log": createDebugLog,
            "checkbox_log_all_errors": logAllErrors,
            "checkbox_gzip": gZipCompression
        });

        if (request.status == 200) {
            const returnJson = JSON.parse(request.data);

            elixer.dialog.confirm("Do you want to login with you new created project?<br /><br />Choose `Cancel` to download the generated file or `OK` to login using the created project", "", () => {
                window.location.href = "/?project=" + returnJson.hash;
            }, () => {
                open("/project/download?hash=" + returnJson.hash, "_blank");
            });
        }
    }

    async AddNewConnection() {
        const dialog = await masterpage.showPopup("new-connection");

        if (dialog.result === "confirm") {
            this.module.connections.push(dialog.values);
            this.module.templater.RenderFromObject({ "connections": this.module.connections }, "template#connection-item");
            this.module.initTableBindings();
        }
    }
}

class NewProject {
    constructor() {
        this.actions = new NewProjectActions(this);
        this.templater = new JsTemplater();
        this.connections = [];

        if (window.location.pathname === "/new-project")
            this.initBindings();
    }

    initBindings() {
        $("a.return-to-login").on("click", () => {
            window.location.href = "/";
        });

        $("a.button").on("click", (event) => {
            switch (event.currentTarget.dataset.action) {
                case "new-connection": this.actions.AddNewConnection(); break;
            }
        });

        $("#save-new-project").on("click", () => {
            this.actions.GenerateProject();
        });

        setInterval(() => {
            const name = $("input[name='project_name']").val();
            const domain = $("input[name='project_domain']").val();

            if (name !== "" && domain !== "" && newProject.connections.length > 0) {
                $("#save-new-project").removeClass("disabled");
            } else {
                $("#save-new-project").addClass("disabled");
            }
        }, 10);
    }

    initTableBindings() {
        $("table#new-project-connections .delete").on("click", (event) => {
            const index = parseInt(event.currentTarget.closest("tr").dataset.index);

            newProject.connections.splice(index, 1);

            this.templater.RenderFromObject({ "connections": this.connections }, "template#connection-item");
            this.initTableBindings();
        });
    }
}