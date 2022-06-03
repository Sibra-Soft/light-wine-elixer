class RoutesModuleActions {
    /**
     * Constructor function
     * @param {RoutesModule} module
     */
    constructor(module) {
        this.module = module;
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
        this.id = utils.guid();
        this.init();
    }

    init() {
        masterpage.addNewTaskbarElement("Routes", this.id);

        document.querySelector("div.page#module-routes").dataset.module = this.id;

        console.log("Ready -> Routes module -> " + this.id);

        this.initBindings();
        this.resize();
        this.getRoutes();
    }

    initBindings() {
        $(window).on("resize", () => {
            this.resize();
        });

        $("a.button[data-actions='search']").on("click", () => {
            $(".searchbar").addClass("searchbar-enabled");
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

    resize() {
        const pageHeight = $(".page").height();

        $("div.page#module-routes").height(pageHeight - 48 + "px");
    }

    /** Get all the routes from a query */
    async getRoutes() {
        const request = await elixer.request.get("/routes/get");

        if (request.status == 200) {
            const routes = JSON.parse(request.data);

            routes.forEach((element, index) => {
                var fileItem = $("div.page#module-routes template#route-item-template").html();
                var color = "";

                // Get the color based on the method
                switch (element.method.toLowerCase()) {
                    case "post": color = "blue"; break;
                    case "get": color = "green"; break;
                    case "put": color = "orange"; break;
                    case "delete": color = "red"; break;
                }

                fileItem = fileItem.replace("{name}", element.name);
                fileItem = fileItem.replace("{method}", element.method);
                fileItem = fileItem.replace("{color}", color);
                fileItem = fileItem.replace("{path}", element.url);
                fileItem = fileItem.replace("{date_created}", element.date_created);
                fileItem = fileItem.replace("{type}", element.type);

                $("div.page#module-routes table#routes-table tbody").append(fileItem);
            });

            this.initTableBindings();
        }
    }
}

window.routesModule = new RoutesModule();