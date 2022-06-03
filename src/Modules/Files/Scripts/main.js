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

    /** Upload a new file to the database */
    async Upload() {
        let formData = new FormData();
        const toast = elixer.toast.create({ text: 'Uploading file...' });

        $("input[name='file-upload']").trigger("click");

        $("input[name='file-upload']").off();
        $("input[name='file-upload']").on("change", async () => {
            const input = document.querySelector("input[name='file-upload']");

            if (input.files.length > 0) {
                toast.open();

                formData.append("file_upload", input.files[0]);

                const request = await elixer.request.post("/files/upload", formData);

                if (request.status == 200) {
                    toast.close();
                }
            }
        });
    }

    /** Add a new folder to the database */
    AddFolder() {
        elixer.dialog.prompt("Add new folder", "", async (value) => {
            const request = await elixer.request.post("/files/add-folder", {
                "name": value
            });

            if (request.status == 200) this.module.getFiles();
        });
    }
}

/** File module main class */
class FilesModule {
    constructor() {
        this.actions = new FileModuleActions(this);
        this.rightClickElement = {};
        this.id = utils.guid();
        this.init();
    }

    init() {
        document.querySelector("div.page#module-files").dataset.module = this.id;

        console.log("Ready -> Files module -> " + this.id);

        masterpage.addNewTaskbarElement("File Explorer", this.id);

        this.getFiles();
        this.initBindings();
        this.resize();
    }

    initBindings() {
        $(window).on("resize", () => {
            this.resize();
        });

        $("a.button[data-action]").on("click", (event) => {
            switch (event.currentTarget.dataset.action) {
                case "upload": this.actions.Upload(); break;
                case "remove": this.actions.Delete(); break;
                case "download": this.actions.Download(); break;
            }
        });
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

    async getFiles() {
        const request = await elixer.request.get("/files/get");
        const files = JSON.parse(request.data);

        files.forEach((element, index) => {
            var fileItem = $("div.page#module-files template#file-item-template").html();
            var icon = "";

            switch (element.type) {
                case "folder": icon = "folder"; break;
                case "file":
                    var extension = element.name.substr(element.name.length - 3);

                    switch (extension) {
                        case "png": icon = "image-png"; break;
                        case "jpg": icon = "image-jpg"; break;
                    }
                    break;
            }

            fileItem = fileItem.replace("{name}", element.name);
            fileItem = fileItem.replace("{icon}", icon);
            fileItem = fileItem.replace("{date_created}", element.date_added);
            fileItem = fileItem.replace("{date_changed}", element.date_modified);
            fileItem = fileItem.replace("{type}", element.type);
            fileItem = fileItem.replace("{size}", utils.formatBytes(element.size));
            fileItem = fileItem.replace("{id}", element.id);

            $("div.page#module-files table#files-table tbody").append(fileItem);
        });

        this.initTableBindings();
    }
}

window.filesModule = new FilesModule();