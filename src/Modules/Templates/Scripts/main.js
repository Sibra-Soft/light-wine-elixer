class TemplateModuleActions {
    /**
     * Class constructor
     * @param {TemplatesModule} module
     */
    constructor(module) {
        this.module = module;
    }

    /** Add new external file to the database */
    AddExternalFile() {

    }

    async AddBinding(id) {
        const popup = await masterpage.showPopup("new-binding", {
            "template_id": id
        });

        if (popup.result === "confirm") {
            const request = await elixer.request.post("/templates/new-binding", {
                "name": popup.values.binding_name,
                "template_id": parseInt(id),
                "datasource": parseInt(popup.values.datasource_template)
            });

            if (request.status == 200) {
                this.module.populateTreeview();
            }
        }
    }

    /**
     * Show the properties dialog for the specified template
     * @param {number} id The id of the template you want to show the properties of
     */
    async Properties(id) {
        const popup = await masterpage.showPopup("template-properties", {
            "template_id": id
        });

        if (popup.result === "confirm") {

        }
    }

    /** Save the content of the template to the database */
    async SaveTemplate() {
        const toast = elixer.toast.create({ "text": "Saving..." });
        toast.open();

        const content = this.module.codeMirror.getValue();
        const request = await elixer.request.post("/templates/save", {
            "template_id": this.module.template.Id,
            "content": content
        });

        var responseData = JSON.parse(request.data);
        if (request.status == 200) {
            $("#save-template").addClass("disabled");
            $("#template-info-bar").html(`Template: <strong>${responseData.name} (${responseData.template})</strong> - Version: <strong>${responseData.version}</strong>`)

            toast.close();
        }          
    }

    /**
     * Copy a template to a specified folder
     * @param {number} id The id of the template you want to copy
     * @param {number} targetFolderId The folder you want to copy the template to
     */
    async Copy(id) {
        const targetFolderId = await this.module.showFolderBrowserDialog();

        const request = await elixer.request.post("/templates/copy", {
            "template_id": id,
            "target": targetFolderId
        });

        if (request.status == 200) {

        }
    }

    /**
     * Move a specified template to a specified folder
     * @param {number} id The if of the template you want to move
     * @param {number} targetFolderId The id of the folder you want to move the template to
     */
    async Move(id) {
        const targetFolderId = await this.module.showFolderBrowserDialog();

        const request = await elixer.request.post("/templates/move", {
            "template_id": id,
            "target": targetFolderId
        });

        if (request.status == 200) {

        }
    }

    /**
     * Delete treeview item
     * @param {number} id The id of the record in the database
     * @param {object} element The element of the treeview
     */
    Delete(id, element) {
        elixer.dialog.confirm("Are you sure you want to delete the selected item", "", async (event) => {
            const response = await elixer.request.post("/templates/delete", { "template_id": id });

            if (response.status == 200) {
                element.remove();
                this.module.refreshFolderView();
            }
        });
    }

    /**
     * Rename a treeview item
     * @param {number} id The id of the record in the database
     * @param {object} element The element of the treeview
     */
    Rename(id, element) {
        const currentName = element.querySelector(".treeview-item-label").innerText;

        elixer.dialog.prompt("Rename", "", async (value) => {
            const response = await elixer.request.post("/templates/rename", {
                "template_id": id,
                "new_name": value
            });

            if (response.status == 200) {
                element.querySelector(".treeview-item-label").innerText = value;
            }
        }, $.noop, currentName);
    }

    /**
     * Search for a template in the treeview
     * @param {string} name The name of the template
     */
    Search(name) {
        $(".treeview-item .treeview-item-label").removeClass("bold");
        $(".treeview-item .treeview-item-label").filter(`:contains('${name}')`).each((index, element) => {
            element.classList.add("bold")
        });
    }

    /**
     * Add a new template to the database
     */
    async AddTemplate(parent) {
        const popup = await masterpage.showPopup("add-template");

        if (popup.result === "confirm") {
            const request = await elixer.request.post("/templates/add-template", {
                "name": popup.values.template_name,
                "folder": parent,
                "type": popup.values.template_type
            });

            if (request.status == 200)
                this.module.populateTreeview();
        }
    }

    /**
     * Add a new folder to the treeview
     * @param {number} parent The id of the parent record you want to add the folde to
     */
    AddFolder(parent) {
        elixer.dialog.prompt("Add new folder", "", (value) => {
            const data = {
                "parent": parent,
                "name": value
            };

            elixer.request.post("/templates/add-folder", data).then((resp) => {
                this.module.populateTreeview();
            });
        });
    }
}

