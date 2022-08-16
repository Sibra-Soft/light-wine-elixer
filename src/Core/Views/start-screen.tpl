{{view::~\Partials\menu.tpl}}

<div class="view view-main view-init">
    <div class="page page-current bg-color-white" id="module-welcome" data-module="95a2e176-ce01-4762-9681-1f9205d33ae9">
        <div class="row">
            <div class="col">
                <div class="block no-margin">
                    <img src="/img/dashboard-loader.gif" class="hide loader-image" />

                    <h1 class="no-margin">Welcome to Elixer</h1>
                    Use Elixer for managing websites that are created using the LightWine Framework

                    <div class="margin">&nbsp;</div>

                    <div class="row margin-top">
                        <div class="col">
                            <div class="elevation-demo elevation-3 padding">
                                <div class="list media-list no-padding no-margin no-hairlines no-chevron">
                                    <ul>
                                        <li>
                                        <a href="/module/templates" class="item-link item-content open-module" data-name="templates">
                                            <div class="item-media"><img src="/img/templates.png" width="70"></div>
                                            <div class="item-inner">
                                                <div class="item-title-row">
                                                    <div class="item-title">Templates</div>
                                                </div>
                                                <div class="item-text">
                                                    Use the templates module to manange the templates of your website. Templates can be used for showing query results or creating Javascript files for your webiste.
                                                </div>
                                            </div>
                                        </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="col">
                            <div class="elevation-demo elevation-3 padding">
                                <div class="list media-list no-padding no-margin no-hairlines no-chevron">
                                    <ul>
                                        <li>
                                        <a href="/module/files" class="item-link item-content open-module" data-name="files">
                                            <div class="item-media"><img src="/img/files.png" width="70"></div>
                                            <div class="item-inner">
                                                <div class="item-title-row">
                                                    <div class="item-title">File Explorer</div>
                                                </div>
                                                <div class="item-text">
                                                    The file explorer allows you to upload, delete, change and rename the files that are used in your website, like images, documents and downloads.
                                                </div>
                                            </div>
                                        </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="col">
                            <div class="elevation-demo elevation-3 padding">
                                <div class="list media-list no-padding no-margin no-hairlines no-chevron">
                                    <ul>
                                        <li>
                                        <a href="/module/routes" class="item-link item-content open-module" data-name="routes">
                                            <div class="item-media"><img src="/img/routes.png" width="70"></div>
                                            <div class="item-inner">
                                                <div class="item-title-row">
                                                    <div class="item-title">Routes</div>
                                                </div>
                                                <div class="item-text">
                                                    The routes module allows you to channel various request urls to templates or functions of your website.
                                                </div>
                                            </div>
                                        </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row margin-top">
                        <div class="col">
                            <div class="elevation-demo elevation-3 padding">
                                <div class="list media-list no-padding no-margin no-hairlines no-chevron">
                                    <ul>
                                        <li>
                                        <a href="/module/deployment" class="item-link item-content open-module" data-name="deployment">
                                            <div class="item-media"><img src="/img/deployment.png" width="70"></div>
                                            <div class="item-inner">
                                                <div class="item-title-row">
                                                    <div class="item-title">Publish &amp; Deployment</div>
                                                </div>
                                                <div class="item-text">
                                                    Use the deployment module for deploying changes of templates to your test, acceptance and live enviroment.
                                                </div>
                                            </div>
                                        </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="col">
                            <div class="elevation-demo elevation-3 padding">
                                <div class="list media-list no-padding no-margin no-hairlines no-chevron">
                                    <ul>
                                        <li>
                                        <a href="/module/users" class="item-link item-content open-module" data-name="users">
                                            <div class="item-media"><img src="/img/users.png" width="70"></div>
                                            <div class="item-inner">
                                                <div class="item-title-row">
                                                    <div class="item-title">Users &amp; Roles</div>
                                                </div>
                                                <div class="item-text">
                                                    Manage the roles and users that have access to your website and Elixer. Reset passwords, create new users, etc.
                                                </div>
                                            </div>
                                        </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="col">
                            <div class="elevation-demo elevation-3 padding">
                                <div class="list media-list no-padding no-margin no-hairlines no-chevron">
                                    <ul>
                                        <li>
                                        <a href="/module/translations" class="item-link item-content open-module" data-name="translations">
                                            <div class="item-media"><img src="/img/translations.png" width="70"></div>
                                            <div class="item-inner">
                                                <div class="item-title-row">
                                                    <div class="item-title">Translations</div>
                                                </div>
                                                <div class="item-text">
                                                    Manage the languages, words and sentences that must be translated for your website.
                                                </div>
                                            </div>
                                        </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="toolbar toolbar-bottom bg-button-face">
        <div class="block block-strong no-hairlines no-margin no-padding bg-button-face" style="margin:6px !important;" id="taskbar">
		    <div class="chip hide mar-left-5" id="taskbar-chip-template">
                <div class="chip-label">
                    <a href="javascript:void(0);" data-module="{module}">{name}</a>
                </div>
                <a href="javascript:void(0);" class="chip-delete"></a>
            </div>
	    </div>
    </div>
</div>

{{view::~\Popovers\popover-file.tpl}}
{{view::~\Popovers\popover-modules.tpl}}
{{view::~\Popovers\popover-tools.tpl}}
{{view::~\Popovers\popover-help.tpl}}