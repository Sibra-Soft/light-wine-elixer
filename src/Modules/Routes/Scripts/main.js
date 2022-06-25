class RoutesModuleActions {
    /**
     * Constructor function
     * @param {RoutesModule} module
     */
    constructor(module) {
        this.module = module;
    }

    Delete() {
        const selected = this.module.selected();

        elixer.dialog.confirm("Are you sure you want to delete the selected route(s)", "", async () => {
            const request = await elixer.request.post("/routes/delete", {
                "ids": selected.ids.join(",")
            });

            if (request.status == 200)
                $(selected.elements).fadeOut(800);
        });
    }

    /**
     * Search for a route based on the specified value
     * @param {string} value The name of the route you are searching for
     */
    Search(value) {
        $("div.page#module-routes table tr").addClass("hide");
        $(`div.page#module-routes table tr td.name:contains('${value}')`).closest("tr").removeClass("hide");
    }
}

class RoutesModule {
    constructor() {
        this.actions = new RoutesModuleActions(this);
        this.views = new Views();
        this.templater = new JsTemplater();
        this.id = utils.guid();
        this.init();
    }

    async init() {
        masterpage.addNewTaskbarElement("Routes", this.id);

        document.querySelector("div.page#module-routes").dataset.module = this.id;

        console.log("Ready -> Routes module -> " + this.id);

        this.initBindings();
        this.resize();

        await this.templater.Render("/routes/get", "template#route-item-template");
        this.initTableBindings();
    }

    initBindings() {
        $(window).on("resize", () => {
            this.resize();
        });

        $("a.button").on("click", (event) => {
            switch (event.currentTarget.dataset.action) {
                case "search": alert("search"); break;
                case "add-route": this.views.Show("add-new-route"); break;
                case "remove": this.actions.Delete(); break;
            }
        });

        $(".return-to-main").on("click", () => {
            this.views.Close();
        });

        $("#table-search").on("keyup", (event) => {
            this.actions.Search(event.currentTarget.value);
        });

        $("#routes-table tbody").sortable();
    }

    initTableBindings() {
        // Enable or disable buttons based on the selected items
        $("table#routes-table td input[type='checkbox']").on("change", () => {
            const selectedItemCount = $("table#routes-table td input[type='checkbox']:checked").length;

            if (selectedItemCount > 0) {
                $("a.button[data-action='remove']").removeClass("disabled");
            } else {
                $("a.button[data-action='remove']").addClass("disabled");
            }
        });
    }

    /** Get the selected files (single or multiple) */
    selected() {
        var returnObject = {};
        const multiple = $("#routes-table td.checkbox-cell input:checked").length;

        if (multiple > 0) {
            var ids = [];
            var elements = [];

            $("#routes-table td.checkbox-cell input:checked").each((index, element) => {
                const rowId = parseInt(element.closest("tr").dataset.id);

                ids.push(rowId);
                elements.push(element.closest("tr"));
            });

            returnObject = {
                "multiple": true,
                "count": multiple,
                "elements": elements,
                "ids": ids
            };
        } else {
            returnObject = {
                "multiple": false,
                "count": 1,
                "elements": this.rightClickElement,
                "ids": parseInt(this.rightClickElement.dataset.id)
            };
        }

        return returnObject;
    }

    resize() {
        const pageHeight = $(".page").height();

        $("div.page#module-routes").height(pageHeight - 48 + "px");
    }
}

window.routesModule = new RoutesModule();