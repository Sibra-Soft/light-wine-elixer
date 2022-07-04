<?php
namespace Elixer;

use \DateInterval;

use Elixer\Core\Services\ServerService;

use LightWine\Core\Route;
use LightWine\Core\HttpResponse;
use LightWine\Core\Helpers\Helpers;

class Bootloader {
    private function BeforeRequest(){
        // Account
        Route::Controller("/account/login", "Core", "LoginController@HandleLogin", "POST", []);
        Route::Controller("/account/logoff", "Core", "LoginController@HandleLogoff", "GET", []);

        // Templates
        Route::Controller("/templates/add-template", "Modules\Templates", "TemplatesController@AddTemplate", "POST", ["LoginRequired" => true]);
        Route::Controller("/templates/add-folder", "Modules\Templates", "TemplatesController@AddFolder", "POST", ["LoginRequired" => true]);
        Route::Controller("/templates/delete", "Modules\Templates", "TemplatesController@Delete", "POST", ["LoginRequired" => true]);
        Route::Controller("/templates/rename", "Modules\Templates", "TemplatesController@Rename", "POST", ["LoginRequired" => true]);
        Route::Controller("/templates/save", "Modules\Templates", "TemplatesController@Save", "POST", ["LoginRequired" => true]);
        Route::Controller("/templates/treeview", "Modules\Templates", "TemplatesController@Treeview", "GET", []);
        Route::Controller("/templates/get", "Modules\Templates", "TemplatesController@Get", "GET", []);
        Route::Controller("/templates/move", "Modules\Templates", "TemplatesController@Move", "POST", []);
        Route::Controller("/templates/copy", "Modules\Templates", "TemplatesController@Copy", "POST", []);
        Route::Controller("/templates/new-binding", "Modules\Templates", "TemplatesController@NewBinding", "POST", []);

        // Files
        Route::Controller("/files/get", "Modules\Files", "FilesController@Get", "GET", []);
        Route::Controller("/files/rename", "Modules\Files", "FilesController@Rename", "POST", []);
        Route::Controller("/files/delete", "Modules\Files", "FilesController@Delete", "POST", []);
        Route::Controller("/files/add-folder", "Modules\Files", "FilesController@AddFolder", "POST", []);
        Route::Controller("/files/upload", "Modules\Files", "FilesController@Upload", "POST", []);
        Route::Controller("/files/download", "Modules\Files", "FilesController@Download", "POST", []);

        // Deployment
        Route::Controller("/deployments/get-commits", "Modules\Deployment", "DeploymentController@GetCommits", "GET", []);
        Route::Controller("/deployments/commit", "Modules\Deployment", "DeploymentController@Commit", "POST", []);

        // Routes
        Route::Controller("/routes/get", "Modules\Routes", "RoutesController@Get", "GET", []);
        Route::Controller("/routes/add", "Modules\Routes", "RoutesController@Create", "POST", []);

        // Users
        Route::Controller("/users/get-users", "Modules\Users", "UsersController@GetUsers", "GET", []);
        Route::Controller("/users/get-roles", "Modules\Users", "UsersController@GetRoles", "GET", []);

        // Views
        Route::View("/", "../src/Core/Views/login.tpl", []);
        Route::View("/dashboard", "../src/Core/Views/start-screen.tpl", ["LoginRequired" => true]);
        Route::View("/module/templates", "../src/Modules/Templates/Views/templates.tpl", ["LoginRequired" => true]);
        Route::View("/module/deployment", "../src/Modules/Deployment/Views/deployment.tpl", ["LoginRequired" => true]);
        Route::View("/module/files", "../src/Modules/Files/Views/files.tpl", ["LoginRequired" => true]);
        Route::View("/dialogs/add-template", "../src/Modules/Templates/Views/Dialogs/new-template.tpl", ["LoginRequired" => true]);
        Route::View("/dialogs/template-properties", "../src/Modules/Templates/Views/Dialogs/template-properties.tpl", ["LoginRequired" => true]);
        Route::View("/module/routes", "../src/Modules/Routes/Views/routes.tpl", ["LoginRequired" => true]);
        Route::View("/module/webforms", "../src/Modules/Webforms/Views/webforms.tpl", ["LoginRequired" => true]);
        Route::View("/dialogs/new-binding", "../src/Modules/Templates/Views/Dialogs/new-binding.tpl", ["LoginRequired" => true, "ViewData" => ["datasources" => "../src/Modules/Templates/queries/GET_BINDING_DATASOURCES.sql"]]);
        Route::View("/module/users", "../src/Modules/Users/Views/users.tpl", ["LoginRequired" => true]);

        // Add variables
        if(!array_key_exists("CsrfToken", $_SESSION)) $_SESSION["CsrfToken"]  = uniqid(time());
        if(!array_key_exists("ClientToken", $_SESSION)) $_SESSION["ClientToken"] = hash("sha1", time());
        if(!array_key_exists("SessionStartTime", $_SESSION)) $_SESSION["SessionStartTime"] = Helpers::Now()->format("h:m:s");
        if(!array_key_exists("SessionEndTime", $_SESSION)) $_SESSION["SessionEndTime"] = Helpers::Now()->add(new DateInterval('PT20M'))->format("h:m:s");

        $_SESSION["RequestTime"] = Helpers::Now()->format("h:m:s");
    }

    private function AfterRequest(){

    }

    /**
     * Used for error handling of the framework
     * @param mixed $errno The number of the current error
     * @param mixed $errstr The description of the error
     * @param mixed $errfile The file where the error occured
     * @param mixed $errline Linenumber of the file where the error occured
     */
    public function SetErrorHandler($errno, $errstr, $errfile, $errline){

    }

    public function Run(){
        set_error_handler(array($this, 'SetErrorHandler'));

        $this->BeforeRequest();

        $server = new ServerService();
        $content = $server->Start();

        HttpResponse::SetContentType("text/html");
        HttpResponse::SetData($content);

        $this->AfterRequest();
    }
}
?>