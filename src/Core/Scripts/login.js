class Login {
    constructor() {
        if (window.location.pathname === "/") {
            this.init();
            this.initBindings();
        }
    }

    showMessage(message) {
        $("#message").text(message);
        $("#message").removeClass("hide").fadeIn(500);
    }

    getProjectsFromCookie() {
        var cookie = utils.getCookie('projects');

        if (cookie) {
            cookie = cookie.replace(/%7B/g, "{").replace(/%22/g, '"').replace(/%7D/g, "}").replace(/%3A/g, ":").replace(/%2C/g, ",").replace(/%5B/g, "[").replace(/%5D/g, "]");
            cookie = JSON.parse(cookie);
        } else {
            cookie = [];
        }

        return cookie;
    }

    init() {
        const projects = this.getProjectsFromCookie();
        const projectCount = $(projects).length;
        const select = document.getElementById('projects-dropdown');

        if (projectCount > 0) {
            projects.forEach((element) => {
                var opt = document.createElement('option');

                opt.value = element.project;
                opt.innerHTML = decodeURI(element.name);

                select.appendChild(opt);
            });

            // Select the new added project
            $("#select-project option")[1].selected = true;

            $("#select-project").removeClass("hide");
            $("#upload-project").addClass("hide");
        } else {
            $("#select-project").addClass("hide");
            $("#upload-project").removeClass("hide");
        }
    }

    initBindings() {
        $("#select-project").on("change", (event) => {
            const selectedOption = $("#select-project option:selected").val();

            if (selectedOption == "upload-new") {
                $("#select-project").addClass("hide");
                $("#upload-project").removeClass("hide");
            }
        });

        $("input[name='login-username'],input[name='login-password']").on("keyup", () => {
            $("#message").fadeOut(400).addClass("hide");
        });

        $("#submit-button").on("click", () => {
            $("#login-form").submit();
        });

        $("input[name='login-username'],input[name='login-password']").keypress((event) => {
            if (event.which == 13) {
                $("#login-form").submit();
            }
        });

        $("#login-form").on("submit", async (event) => {
            event.preventDefault();

            event.currentTarget.querySelector(".button-text").classList.add("hide");
            event.currentTarget.querySelector(".preloader").classList.remove("hide");
            
            var data = new FormData();
            var file = $("input[name='project_file']")[0].files[0];
            var username = $("input[name='login-username']").val();
            var password = $("input[name='login-password']").val();
            var uploading = $("input[name='project_file']").is(":visible");

            data.append("login_username", username);
            data.append("login_password", password);

            if (uploading) {
                data.append("project", file);
            } else {
                data.append("project_id", $("#projects-dropdown option:selected").val());
            }

            elixer.request.post("/account/login", data).then((resp) => {
                const response = JSON.parse(resp.data);

                switch (response.response) {
                    case "LOGIN_INCORRECT": this.showMessage("Wrong username or password"); break;
                    case "LOGIN_CORRECT": window.location.href = "/dashboard"; break;
                }
            }).finally(() => {
                event.currentTarget.querySelector(".button-text").classList.remove("hide");
                event.currentTarget.querySelector(".preloader").classList.add("hide");
            });
        });
    }
}