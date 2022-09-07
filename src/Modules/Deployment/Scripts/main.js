class DeploymentModuleActions {
    /**
     * Class constructor
     * @param {DeploymentModule} module
     */
    constructor(module) {
        this.module = module;
    }

    CommitTemplates() {
        const selected = this.module.selected();

        this.module.templater.RenderFromObject(selected, "template#template-commit-item")
        this.module.views.Show("commit-templates");

        $("#btn-commit").on("click", async (event) => {
            event.preventDefault();

            const commitDescription = $("input[name='commit-description']").val();

            // Get the selected environments
            var environments = $("input#env-acceptance:checked,input#env-test:checked").map((index, element) => {
                return $(element).val();
            }).get();

            // Get the selected templates to commit
            var ids = $("table#templates-to-commit tr").map((index, element) => {
                return $(element).data("id");
            }).get();

            // Commit the templates using a request
            const parameters = {"items": ids, "enviroments": environments, "description":commitDescription};
            const request = await elixer.request.post("/deployments/commit", parameters);

            if (request.status == 200) {
                await this.module.templater.Render("/deployments/get-commits", "template#commit-item-template");
                this.module.views.Close();
            }
        });

        $("#templates-to-commit tbody .delete").on("click", (event) => {
            event.currentTarget.closest("tr").remove();
        });

        setInterval(() => {
            const enviromentSelected = $("input#env-acceptance").prop("checked") || $("input#env-test").prop("checked");
            const description = $("input[name='commit-description']").val();

            if (selected.count > 0 && enviromentSelected && description !== "") {
                $("#btn-commit").removeClass("disabled");
            } else {
                $("#btn-commit").addClass("disabled");
            }
        }, 10);
    }
}

class DeploymentModule {
    constructor() {
        this.module = $("div.page#module-deployment");
        this.actions = new DeploymentModuleActions(this);
        this.views = new Views();
        this.templater = new JsTemplater();
        this.id = utils.guid();

        this.init();
    }

    init() {
        this.module = $("div.page#module-deployment");

        document.querySelector("div.page#module-deployment").dataset.module = this.id;

        console.log("Ready -> Deployment module -> " + this.id);

        masterpage.addNewTaskbarElement("Deployment", this.id);

        this.resize();
        this.initBindings();
        this.refreshDataTable();
    }

    async refreshDataTable() {
        await this.templater.Render("/deployments/get-commits", "template#commit-item-template");
        this.initTableBindings();

        this.module.find(".loader-container").addClass("hide");
    }

    resize() {
        const pageHeight = $(".page").height();
        this.module.height(pageHeight - 48 + "px");
    }

    selected() {
        var returnObject = {};
        var multiple = $("#commits-table td.checkbox-cell input:checked").length;

        if (multiple > 0) {
            var ids = [];
            var elements = [];
            var items = [];
            const rowHeaders = [];

            // Get the headers
            this.module.find("#commits-table thead th.label-cell").each((index, element) => {
                rowHeaders.push(element.innerText.toLowerCase().replace(" ", "_"));
            });

            // Gets the items per row
            this.module.find("#commits-table td.checkbox-cell input:checked").each((index, element) => {
                const rowId = parseInt(element.closest("tr").dataset.id);
                const rowElement = element.closest("tr");
                const item = {};

                ids.push(rowId);

                rowElement.querySelectorAll("td.label-cell").forEach((element, index) => {
                    item[rowHeaders[index]] = element.innerText.trim();
                });

                items.push(item);
            });

            returnObject = {
                "headers": rowHeaders,
                "multiple": true,
                "count": multiple,
                "elements": elements,
                "ids": ids,
                "items": items
            };
        }

        return returnObject;
    }

    initBindings() {
        $(window).on("resize", () => {
            this.resize();
        });

        this.module.find(".subnavbar button").on("click", (event) => {
            const tabName = event.currentTarget.dataset.showTab;

            $(`#module-deployment .card`).addClass("hide");
            $(`#module-deployment .card[data-tab-name='${tabName}']`).removeClass("hide");

            $(".subnavbar button").removeClass("button-active");
            $(event.currentTarget).addClass("button-active");
        });

        this.module.find(".return-to-main").on("click", () => {
            this.views.Close();
        });

        this.module.find(".button").on("click", (event) => {
            const action = event.currentTarget.dataset.action;

            switch (action) {
                case "commit": this.actions.CommitTemplates(); break;
            }
        });

        setInterval(() => {
            if (deploymentModule.selected().count > 0) {
                this.module.find(".button[data-action='commit']").removeClass("disabled");
            } else {
                this.module.find(".button[data-action='commit']").addClass("disabled");
            }
        }, 100);
    }

    initTableBindings() {

    }
}

window.deploymentModule = new DeploymentModule();