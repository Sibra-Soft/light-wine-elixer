﻿class RoutesModuleActions {
    /**
     * Constructor function
     * @param {RoutesModule} module
     */
    constructor(module) {
        this.module = module;
        this.parameters = [];
    }

    async Update() {

    }

    async AddParameterToRoute() {
        const popup = await masterpage.showPopup("add-parameter", {});

        if (popup.result === "confirm") {
            this.parameters.push(popup.values);
            this.module.templater.RenderFromObject({ "parameters": this.parameters }, "template#template-parameter-item");
        }
    }

    /** Adds a new route */
    async NewRoute() {
        const loader = elixer.dialog.preloader("Saving...");
        const routeType = $("input[name='type']:checked").val();
        const routeMethod = $("input[name='method']:checked").val();
        const routeDatasourceType = $("input[name='datasource']:checked").val();
        const routeDatasource = $("div.datasources div:not(.hide) select option:checked").val();
        const routeName = $("input[name='name']").val();
        const routePath = $("input[name='path']").val();;
        const routeParameters = [];

        const object = {
            "type": routeType,
            "method": routeMethod,
            "datasource_type": routeDatasourceType,
            "datasource": routeDatasource,
            "name": routeName,
            "path": routePath,
            "parameters": routeParameters
        };

        var request = await elixer.request.post("/routes/add", object);

        if (request.status == 200) {
            this.module.refreshDataTable();
            this.module.views.Close();

            loader.close();
        }
    }

    /** Deletes the selected routes */
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

    /** Publish a template */
    async Publish() {
        const selected = this.module.selected();
        const request = await elixer.request.post("/routes/publish", {
            "ids": selected.ids.join(",")
        });

        if (request.status == 200) {
            await this.module.refreshDataTable();
        }
    }

    /**
     * Search in the current view
     */
    Search() {
        elixer.dialog.prompt("Search", "", (value) => {
            $(`table#routes-table tbody tr`).addClass("hide");
            $(`table#routes-table td:icontains('${value}')`).each((index, element) => {
                element.closest("tr").classList.remove("hide");
            });

            $("a.button[data-action='delete_search']").removeClass("hide");
            $("a.button[data-action='search']").addClass("hide");
        });
    }

    /** Removes the active search */
    DeleteSearch() {
        $(`table#routes-table tbody tr`).removeClass("hide");
        $("a.button[data-action='delete_search']").addClass("hide");
        $("a.button[data-action='search']").removeClass("hide");
    }
}

class RoutesModule {
    constructor() {
        this.module = $("div.page#module-routes");
        this.rightClickElement = {};
        this.actions = new RoutesModuleActions(this);
        this.views = new Views();
        this.templater = new JsTemplater();
        this.id = utils.guid();
        this.init();
    }

    async init() {
        this.module = $("div.page#module-routes");

        masterpage.addNewTaskbarElement("Routes", this.id);

        document.querySelector("div.page#module-routes").dataset.module = this.id;

        console.log("Ready -> Routes module -> " + this.id);

        this.initBindings();
        this.resize();

        const datasources = await elixer.request.getJSON("/routes/get-datasources");

        await this.templater.RenderFromObject(datasources.data, "template#datasource-template-item");
        await this.templater.RenderFromObject(datasources.data, "template#datasource-query-item");
        await this.templater.RenderFromObject(datasources.data, "template#datasource-table-item");

        this.refreshDataTable();
        this.enableDisableControls(true);

        setInterval(() => {
            const path = $("input[name='path']").val();
            const name = $("input[name='name']").val();

            if (path !== "" && name !== "") {
                this.module.find("#btn-add-new-route").removeClass("disabled");
            } else {
                this.module.find("#btn-add-new-route").addClass("disabled");
            }
        }, 100);
    }

    async refreshDataTable() {
        await this.templater.Render("/routes/get", "template#route-item-template");
        this.module.find("table#routes-table tr[data-published=0] td:not(:first-child)").addClass("row-disabled");

        this.initTableBindings();

        this.module.find(".loader-container").addClass("hide");
    }

