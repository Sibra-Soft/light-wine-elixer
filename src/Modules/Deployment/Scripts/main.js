class DeploymentModuleActions {

}

class DeploymentModule {
    constructor() {
        this.actions = new DeploymentModuleActions();
        this.templater = new JsTemplater();
        this.id = utils.guid();

        this.init();
    }

    init() {
        document.querySelector("div.page#module-deployment").dataset.module = this.id;

        console.log("Ready -> Deployment module -> " + this.id);

        masterpage.addNewTaskbarElement("Deployment", this.id);

        this.resize();
        this.initBindings();
        this.getCommits();
    }

    resize() {
        const pageHeight = $(".page").height();

        $("div.page#module-deployment").height(pageHeight - 48 + "px");
    }

    initBindings() {
        $(window).on("resize", () => {
            this.resize();
        });

        $(".subnavbar button").on("click", (event) => {
            const tabName = event.currentTarget.dataset.showTab;

            $(`#module-deployment .card`).addClass("hide");
            $(`#module-deployment .card[data-tab-name='${tabName}']`).removeClass("hide");

            $(".subnavbar button").removeClass("button-active");
            $(event.currentTarget).addClass("button-active");
        });
    }

    async getCommits() {
        var request = await elixer.request.get("/deployments/get-commits");

        if (request.status == 200) {
            const commits = JSON.parse(request.data);
            
            commits.forEach((element, index) => {
                var fileItem = $("div.page#module-deployment template#commit-item-template").html();

                fileItem = fileItem.replace("{name}", element.name);
                fileItem = fileItem.replace("{date_modified}", element.date_modified);
                fileItem = fileItem.replace("{type}", element.type);
                fileItem = fileItem.replace("{version}", element.current_version);
                fileItem = fileItem.replace("{modified_by}", element.modified_by);
                fileItem = fileItem.replace("{type}", element.type);
                
                $("div.page#module-deployment table#commits-table tbody").append(fileItem);
            });
        }
    }
}

window.deploymentModule = new DeploymentModule();