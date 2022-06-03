<?php
namespace Elixer\Core\Services;

use Elixer\Core\Models\ProjectModel;

use LightWine\Modules\Sam\Services\SamService;
use LightWine\Core\Helpers\RequestVariables;
use LightWine\Core\Helpers\StringHelpers;
use LightWine\Core\HttpResponse;
use LightWine\Core\Helpers\Helpers;

class LoginService
{
    /**
     * Login the user using the specified username and password
     */
    public function Login(){
        $username = RequestVariables::Get("login_username");
        $password = RequestVariables::Get("login_password");
        $project = RequestVariables::Get("project_id");

        if(StringHelpers::IsNullOrWhiteSpace($project)){
            $this->ProjectFromNewFile();
        }else{
            $this->ProjectFromPreviousFile($project);
        }

        $sam = new SamService();
        $sam->passwordBlowFish = "SeQ3H55Dp9XxndP";

        $login = $sam->Login($username, $password);

        if($login->LoginCorrect){
            $response = ["response" => "LOGIN_CORRECT"];
        }else{
            $response = ["response" => "LOGIN_INCORRECT"];
        }

        HttpResponse::SetContentType("application/json");
        HttpResponse::SetData(json_encode($response));
        exit();
    }

    /**
     * Logoff the current user
     */
    public function Logoff(){
        unset($_SESSION["Checksum"]);

        HttpResponse::SetContentType("application/json");
        HttpResponse::SetData(json_encode(["OK"]));
        exit();
    }

    /**
     * This gets the project file based on the uploaded file
     */
    private function ProjectFromNewFile(): ProjectModel {
        $model = new ProjectModel;
        $file = $_FILES["project"]["tmp_name"];
        $hash = Helpers::NewGuid();
        $projectFile = Helpers::MapPath("../temp/".$hash.".json");
        $projects = json_decode($_COOKIE["projects"], true);

        if(StringHelpers::IsNullOrWhiteSpace($projects)) $projects = [];

        move_uploaded_file($file, $projectFile);

        $_SESSION["ConfigFile"] = $projectFile;

        $model->File = $projectFile;
        $model->Name = json_decode(Helpers::GetFileContent($projectFile), true)["Name"];

        array_push($projects, ["project" => $hash, "name" => $model->Name]);

        setcookie("projects", json_encode($projects), path:"/");

        return $model;
    }

    /**
     * This gets the project file based on the selected previous uploaded project
     * @param int $projectId The id of the project
     */
    private function ProjectFromPreviousFile(string $projectId): ProjectModel {
        $model = new ProjectModel;

        $projectFile = Helpers::MapPath("../temp/".$projectId.".json");
        $_SESSION["ConfigFile"] = $projectFile;

        return $model;
    }
}