class TemplatesModule {
    constructor() {
        this.id = utils.guid();
        this.actions = new TemplateModuleActions(this);
        this.template = {};
        this.codeMirror = {};

        this.init();
    }

    init() {
        document.querySelector("div.page#module-templates").dataset.module = this.id;

        this.populateTreeview();
        this.initBindings();
        this.resize();

        console.log("Ready -> Templates module -> " + this.id);

        masterpage.addNewTaskbarElement("Templates", this.id);
    }

    /** Show the folder browser dialog */
    showFolderBrowserDialog() {
        return new Promise(async (resolve, reject) => {
            let selectedFolder = 0;

            $("#general-popup .page-content .content-container").html($(".treeview.folders").html());
            elixer.popup.open("#general-popup");

            // Only show folders in the dialog
            $("#general-popup .treeview-item:not([data-type='folder'])").addClass("hide");

            $("#general-popup .treeview-item-root").off();
            $("#general-popup .treeview-item-root").on("click", (event) => {
                $("#general-popup .treeview-item-selected").removeClass("treeview-item-selected");
                $(event.currentTarget).addClass("treeview-item-selected");

                selectedFolder = event.currentTarget.closest(".treeview-item").dataset.id;
                console.log(selectedFolder);
            })

            $("#general-popup .confirm").off();
            $("#general-popup .confirm").on("click", (event) => {
                elixer.popup.close("#general-popup");
                resolve(selectedFolder);
            });

            $("#general-popup .close-popup").off();
            $("#general-popup .close-popup").on("click", (event) => {
                elixer.popup.close("#general-popup");
                reject();
            });
        });
    }

    resize() {
        const pageHeight = $(".page").height();

        $($('.col.resizable')[0]).css("width", "calc(20% - (var(--f7-cols-per-row) - 1) * var(--f7-grid-gap) / var(--f7-cols-per-row))");
        $($('.col.resizable')[1]).css("width", "calc(80% - (var(--f7-cols-per-row) - 1) * var(--f7-grid-gap) / var(--f7-cols-per-row))");

        $("div.treeview").height(pageHeight - 96 + "px");
        $("div.CodeMirror").height(pageHeight - 96 - 21 + "px");
    }

    initBindings() {
        $(window).on("resize", () => {
            this.resize();
        });

        $("#save-template").on("click", (event) => {
            this.actions.SaveTemplate();
        });

        $(".link#search").on("click", () => {
            elixer.dialog.prompt("Search for template", "", async (value) => {
                this.actions.Search(value);
            });
        });
    }

    initTreeviewBindings() {
        $(".treeview-item-content").off();
        $(".treeview-item-content").on("click", async (event) => {
            const element = event.currentTarget;
            const elementItem = element.closest(".treeview-item");
            const type = element.closest(".treeview-item").dataset.type;
            const templateId = element.closest(".treeview-item").dataset.id;

            if (type == 'folder' || type == "binding")
                return;

            $(".treeview-item-selected").removeClass("treeview-item-selected");
            $(elementItem).addClass("treeview-item-selected");

            const loader = elixer.dialog.preloader();
            const request = await elixer.request.get(`/templates/get?template_id=${templateId}`);
            const template = JSON.parse(request.data);

            $("#template-info-bar").html(`Template: <strong>${template.Name} (${template.Id})</strong> - Version: <strong>${template.Version}</strong>`)

            $(".CodeMirror").remove();
            this.initCodeMirror(template.Type);
            this.template = template;

            this.codeMirror.setValue(template.Content);
            loader.close();

            $("#save-template").addClass("disabled");
        });

        $.contextMenu({
            selector: '.treeview-item',
            build: (trigger, event) => {
                const element = trigger[0];
                const id = element.dataset.id;
                const group = element.dataset.group;

                var items = {
                    open: { name: "Open" },
                    newFolder: { name: "Add folder" },
                    newTemplate: { name: "Add template" },
                    newBindng: { name: "Add binding" },
                    move: { name: "Move" },
                    copy: { name: "Copy" },
                    delete: { name: "Delete" },
                    rename: { name: "Rename" },
                    properties: { name: "Properties" },
                    cdnPackages: { name: "Content Delivery Network" }
                };

                console.log(group);

                switch (group) {
                    case "binding":
                    case "template":
                        items["newTemplate"].className = "context-disabled";
                        items["newFolder"].className = "context-disabled";
                        break;

                    case "folder":
                        items["open"].className = "context-disabled";
                        items["properties"].className = "context-disabled";
                        items["move"].className = "context-disabled";
                        items["copy"].className = "context-disabled";
                        items["newBindng"].className = "context-disabled";
                        break;
                }

                return {
                    callback: (key) => {
                        switch (key) {
                            case "newFolder": this.actions.AddFolder(id); break;
                            case "newTemplate": this.actions.AddTemplate(id); break;
                            case "delete": this.actions.Delete(id, element); break;
                            case "rename": this.actions.Rename(id, element); break;
                            case "properties": this.actions.Properties(id); break;
                            case "copy": this.actions.Copy(id); break;
                            case "move": this.actions.Move(id); break;
                            case "newBindng": this.actions.AddBinding(id); break;
                        }
                    },
                    items: items
                };
            }
        });
    }

