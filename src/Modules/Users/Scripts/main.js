class UsersModuleActions {
    /**
     * Class constructor
     * @param {UsersModule} module
     */
    constructor(module) {
        this.module = module;
    }

    async NewRole() {
        elixer.dialog.prompt("Enter the name of the new role", "", (value) => {
            var request = elixer.request.post("/users/new-role", { "role_name": value });

            if (request.status == 200) {

            }
        });
    }

    async GetRoles() {
        const request = await elixer.request.get("/users/get-roles");
        const requestData = JSON.parse(request.data);

        if (request.status == 200) {
            this.module.templater.RenderFromObject(requestData, "#roles template#roles-item-template");
        }
    }

    /**
     * Search in the current view
     */
    Search() {
        elixer.dialog.prompt("Search", "", (value) => {
            $(`table#users-table tbody tr`).addClass("hide");
            $(`table#users-table td:icontains('${value}')`).each((index, element) => {
                element.closest("tr").classList.remove("hide");
            });

            $("a.button[data-action='delete_search']").removeClass("hide");
            $("a.button[data-action='search']").addClass("hide");
        });
    }

    /** Removes the active search */
    DeleteSearch() {
        $(`table#users-table tbody tr`).removeClass("hide");
        $("a.button[data-action='delete_search']").addClass("hide");
        $("a.button[data-action='search']").removeClass("hide");
    }
}

class UsersModule {
    constructor() {
        this.module = $("div.page#module-users");
        this.actions = new UsersModuleActions(this);
        this.views = new Views();
        this.templater = new JsTemplater();
        this.id = utils.guid();

        this.init();
    }

    init() {
        this.module = $("div.page#module-users");

        document.querySelector("div.page#module-users").dataset.module = this.id;

        console.log("Ready -> Users module -> " + this.id);

        masterpage.addNewTaskbarElement("Users &amp; Roles", this.id);

        this.resize();
        this.refreshDataTable();
        this.initBindings();
        this.actions.GetRoles();
    }

    async refreshDataTable() {
        await this.templater.Render("/users/get-users", "template#user-item-template");
        this.module.find(".loader-container").addClass("hide");
    }

    resize() {
        const pageHeight = this.module.find(".page").height();
        this.module.height(pageHeight - 48 + "px");
    }

    initBindings() {
        this.module.find("a.button").on("click", (event) => {
            switch (event.currentTarget.dataset.action) {
                case "roles": this.views.Show("roles"); break;
                case "new-user": this.views.Show("new-user"); break;
                case "remove": this.actions.Delete(); break;
                case "new-role": this.actions.NewRole(); break;
                case "search": this.actions.Search(); break;
                case "delete_search": this.actions.DeleteSearch(); break;
            }
        });

        this.module.find(".return-to-main").on("click", () => {
            this.views.Close();
        });
    }
}

window.usersModule = new UsersModule();