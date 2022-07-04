class Masterpage {
    constructor() {
        this.taskbar = [];

        this.init();
        this.initBindings();
    }

    init() {
        window.elixer = new Framework7({
            el: '#app',
            name: 'Elixer',
            id: 'elixer',
            theme: 'aurora'
        });

        if (window.location.pathname === "/dashboard")
            this.addNewTaskbarElement("Welcome", "95a2e176-ce01-4762-9681-1f9205d33ae9", false);
    }

    addNewTaskbarElement(name, module, closeable = true) {
        var taskbarChip = $("#taskbar-chip-template").prop('outerHTML');

        taskbarChip = taskbarChip.replace("{name}", name);
        taskbarChip = taskbarChip.replace("{module}", module);

        $("#taskbar").append(taskbarChip);
        $(`#taskbar .chip .chip-label a[data-module="${module}"]`).closest(".chip").removeClass("hide");

        if (closeable == false)
            $(`#taskbar .chip .chip-label a[data-module="${module}"]`).closest(".chip").find(".chip-delete").remove();

        this.taskbar.push({
            "name": name,
            "module": module
        });

        this.initTaskbarBindings();
    }

    initTaskbarBindings() {
        // Switch between modules
        $('#taskbar .chip a:not([data-module="{module}"]):not(.chip-delete)').off();
        $('#taskbar .chip a:not([data-module="{module}"]):not(.chip-delete)').on("click", (event) => {
            const module = event.currentTarget.dataset.module;

            $(".view .page[data-module]").addClass("hide");
            $(`.view .page[data-module='${module}']`).removeClass("hide");
        });

        // Remove the module and the taskbar entry
        $('#taskbar .chip a:not([data-module="{module}"]).chip-delete').off();
        $('#taskbar .chip a:not([data-module="{module}"]).chip-delete').on("click", (event) => {
            const module = event.currentTarget.closest(".chip").querySelector(".chip-label a").dataset.module;

            $(`.view .page[data-module='${module}']`).remove();
            $(`.chip-label a[data-module='${module}']`).closest("div#taskbar-chip-template").remove();
        });
    }

    initBindings() {
        $(".open-module").off();
        $(".open-module").on("click", async (event) => {
            event.preventDefault();

            const defaultImage = event.currentTarget.querySelector("img").src;
            const name = event.currentTarget.dataset.name;

            event.currentTarget.querySelector("img").src = document.querySelector(".loader-image").src;

            const location = new URL(event.currentTarget.href);
            const resp = await elixer.request.get(location.pathname + "?masterpage=false");

            $(".view-main").append(resp.data);
            elixer.views.main.init();

            event.currentTarget.querySelector("img").src = defaultImage;

            loader.Require(name, "main");
        });

        $(".popover a.item-link[data-name]").off();
        $(".popover a.item-link[data-name]").on("click", (event) => {
            const actionName = event.currentTarget.dataset.name;

            switch (actionName) {
                case "templates-module": this.openModule("templates"); break;
                case "file-explorer-module": this.openModule("file-explorer"); break;
                case "routes-module": this.openModule("routes"); break;
                case "deployment-module": this.openModule("deployment"); break;
                case "users-roles-module": this.openModule("users"); break;
            }
        });
    }

    /**
     * Open a specifie module, based on the name
     * @param {string} name The name of the module you want to open
     */
    openModule(name) {
        $(`a.open-module[data-name=${name}]`).trigger("click");
    }

    getPopupOutput() {
        var object = {};

        document.querySelectorAll(".return-value").forEach((element, index) => {
            var inputType = element.type;
            var inputName = element.name;

            switch (inputType) {
                case "radio":
                    if (element.checked) {
                        object[inputName] = element.value;
                    }
                    break;

                case "text":
                    object[inputName] = element.value;
                    break;

                case "select-one":
                    object[inputName] = element.value;
                    break;
            }
        });

        return object;
    }

    async showPopup(name, parameters = {}) {
        $(".popup").remove(); // Remove all added popups

        return new Promise(async (resolve, reject) => {
            const template = await elixer.request.post(`/dialogs/${name}?masterpage=false`, parameters);

            $("body").append(template.data);
            elixer.popup.open(`#popup-${name}`);

            $(`#popup-${name} .close-popup`).off();
            $(`#popup-${name} .close-popup`).on("click", () => {
                var returnObject = { "result": "cancel", "values": this.getPopupOutput() };

                elixer.popup.close(`#popup-${name}`);

                returnObject.result = "cancel";
                resolve(returnObject);
            });

            $(`#popup-${name} .confirm`).off();
            $(`#popup-${name} .confirm`).on("click", () => {
                var returnObject = { "result": "confirm", "values": this.getPopupOutput() };

                elixer.popup.close(`#popup-${name}`);

                returnObject.result = "confirm";
                resolve(returnObject);
            });
        });
    }
}

$(document).ready(function () {
    window.utils = new Utils();
    window.masterpage = new Masterpage();
    window.login = new Login();
    window.loader = new Loader();
});