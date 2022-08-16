/** File Module actions class */
class FileModuleActions {
    /**
     * Class constructor
     * @param {FilesModule} module
     */
    constructor(module) {
        this.module = module;
    }

    /** Downloads the selected items */
    async Download() {
        const selected = this.module.selected();

        const request = await elixer.request.post("/files/download", {
            "ids": selected.ids.join(",")
        });

        if (request.status == 200) {

        }
    }

    /**
     * Rename a file
     * @param {any} id The id of the record in the database
     * @param {any} element The element that contains the details of the current file
     */
    Rename(id, element) {
        const currentName = element.querySelector("span.name").innerText;

        elixer.dialog.prompt("Rename", "", async (value) => {
            const request = await elixer.request.post("/files/rename", {
                "file_id": id,
                "new_name": value
            });

            if (request.status == 200) element.querySelector("a").innerText = value;
        }, $.noop(), currentName);
    }

    /** Delete the selected items */
    Delete() {
        const selected = this.module.selected();

        elixer.dialog.confirm("Are you sure you want to delete the selected file(s)", "", async () => {
            const request = await elixer.request.post("/files/delete", {
                "ids": selected.ids.join(",")
            });

            if (request.status == 200) {
                $(selected.elements).fadeOut(800);
            }
        });
    }

    UploadFile(index) {
        return new Promise(async (resolve, reject) => {
            const formData = new FormData();
            const element = document.querySelector("input[name='upload']");

            formData.append("file_upload", element.files[index]);

            const ajaxRequest = new XMLHttpRequest();

            // Check for progress
            ajaxRequest.open("POST", "/files/upload");
            ajaxRequest.upload.addEventListener('progress', (event) => {
                var percentCompleted = Math.round((event.loaded / event.total) * 100);

                $(`table#files-to-upload tr a.delete`).addClass("disabled");

                $(`table#files-to-upload tr[data-index='${index}'] p.progbar`).removeClass("hide");
                $(`table#files-to-upload tr[data-index='${index}'] span.text`).addClass("hide");
            });

            // Check if finished
            ajaxRequest.addEventListener('load', async (event) => {
                resolve();
            });

            ajaxRequest.send(formData);
        });
    }

    /**
     * Search in the current view
     */
    Search() {
        elixer.dialog.prompt("Search", "", (value) => {
            $(`table#files-table tbody tr`).addClass("hide");
            $(`table#files-table td:icontains('${value}')`).each((index, element) => {
                element.closest("tr").classList.remove("hide");
            });

            $("a.button[data-action='delete_search']").removeClass("hide");
            $("a.button[data-action='search']").addClass("hide");
        });
    }

    /** Removes the active search */
    DeleteSearch() {
        $(`table#files-table tbody tr`).removeClass("hide");
        $("a.button[data-action='delete_search']").addClass("hide");
        $("a.button[data-action='search']").removeClass("hide");
    }

    /** Upload a new file to the database */
    async Upload() {
        const element = document.querySelector("input[name='upload']");

        this.module.uploading = true;

        for (var count = 0; count < element.files.length; count++) {
            await this.UploadFile(count);
        }

        await this.module.templater.Render("/files/get", "template#file-item-template");

        this.module.uploading = false;
        this.module.initTableBindings();
        this.module.views.Close();
    }

    /** Add a new folder to the database */
    AddFolder() {
        elixer.dialog.prompt("Add new folder", "", async (value) => {
            const request = await elixer.request.post("/files/add-folder", {
                "name": value
            });

            if (request.status == 200)
                await this.module.templater.Render("/files/get", "template#file-item-template");
        });
    }
}

/** File module main class */
class FilesModule {
    constructor() {
        this.uploading = false;

        this.actions = new FileModuleActions(this);
        this.templater = new JsTemplater();
        this.views = new Views();
        this.rightClickElement = {};
        this.id = utils.guid();
        this.init();
    }

    async init() {
        document.querySelector("div.page#module-files").dataset.module = this.id;

        console.log("Ready -> Files module -> " + this.id);

        masterpage.addNewTaskbarElement("File Explorer", this.id);

        await this.templater.Render("/files/get", "template#file-item-template");

        this.initTableBindings();
        this.initBindings();
        this.resize();
    }