    /**
     * Initialize the Codemirror editor based on the specified type
     * @param {any} type The type of code you want to edit
     */
    initCodeMirror(type = "html") {
        var templateType = "";

        switch (type) {
            case "html": templateType = { name: "htmlmixed" }; break;
            case "sql": templateType = { name: "text/x-mariadb" }; break;
            case "javascript": templateType = { name: "javascript" }; break;
            case "css": templateType = { name: "css" }; break;
            case "module": templateType = { name: "text/x-php" }; break;
            case "worker": templateType = { name: "htmlmixed" }; break;
        }

        this.codeMirror = CodeMirror.fromTextArea(document.getElementById("coremirror"), {
            mode: templateType,
            gutters: ["CodeMirror-linenumbers", "breakpoints"],
            selectionPointer: true,
            lineNumbers: true,
            matchBrackets: true,
            autofocus: true,
            matchTags: { bothTags: true },
            lineWrapping: true,
            indentWithTabs: true,
            smartIndent: true,
            tabSize: 4,
            indentUnit: 3,
            styleActiveLine: true,
            extraKeys: {
                "Ctrl-S": async (instance) => {
                    await this.actions.SaveTemplate();
                }
            }
        });

        this.codeMirror.on("change", function () {
            $("#save-template").removeClass("disabled");
        });

        this.resize();
    }

    /** Populate the treeview with items from the database */
    async populateTreeview() {
        const treeview = await elixer.request.get("/templates/treeview");
        const elements = JSON.parse(treeview.data);

        // Remove all treeview items
        $(".treeview.folders[data-treeview-key='root'] div.treeview-item").remove();

        var lastParent = "root";
        var treeviewSubItem = document.createElement("div");

        elements.forEach((element, index) => {
            var treeviewItem = $("template#treeview-item").html();
            var parent = element.parent_key.toLowerCase();

            if (parent !== lastParent) {
                treeviewSubItem = document.createElement("div");
                treeviewSubItem.className = "treeview-item-children";

                $(`[data-treeview-key='${parent}']`).append(treeviewSubItem);
            }

            treeviewItem = treeviewItem.replaceAll("{caption}", element.name);
            treeviewItem = treeviewItem.replaceAll("{icon}", element.type);
            treeviewItem = treeviewItem.replaceAll("{key}", element.object_key.toLowerCase());
            treeviewItem = treeviewItem.replaceAll("{id}", element.id);
            treeviewItem = treeviewItem.replaceAll("{type}", element.type.toLowerCase());
            treeviewItem = treeviewItem.replaceAll("{group}", element.group.toLowerCase());

            if (parent !== lastParent) {
                treeviewSubItem.insertAdjacentHTML("beforeend", treeviewItem);
            } else {
                if (parent === "root") {
                    $(`[data-treeview-key='${parent}']`).append(treeviewItem);
                } else {
                    treeviewSubItem.insertAdjacentHTML("beforeend", treeviewItem);
                }
            }

            lastParent = parent;
        });

        this.initTreeviewBindings();
        this.refreshFolderView();
    }

    refreshFolderView() {
        // Hide toggels for folders without items
        $(".treeview-item").each((index, element) => {
            var subItems = element.querySelectorAll(".treeview-item-children .treeview-item");

            if (subItems.length == 0) {
                const toggleElement = element.querySelector(".treeview-toggle");

                if (toggleElement) {
                    toggleElement.remove();
                }
            }
        });
    }
}

window.templatesModule = new TemplatesModule();