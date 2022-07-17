class TemplateModuleActions {
    /**
     * Class constructor
     * @param {TemplatesModule} module
     */
    constructor(module) {
        this.module = module;
    }

    /**
     * Closes the specified template based on the uniqueId
     * @param {any} uniqueId The uniqueId of the template you want to close
     */
    CloseTemplate(uniqueId) {
        $(`#editor-tabs li[data-id='${uniqueId}']`).remove();
        $(`.editors .editor[data-id='${uniqueId}']`).remove();

        delete this.module.editors[uniqueId];
    }

    /**
     * Opens the specified template in a CodeMirror editor
     * @param {number} templateId The id of the template you want to open
     */
    async OpenTemplate(templateId) {
        const uniqueId = utils.guid();
        const loader = elixer.dialog.preloader();
        const request = await elixer.request.get(`/templates/get?template_id=${templateId}`);
        const template = JSON.parse(request.data);
        const editorHtml = $("#editor-template").html();

        let instance = {};

        $(".editors .editor").addClass("hide"); // Hide all editors
        $(".editors").append(editorHtml); // Add a new editor

        // Sets the statusbar of the current editor
        document.querySelector(".editors .editor:last-child").dataset.id = uniqueId;
        document.querySelector(".editors .editor:last-child #template-info-bar").innerHTML = `Template: <strong>${template.Name} (${template.Id})</strong> - Version: <strong>${template.Version}</strong>`;

        // Adds a new tab for the current editor
        $("#editor-tabs li").removeClass("selected");
        $("#editor-tabs").append(`<li data-id="${uniqueId}" class="selected"><span class="caption">${template.Name}</span>&nbsp;<div class="close"><img src="/img/icons-png/close.png" /></div></li>`);

        const editor = this.module.initCodeMirror(uniqueId, template.Type, template.Content);
        this.module.initEditorBindings(uniqueId);

        // Add the editor to the module
        instance[uniqueId] = editor;
        instance[uniqueId].template = template;

        Object.assign(this.module.editors, instance);

        loader.close();
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
    async SaveTemplate(uniqueId) {
        const editor = this.module.editors[uniqueId];
        const toast = elixer.toast.create({ "text": "Saving..." });
        toast.open();

        console.log("Saving: ", uniqueId);

        const content = editor.getValue();
        const request = await elixer.request.post("/templates/save", {
            "template_id": editor.template.Id,
            "content": content
        });

        const responseData = JSON.parse(request.data);
        if (request.status == 200) {
            $("#save-template").addClass("disabled");
            $(`.editors .editor[data-id='${uniqueId}'] #template-info-bar`).html(`Template: <strong>${responseData.name} (${responseData.template})</strong> - Version: <strong>${responseData.version}</strong>`)

            var caption = $(`#editor-tabs li[data-id='${uniqueId}']`).find(".caption").text().replaceAll("*", "");
            $(`#editor-tabs li[data-id='${uniqueId}']`).find(".caption").text(caption);

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
        this.editors = {};;

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
        const firstElementWidth = localStorage.getItem("resize").split(",")[0];
        const secondElementWidth = localStorage.getItem("resize").split(",")[1];

        $($('.col.resizable')[0]).css("width", `calc(${firstElementWidth}% - (var(--f7-cols-per-row) - 1) * var(--f7-grid-gap) / var(--f7-cols-per-row))`);
        $($('.col.resizable')[1]).css("width", `calc(${secondElementWidth}% - (var(--f7-cols-per-row) - 1) * var(--f7-grid-gap) / var(--f7-cols-per-row))`);

        $("div.treeview").height(pageHeight - 96 + "px");
        $("div.CodeMirror").height(pageHeight - 96 - 52 + "px");
    }

    initEditorBindings() {
        $("#editor-tabs.tabs li").on("click", (event) => {
            const element = event.currentTarget;
            const uniqueId = event.currentTarget.dataset.id;

            $("#editor-tabs.tabs li").removeClass("selected");
            element.classList.add("selected");

            $(".editors .editor").addClass("hide");
            $(`.editors .editor[data-id='${uniqueId}']`).removeClass("hide");
        });

        $("#editor-tabs.tabs li .close").on("click", (event) => {
            const id = event.currentTarget.closest("li").dataset.id;

            this.actions.CloseTemplate(id);
        });
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

        $(".resize-handler").mouseup(() => {
            const firstElementWidth = parseFloat($('.col.resizable')[0].style.width.split('calc(').pop().split('%')[0]);
            const secondElementWidth = parseFloat($('.col.resizable')[1].style.width.split('calc(').pop().split('%')[0]);

            localStorage.setItem("resize", [firstElementWidth, secondElementWidth]);
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

            this.actions.OpenTemplate(templateId);
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
    initCodeMirror(uniqueId, type = "html", content = "") {
        var templateType = "";
        var editor = {};

        switch (type) {
            case "html": templateType = { name: "htmlmixed" }; break;
            case "sql": templateType = { name: "text/x-mariadb" }; break;
            case "javascript": templateType = { name: "javascript" }; break;
            case "css": templateType = { name: "css" }; break;
            case "module": templateType = { name: "text/x-php" }; break;
            case "worker": templateType = { name: "htmlmixed" }; break;
        }

        editor = CodeMirror.fromTextArea(document.querySelector(`div.editors .editor[data-id='${uniqueId}'] textarea.codemirror`), {
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
                    await this.actions.SaveTemplate(uniqueId);
                },
                "'@'": this.completeAfter
            }
        });

        // Set the content of the current document before the change event
        editor.getDoc().setValue(content);

        editor.on("change", function () {
            var caption = $(`#editor-tabs li[data-id='${uniqueId}']`).find(".caption").text().replaceAll("*", "");

            $(`#editor-tabs li[data-id='${uniqueId}']`).find(".caption").text(caption + "*");
            $("#save-template").removeClass("disabled");
        });

        this.resize();

        return editor;
    }

    completeAfter(cm, pred) {
        var cur = cm.getCursor();
        var autoCompleteOptions = {
            hint: function () {
                return {
                    from: cm.getDoc().getCursor(),
                    to: cm.getDoc().getCursor(),
                    list: ['auth', 'include', 'if', 'else', 'endif', 'foreach', 'endforeach', 'translate', 'form', 'image']
                }
            }
        };

        if (!pred || pred()) setTimeout(function () {
            if (!cm.state.completionActive)

                cm.showHint(autoCompleteOptions);
        }, 100);

        return CodeMirror.Pass;
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