class TranslationsModuleActions {
    /**
     * Constructor function
     * @param {TranslationsModule} module
     */
    constructor(module) {
        this.module = module;
    }

    /**
     * Search in the current view
     */
    Search() {
        elixer.dialog.prompt("Search", "", (value) => {
            $(`table#translations-table tbody tr`).addClass("hide");
            $(`table#translations-table td:icontains('${value}')`).each((index, element) => {
                element.closest("tr").classList.remove("hide");
            });

            $("a.button[data-action='delete_search']").removeClass("hide");
            $("a.button[data-action='search']").addClass("hide");
        });
    }

    /** Removes the active search */
    DeleteSearch() {
        $(`table#translations-table tbody tr`).removeClass("hide");
        $("a.button[data-action='delete_search']").addClass("hide");
        $("a.button[data-action='search']").removeClass("hide");
    }
}

class TranslationsModule {
    constructor() {
        this.module = $("div.page#module-translations");
        this.id = utils.guid();
        this.templater = new JsTemplater();
        this.actions = new TranslationsModuleActions(this);
        this.init();
    }

    init() {
        this.module = $("div.page#module-translations");

        document.querySelector("div.page#module-translations").dataset.module = this.id;

        console.log("Ready -> Translations module -> " + this.id);

        masterpage.addNewTaskbarElement("Translations", this.id);

        this.refreshDataTable();
        this.initBindings();
        this.resize();
        this.stats();
    }

    async refreshDataTable() {
        await this.templater.Render("/translations/get", "template#translation-item-template");

        this.module.find(".loader-container").addClass("hide");
    }

    resize() {
        const pageHeight = $(".page").height();
        this.module.height(pageHeight - 48 - 23 + "px");
    }

    initBindings() {
        $(window).on("resize", () => {
            this.resize();
        });

        this.module.find("a.button").on("click", (event) => {
            switch (event.currentTarget.dataset.action) {
                case "search": this.actions.Search(); break;
                case "delete_search": this.actions.DeleteSearch(); break;
            }
        });
    }

    async stats() {
        const request = await elixer.request.getJSON("/translations/get-stats");
        const numberOfEmptyTranslations = $("#translations-table tr[data-empty=1]").length;
        const stats = request.data.find((element) => element.is_default == 1);
        const percentage = 100 - ((100 * numberOfEmptyTranslations) / 132).toFixed(2);
        const languages = stats.languages.split(",");

        this.module.find("#module-translations .statusbar").html(`<strong><a href="javscript:void(0);" data-popover=".my-popover" class="popover-open" >${stats.language}</a></strong> - Geupdate: ${stats.last_update} - ${percentage}% Translated, ${stats.translations_count} strings`);
        
        this.templater.RenderFromObject({ "languages": languages }, "template#language-item");
    }
}

window.translationsModule = new TranslationsModule();