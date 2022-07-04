class UsersModuleActions {
    /**
     * Class constructor
     * @param {UsersModule} module
     */
    constructor(module) {
        this.module = module;
    }

    async GetRoles() {
        const request = await elixer.request.get("/users/get-roles");
        const requestData = JSON.parse(request.data);

        if (request.status == 200) {
            this.module.templater.RenderFromObject(requestData, "#roles template#roles-item-template");
        }
    }
}

class UsersModule {
    constructor() {
        this.actions = new UsersModuleActions(this);
        this.views = new Views();
        this.templater = new JsTemplater();
        this.id = utils.guid();

        this.init();
    }

    async init() {
        document.querySelector("div.page#module-users").dataset.module = this.id;

        console.log("Ready -> Users module -> " + this.id);

        masterpage.addNewTaskbarElement("Users &amp; Roles", this.id);

        this.resize();
        this.initBindings();

        await this.templater.Render("/users/get-users", "template#user-item-template");

        this.actions.GetRoles();
    }

    resize() {
        const pageHeight = $(".page").height();

        $("div.page#module-users").height(pageHeight - 48 + "px");
    }

    initBindings() {
        $("a.button").on("click", (event) => {
            switch (event.currentTarget.dataset.action) {
                case "roles": this.views.Show("roles"); break;
                case "new-user": this.views.Show("new-user"); break;
                case "remove": this.actions.Delete(); break;
            }
        });

        $(".return-to-main").on("click", () => {
            this.views.Close();
        });
    }
}

window.usersModule = new UsersModule();