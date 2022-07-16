class Login {
    constructor() {
        this.projectHash = "";

        if (window.location.pathname === "/") {
            this.init();
            this.initBindings();
        }
    }

    /**
     * Shows a error message
     * @param {string} message The message you want to show
     */
    showMessage(message) {
        $("#message").text(message);
        $("#message").removeClass("hide").fadeIn(500);
    }

    /** Gets the projects that are saved in the cookie */
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
        const querystringProject = utils.getQuerystring().project;

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

        if (querystringProject) {
            this.projectHash = querystringProject;

            $("#upload-project").addClass("hide");
        }
    }

    setup() {
        elixer.dialog.confirm("This project has no data, do you want to complete the installation of this project?<br /><br />All the necessary tables will be created and all the required data will be added to those tables.", "", async () => {
            const loader = elixer.dialog.preloader("Running setup");
            const request = await elixer.request.post("/project/setup", {});

            if (request.status == 200) {
                loader.close();

                elixer.dialog.alert("The setup has completed successfully<br />A user has been created:<br /><br />Username: <strong>admin</strong><br />Password: <strong>P@ssword123</strong><br /><br />Make sure to enter the details because this message is only shown once", "", () => {
                    window.location.reload();
                });
            }
        });
    }

    initBindings() {
        $(".new-project").on("click", () => {
            window.location.href = "/new-project";
        });

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
                if (this.projectHash) {
                    data.append("project_id", this.projectHash);
                } else {
                    data.append("project", file);
                }
            } else {
                if (this.projectHash) {
                    data.append("project_id", this.projectHash);
                } else {
                    data.append("project_id", $("#projects-dropdown option:selected").val());
                }  
            }

            elixer.request.post("/account/login", data).then((resp) => {
                const response = JSON.parse(resp.data);

                switch (response.response) {
                    case "LOGIN_INCORRECT":
                        this.projectHash = response.project;
                        this.showMessage("Wrong username or password");
                        break;

                    case "LOGIN_CORRECT": window.location.href = "/dashboard"; break;
                    case "MUST_BE_INSTALLED": this.setup(); break;
                }
            }).finally(() => {
                event.currentTarget.querySelector(".button-text").classList.remove("hide");
                event.currentTarget.querySelector(".preloader").classList.add("hide");
            });
        });

        setInterval(() => {
            const username = $("input[name='login-username']").val();
            const password = $("input[name='login-password']").val();

            if (username !== "" && password !== "") {
                $("#submit-button").removeClass("disabled");
            } else {
                $("#submit-button").addClass("disabled");
            }
        }, 10);
    }
}