class Views {
    Show(name) {
        $(".view-container").addClass("hide");
        $(`.view-container#${name}`).removeClass("hide");
    }

    Close() {
        $(".view-container").addClass("hide");
        $(".view-container#main").removeClass("hide");
    }
}