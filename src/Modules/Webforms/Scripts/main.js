class WebformsModule {
    constructor() {
        this.id = utils.guid();
        this.init();
    }

    init() {
        masterpage.addNewTaskbarElement("Webforms", this.id);

        document.querySelector("div.page#module-webforms").dataset.module = this.id;

        console.log("Ready -> Webforms module -> " + this.id);
    }
}

window.webformsModule = new WebformsModule();