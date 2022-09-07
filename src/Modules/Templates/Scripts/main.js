class TemplateModuleActions {
    /**
     * Class constructor
     * @param {TemplatesModule} module
     */
    constructor(module) {
        this.module = module;
    }

    /**
     * Adds a CDN package to the framework, the package will be added to the selected folder
     * @param {number} folderId The id of the folder the package must be added to
     */
    AddCdnPackage(folderId) {
        elixer.dialog.prompt("Enter the url of the package you want to add", "", async (value) => {
            const request = await elixer.request.post("/template/add-external-file", { "package_url": value, "folder": folderId });

            if (request.status == 200) {
                await templatesModule.populateTreeview();
            }
        });
    }

    /**
     * Links a resource template to the specified template
     * @param {number} templateId The id of the template you want to add the resource to
     */
    async LinkResourceTemplate(templateId) {
        const dialog = await masterpage.showPopup("link-resource", {}, async () => {
            const resources = await elixer.request.getJSON("/templates/get-resources", { "template": templateId });

            $("#popup-link-resource .searchbar-enable").on("click", () => {
                $("#popup-link-resource .searchbar-expandable").addClass("searchbar-enabled");
            });

            $("#popup-link-resource .searchbar-expandable .input-clear-button").on("click", () => {
                $("#popup-link-resource li").removeClass("hide");
            });

            $("#popup-link-resource .searchbar-expandable input").on("keyup", (event) => {
                const searchValue = event.currentTarget.value;

                $("#popup-link-resource li").addClass("hide");
                $("#popup-link-resource li").filter(`[data-value*='${searchValue}']`).removeClass("hide");
            });

            if (resources.status == 200) {
                this.module.templater.RenderFromObject(resources.data, "template#resource-item-template");

                $("#popup-link-resource div.list li[data-selected='1'] input").prop("checked", true);
            }
        });

        if (dialog.result === "confirm") {
            const selected = { "scripts": [], "stylesheets": [] };
            const toast = elixer.toast.create({ "text": "Saving..." });

            toast.open();

            $("#popup-link-resource div.list li input:checked").each((index, element) => {
                const type = element.closest("label").querySelector(".item-after").innerText;

                if (type === "javascript") {
                    selected.scripts.push(element.value);
                } else {
                    selected.stylesheets.push(element.value);
                }
            });

            const request = await elixer.request.post("/templates/link-resources", {
                "template": templateId,
                "scripts": selected.scripts.join(","),
                "stylesheets": selected.stylesheets.join(",")
            });
            toast.close();
        }
    }

    /**
     * Closes the specified template based on the uniqueId
     * @param {any} uniqueId The uniqueId of the template you want to close
     */
    CloseTemplate(uniqueId) {
        if (this.module.editors[uniqueId].changed) {
            elixer.dialog.confirm("Are you sure you want to close the document without saving the changes?", "", () => {
                $(`#editor-tabs li[data-id='${uniqueId}']`).remove();
                $(`.editors .editor[data-id='${uniqueId}']`).remove();

                delete this.module.editors[uniqueId];
            });
        } else {
            $(`#editor-tabs li[data-id='${uniqueId}']`).remove();
            $(`.editors .editor[data-id='${uniqueId}']`).remove();

            delete this.module.editors[uniqueId];
        }
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

            this.module.editors[uniqueId].changed = false;

            toast.close();
        }
    }

    /**
     * Copy a template to a specified folder
     * @param {number} id The id of the template you want to copy
     * @param {number} targetFolderId The folder you want to copy the template to
     */
    async Copy(id) {
        const dialog = await masterpage.showFolderBrowserDialog(() => {
            templatesModule.generateTreeview(".browse-treeview", "template#treeview-item", { "type": "folders_only" });
        });
        const targetFolderId = 0;

        console.log(dialog);

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
        const targetFolderId = await masterpage.showFolderBrowserDialog();

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
        this.module = $("div.page#module-templates");
        this.id = utils.guid();
        this.templater = new JsTemplater();
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

    resize() {
        const pageHeight = $(".page").height();
        const firstElementWidth = localStorage.getItem("resize").split(",")[0];
        const secondElementWidth = localStorage.getItem("resize").split(",")[1];

        this.module.find($('.col.resizable')[0]).css("width", `calc(${firstElementWidth}% - (var(--f7-cols-per-row) - 1) * var(--f7-grid-gap) / var(--f7-cols-per-row))`);
        this.module.find($('.col.resizable')[1]).css("width", `calc(${secondElementWidth}% - (var(--f7-cols-per-row) - 1) * var(--f7-grid-gap) / var(--f7-cols-per-row))`);

        this.module.find("div.treeview").height(pageHeight - 96 + "px");
        this.module.find("div.CodeMirror").height(pageHeight - 96 - 52 + "px");
    }

    initEditorBindings() {
        this.module.find("#editor-tabs.tabs li").on("click", (event) => {
            const element = event.currentTarget;
            const uniqueId = event.currentTarget.dataset.id;

            $("#editor-tabs.tabs li").removeClass("selected");
            element.classList.add("selected");

            $(".editors .editor").addClass("hide");
            $(`.editors .editor[data-id='${uniqueId}']`).removeClass("hide");
        });

        this.module.find("#editor-tabs.tabs li .close").on("click", (event) => {
            const id = event.currentTarget.closest("li").dataset.id;

            this.actions.CloseTemplate(id);
        });
    }

    initBindings() {
        $(window).on("resize", () => {
            this.resize();
        });

        this.module.find("#save-template").on("click", (event) => {
            this.actions.SaveTemplate();
        });

        this.module.find(".link#search").on("click", () => {
            elixer.dialog.prompt("Search for template", "", async (value) => {
                this.actions.Search(value);
            });
        });

        this.module.find(".resize-handler").mouseup(() => {
            const firstElementWidth = parseFloat($('.col.resizable')[0].style.width.split('calc(').pop().split('%')[0]);
            const secondElementWidth = parseFloat($('.col.resizable')[1].style.width.split('calc(').pop().split('%')[0]);

            localStorage.setItem("resize", [firstElementWidth, secondElementWidth]);
        });
    }

    /** Init bindings specifik for the treeview of the template module */
    initTreeviewBindings() {
        this.module.find(".treeview-item-content").off();
        this.module.find(".treeview-item-content").on("click", async (event) => {
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
                const type = element.dataset.type;

                var items = {
                    open: { name: "Open" },
                    newFolder: { name: "Add folder" },
                    newTemplate: { name: "Add template" },
                    newBindng: { name: "Add binding" },
                    linkResource: { name: "Link resource(s)" },
                    move: { name: "Move" },
                    copy: { name: "Copy" },
                    delete: { name: "Delete" },
                    rename: { name: "Rename" },
                    properties: { name: "Properties" },
                    cdnPackages: { name: "Content Delivery Network" }
                };

                switch (group) {
                    case "binding":
                    case "template":
                        if (type !== "html") {
                            items["newBindng"].className = "context-disabled";
                            items["linkResource"].className = "context-disabled";
                        }

                        items["newTemplate"].className = "context-disabled";
                        items["newFolder"].className = "context-disabled";
                        break;

                    case "folder":
                        items["open"].className = "context-disabled";
                        items["properties"].className = "context-disabled";
                        items["move"].className = "context-disabled";
                        items["copy"].className = "context-disabled";
                        items["newBindng"].className = "context-disabled";
                        items["linkResource"].className = "context-disabled";
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
                            case "linkResource": this.actions.LinkResourceTemplate(id); break;
                            case "cdnPackages": this.actions.AddCdnPackage(id); break;
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

        editor.on("change", () => {
            const caption = $(`#editor-tabs li[data-id='${uniqueId}']`).find(".caption").text().replaceAll("*", "");

            this.editors[uniqueId].changed = true;

            this.module.find(`#editor-tabs li[data-id='${uniqueId}']`).find(".caption").text(caption + "*");
            this.module.find("#save-template").removeClass("disabled");
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

    async populateTreeview() {
        await this.generateTreeview(".my-treeview", "template#treeview-item");

        this.initTreeviewBindings();
        this.refreshFolderView();
    }

    /**
     * Generates a treeview based on the specified selectors
     * @param {string} treeviewSelector The selector for the container holding the treeview
     * @param {string} itemTemplateSelector The selector for the template containing the treeview item HTML
     */
    async generateTreeview(treeviewSelector, itemTemplateSelector, parameters = {}) {
        const treeview = await elixer.request.get("/templates/treeview", parameters);
        const elements = JSON.parse(treeview.data);

        var lastParent = "root";
        var treeviewSubItem = document.createElement("div");

        elements.forEach((element, index) => {
            var treeviewItem = $(itemTemplateSelector).html();
            var parent = element.parent_key.toLowerCase();

            // Check if the item already exists
            var itemSearch = $(treeviewSelector).find(`.treeview-item[data-treeview-key='${element.object_key.toLowerCase()}']`).length;
            if (itemSearch > 0) {
                return;
            }

            if (parent !== lastParent) {
                treeviewSubItem = document.createElement("div");
                treeviewSubItem.className = "treeview-item-children";

                $(treeviewSelector).find(`[data-treeview-key='${parent}']`).append(treeviewSubItem);
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
                    $(treeviewSelector).find(`[data-treeview-key='${parent}']`).append(treeviewItem);
                } else {
                    treeviewSubItem.insertAdjacentHTML("beforeend", treeviewItem);
                }
            }

            lastParent = parent;
        });
    }

    refreshFolderView() {
        // Hide toggels for folders without items
        this.module.find(".treeview-item").each((index, element) => {
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