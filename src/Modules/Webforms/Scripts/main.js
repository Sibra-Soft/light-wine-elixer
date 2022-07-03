class WebformsModule {
    constructor() {
        this.form = {};

        this.views = new Views();
        this.id = utils.guid();
        this.init();
    }

    init() {
        masterpage.addNewTaskbarElement("Webforms", this.id);

        document.querySelector("div.page#module-webforms").dataset.module = this.id;

        console.log("Ready -> Webforms module -> " + this.id);

        this.initFormEditor();
        this.initBindings();
    }

    initBindings() {
        $(".return-to-main").on("click", () => {
            this.views.Close();
        });

        $("#module-webforms .data-table-links a[data-action]").on("click", (event) => {
            const action = event.currentTarget.dataset.action;

            switch (action) {
                case "new-webform": this.views.Show("add-new-webform"); break;
            }
        });
    }

    initFormEditor() {
        this.form = new FormeoEditor({
            editorContainer: '#formeo-editor',
            svgSprite: 'https://draggable.github.io/formeo/assets/img/formeo-sprite.svg',
            events: {
                onSave: (event) => {
                    console.log(event);
                }
            }
        });
    }
}

window.webformsModule = new WebformsModule();