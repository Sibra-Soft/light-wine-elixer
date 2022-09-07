class ComponentsModuleActions {
    async AddNewComponent() {
        masterpage.showPopup("select-component", {}, () => {
            $("#popup-select-component a.component").on("click", (event) => {
                const componentType = event.currentTarget.dataset.type;

                elixer.dialog.prompt("Enter the name of the new component", "", async (value) => {
                    const request = await elixer.request.post("/components/create", {
                        "type": componentType,
                        "name": value
                    });

                    elixer.popup.close(`#popup-select-component`);

                    await componentsModule.refreshDataTable();
                })
            });
        })
    }

    async SaveChanges() {

    }
}

/** Componenets module main class */
class ComponentsModule {
    constructor() {
        this.module = $("div#module-components");
        this.actions = new ComponentsModuleActions();
        this.templater = new JsTemplater();
        this.views = new Views();
        this.id = utils.guid();
        this.init();
    }

    async init() {
        this.module = $("div#module-components");

        document.querySelector("div.page#module-components").dataset.module = this.id;

        console.log("Ready -> Components module -> " + this.id);

        masterpage.addNewTaskbarElement("Components", this.id);

        this.resize();
        this.initBindings();
        this.refreshDataTable();
    }

    async refreshDataTable() {
        this.module.find("a.button:not(.disabled)").addClass("disabled");
        this.module.find("#components-table a").addClass("disabled");

        await this.templater.Render("/components/get", "template#component-item");
        this.initTableBindings();

        this.module.find(".loader-container").addClass("hide"); // Hide the loader when loading is finished
        this.module.find("a.button.after-loading").removeClass("disabled"); // Enable the buttons after loading is finished
    }

    initTableBindings() {
        this.module.find("#components-table a").off();
        this.module.find("#components-table a").on("click", (event) => {
            const componentId = event.currentTarget.dataset.id;

            this.buildHtml(componentId);
        });
    }

    fillDropdownWithValues(type, values, currentValue = "") {
        const template = '<option value="{value}" {state}>{caption}</option>'
        let returnValue = "";

        if (type == "ClassList") {
            for (const key in values) {
                var optionTemplate = template.replace("{value}", values[key]);
                var state = "";

                if (values[key] === parseInt(currentValue)) state = "selected";

                optionTemplate = optionTemplate.replace("{state}", state);
                optionTemplate = optionTemplate.replace("{caption}", key);

                returnValue = returnValue + optionTemplate;
            }
        } else {
            console.log(currentValue);

            values.forEach((element, index) => {
                var optionTemplate = template.replace("{value}", element.id);
                var state = "";

                if (element.name === currentValue) state = "selected";

                optionTemplate = optionTemplate.replace("{state}", state);
                optionTemplate = optionTemplate.replace("{caption}", element.name);

                returnValue = returnValue + optionTemplate;
            })
        }

        return returnValue;
    }

    async buildHtml(componentId) {
        const loader = elixer.dialog.preloader("Please wait...");

        this.module.find(".control-container").html(""); // reset the control container

        var fields = await elixer.request.getJSON("/components/get-layout?component=" + componentId);
        var dropdownTemplate = document.querySelector("template#dropdown-field").innerHTML;
        var inputTemplate = document.querySelector("template#input-field").innerHTML;
        var checkboxTemplate = document.querySelector("template#checkbox-field").innerHTML;
        var codeMirrorTemplate = document.querySelector("template#codemirror-field").innerHTML;

        fields.data.fields.forEach((element, index) => {
            switch (element.Type) {
                case "dropdown":
                    var template = dropdownTemplate;
                    var dropdownOptions = this.fillDropdownWithValues(element.Values.Type, element.Values.Values, element.Value);

                    template = template.replace("{field_caption}", element.Caption);
                    template = template.replace("{field_name}", element.Name);
                    template = template.replace("{field_remark}", element.Remark);
                    template = template.replace("{field_remark_developer}", element.RemarkDeveloper);
                    template = template.replace("{values}", dropdownOptions);

                    $(".control-container").append(template);

                    if (!element.Remark) {
                        $(`select[name='${element.Name}']`).closest("div.form-group")[0].querySelector("i.remark-info").classList.add("hide");
                    }

                    if (!element.RemarkDeveloper) {
                        $(`select[name='${element.Name}']`).closest("div.form-group")[0].querySelector("i.developer-info").classList.add("hide");
                    }
                    break;

                case "input", "string":
                    var template = inputTemplate;

                    template = template.replace("{field_caption}", element.Caption);
                    template = template.replace("{field_name}", element.Name);
                    template = template.replace("{field_remark}", element.Remark);
                    template = template.replace("{field_remark_developer}", element.RemarkDeveloper);
                    template = template.replace("{field_value}", element.Value);

                    $(".control-container").append(template);
                    break;

                case "checkbox", "boolean":
                    var template = checkboxTemplate;

                    template = template.replace("{field_caption}", element.Caption);
                    template = template.replace("{field_name}", element.Name);
                    template = template.replace("{field_remark}", element.Remark);
                    template = template.replace("{field_remark_developer}", element.RemarkDeveloper);
                    template = template.replace("{field_value}", element.Value);

                    if (element.Value == 1) {
                        template = template.replace("{field_state}", "checked");
                    }

                    $(".control-container").append(template);
                    break;

                case "codemirror":
                    var template = codeMirrorTemplate;

                    template = template.replace("{field_caption}", element.Caption);
                    template = template.replace("{field_name}", element.Name);
                    template = template.replace("{field_remark}", element.Remark);
                    template = template.replace("{field_remark_developer}", element.RemarkDeveloper);
                    template = template.replace("{field_value}", element.Value);

                    $(".control-container").append(template);
                    break;
            }
        });

        this.module.find(".tooltip-init").each((index, element) => {
            elixer.tooltip.create({
                targetEl: element,
                text: element.dataset.tooltip
            });
        });

        setTimeout(() => {
            $("textarea").each((index, element) => {
                CodeMirror.fromTextArea(element, {
                    lineNumbers: true
                });
            });
        }, 100);

        this.views.Show("new-component");
        loader.close();
    }

    resize() {
        const pageHeight = $(".page").height();
        this.module.height(pageHeight - 48 + "px");
    }

    initBindings() {
        $(window).on("resize", () => {
            this.resize();
        });

        this.module.find(".return-to-main").on("click", () => {
            this.views.Close();
        });

        this.module.find("a.button").on("click", (event) => {
            switch (event.currentTarget.dataset.action) {
                case "new_component": this.actions.AddNewComponent(); break;
            }
        });

        this.module.find("input#save-component").on("click", () => {
            $(".control-container input,.control-container textarea,.control-container select").each((index, element) => {
                console.log(element.name, element.value);
            });
        });
    }
}

window.componentsModule = new ComponentsModule();