    initBindings() {
        $(window).on("resize", () => {
            this.resize();
        });

        this.module.find("a.button").on("click", (event) => {
            switch (event.currentTarget.dataset.action) {
                case "search": this.actions.Search(); break;
                case "add_route": this.views.Show("add-new-route"); break;
                case "remove": this.actions.Delete(); break;
                case "publish": this.actions.Publish(); break;
                case "add_paramter": this.actions.AddParameterToRoute(); break;
                case "delete_search": this.actions.DeleteSearch(); break;
            }
        });

        this.module.find(".return-to-main").on("click", () => {
            this.views.Close();
        });

        this.module.find("#table-search").on("keyup", (event) => {
            this.actions.Search(event.currentTarget.value);
        });

        this.module.find("input[name='type']").on("change", () => {
            this.enableDisableControls(true);
        });

        this.module.find("input[name='datasource']").on("change", () => {
            this.enableDisableControls(false);
        });

        this.module.find("#btn-add-new-route").on("click", () => {
            this.actions.NewRoute();
        });

        this.module.find("#routes-table tbody").sortable();
    }

    enableDisableControls(selectFirst) {
        const selectedRouteType = this.module.find("input[name='type']:checked").val();

        // Show the correct buttons
        this.module.find(".for").addClass("hide");
        this.module.find(`div.for.${selectedRouteType}-type`).removeClass("hide");

        // Select the route specific datasource
        if (selectFirst) {
            if (selectedRouteType === "redirect") {
                this.module.find("input[name='method'][value='get-301']").prop("checked", true);
            } else {
                this.module.find("input[name='method'][value='get']").prop("checked", true);
            }

            if (selectedRouteType === "page" || selectedRouteType === "redirect") {
                this.module.find("input[name='datasource'][value='template']").prop("checked", true);
            } else {
                this.module.find("input[name='datasource'][value='query']").prop("checked", true)
            }
        }

        // Show the correct datasource
        const datasourceType = $("input[name='datasource']:checked").val();
        this.module.find(`div.for.${datasourceType}-type`).removeClass("hide");
    }

    updateMetaTitle() {
        elixer.dialog.prompt("Enter a meta title", "", (value) => {
            this.actions.Update({ "meta_description": value });
        });
    }

    updateMetaDescription() {
        elixer.dialog.prompt("Enter a meta description", "", (value) => {
            this.actions.Update({ "meta_title": value });
        });
    }

    initTableBindings() {
        $.contextMenu({
            selector: '#routes-table tr',
            build: (trigger) => {
                this.rightClickElement = trigger[0];

                var items = {
                    edit: { name: "Edit" },
                    publish: { name: "Publish" },
                    delete: { name: "Remove" },
                    addMetaTitle: { name: "Add meta title" },
                    addMetaDescription: { name: "Add meta description" }
                };

                return {
                    callback: (key) => {
                        switch (key) {
                            case "delete": this.actions.Delete(); break;
                            case "addMetaDescription": this.updateMetaDescription(); break;
                            case "addMetaTitle": this.updateMetaTitle(); break;
                        }
                    },
                    items: items
                };
            }
        });

        // Enable or disable buttons based on the selected items
        this.module.find("table#routes-table td input[type='checkbox']").on("change", () => {
            const selectedItemCount = $("table#routes-table td input[type='checkbox']:checked").length;

            if (selectedItemCount > 0) {
                this.module.find("a.button[data-action='remove']").removeClass("disabled");
                this.module.find("a.button[data-action='publish']").removeClass("disabled");
            } else {
                this.module.find("a.button[data-action='remove']").addClass("disabled");
                this.module.find("a.button[data-action='publish']").addClass("disabled");
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

            this.module.find("#routes-table td.checkbox-cell input:checked").each((index, element) => {
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
        this.module.height(pageHeight - 48 + "px");
    }
}

window.routesModule = new RoutesModule();