    removeFileFromFileList(index) {
        const dt = new DataTransfer();
        const input = document.querySelector("input[name='upload']");
        const { files } = input;

        for (let i = 0; i < files.length; i++) {
            const file = files[i]

            if (index !== i)
                dt.items.add(file)
        }

        input.files = dt.files;
    }

    initBindings() {
        $(window).on("resize", () => {
            this.resize();
        });

        $(".return-to-main").on("click", () => {
            this.views.Close();
        });

        $("a.button[data-action]").on("click", (event) => {
            switch (event.currentTarget.dataset.action) {
                case "upload": this.views.Show("upload-file"); break;
                case "remove": this.actions.Delete(); break;
                case "download": this.actions.Download(); break;
                case "select-files": $("input[name='upload']").trigger("click"); break;
                case "search": this.actions.Search(); break;
                case "delete_search": this.actions.DeleteSearch(); break;
            }
        });

        $("input[type='button']#upload").on("click", () => {
            this.actions.Upload();
        });

        // Check if the uploaded files have changed
        $("input[name='upload']").on("change", (event) => {
            var files = { "files": [] };

            $(event.currentTarget.files).each((index, element) => {
                files.files.push(element);
            });

            this.templater.RenderFromObject(files, "template#file-upload-item");

            // Remove the added file
            $("table#files-to-upload td a.delete").on("click", (event) => {
                const fileIndex = parseInt(event.currentTarget.closest("tr").dataset.index);

                this.removeFileFromFileList(fileIndex);

                $("input[name='upload']").trigger("change");
            });
        });

        // Enable & disable controls
        setInterval(() => {
            const fileCount = $("table#files-to-upload tbody tr").length;
            const specifiedName = $("input[name='upload-name']").val();

            if (specifiedName !== "" && fileCount > 0 && !this.uploading) {
                $("input[type='button']#upload").removeClass("disabled");
            } else {
                $("input[type='button']#upload").addClass("disabled");
            }
        }, 10);
    }

    /** Get the selected files (single or multiple) */
    selected() {
        var returnObject = {};
        const multiple = $("#files-table td.checkbox-cell input:checked").length;

        if (multiple > 0) {
            var ids = [];
            var elements = [];

            $("#files-table td.checkbox-cell input:checked").each((index, element) => {
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

    /** Initialize the files table */
    initTableBindings() {
        $.contextMenu({
            selector: '#files-table tr',
            build: (trigger) => {
                this.rightClickElement = trigger[0];

                var items = {
                    download: { name: "Download" },
                    newFolder: { name: "Add folder" },
                    uploadFile: { name: "Upload new file" },
                    rename: { name: "Rename" },
                    delete: { name: "Remove" }
                };

                return {
                    callback: (key) => {
                        switch (key) {
                            case "rename": this.actions.Rename(id, element); break;
                            case "delete": this.actions.Delete(); break;
                            case "newFolder": this.actions.AddFolder(); break;
                            case "uploadFile": this.actions.Upload(); break;
                            case "download": this.actions.Download(); break;
                        }
                    },
                    items: items
                };
            }
        });

        $("table#files-table td input[type='checkbox']").on("change", () => {
            const selectedItemCount = $("table#files-table td input[type='checkbox']:checked").length;

            if (selectedItemCount > 0) {
                $("a.button[data-action='remove']").removeClass("disabled");
                $("a.button[data-action='download']").removeClass("disabled");
                $("a.button[data-action='compress']").removeClass("disabled");
                $("a.button[data-action='resize']").removeClass("disabled");
            } else {
                $("a.button[data-action='remove']").addClass("disabled");
                $("a.button[data-action='download']").addClass("disabled");
                $("a.button[data-action='compress']").addClass("disabled");
                $("a.button[data-action='resize']").addClass("disabled");
            }
        });
    }

    resize() {
        const pageHeight = $(".page").height();

        $("div.page#module-files").height(pageHeight - 48 + "px");
    }
}

window.filesModule = new FilesModule();