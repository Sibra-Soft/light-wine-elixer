<div class="view login-view">
    <div class="page login-screen-page">
        <!-- page-content has additional login-screen content -->
        <div class="page-content login-screen-content">
        <div class="login-screen-title">Sibra-Soft Elixer</div>
        <!-- Login form -->
        <form id="login-form" method="post">
            <div class="block">
                <div class="alert alert-danger hide" id="message"><!-- Filled by JS --></div>
            </div>
            <div class="list">
            <ul>
                <li class="item-content item-input">
                    <div class="item-inner">
                        <div class="item-title item-label">Gebruikersnaam</div>
                        <div class="item-input-wrap">
                        <input type="text" name="login-username" placeholder="Username" />
                        <span class="input-clear-button"></span>
                        </div>
                    </div>
                </li>
                <li class="item-content item-input">
                    <div class="item-inner">
                        <div class="item-title item-label">Wachtwoord</div>
                        <div class="item-input-wrap">
                        <input type="password" name="login-password" placeholder="Password" />
                        <span class="input-clear-button"></span>
                        </div>
                    </div>
                </li>
                <li class="item-content item-input hide" id="select-project">
                    <div class="item-inner">
                        <div class="item-title item-label">Project</div>
                        <div class="item-input-wrap">
                        <select class="input-with-value" id="projects-dropdown">
                            <option value="upload-new">Upload project</option>
                        </select>
                        </div>
                    </div>
                </li>
                <li class="item-content item-input hide" id="upload-project">
                    <div class="item-inner">
                        <div class="item-title item-label">Project</div>
                        <div class="item-input-wrap">
                        <input type="file" name="project_file" accept="json/*,.json" />
                        <span class="input-clear-button"></span>
                        </div>
                    </div>
                </li>
            </ul>
            </div>
            <div class="list">
                <ul>
                    <li>
                        <a href="javascript:void(0);" class="list-button" id="submit-button">
                            <div class="preloader hide">
                                <span class="preloader-inner">
                                    <span class="preloader-inner-circle"></span>
                                </span>
                            </div>
                            <span class="button-text">Inloggen</span>
                        </a>
                    </li>
                </ul>
                <div class="block-footer">
                    Login to get access to your Elixer management enviroment or <a href="/new-project" class="new-project">create</a> a new website project.
                </div>
            </div>
        </form>
        </div>
    </div>
</div>