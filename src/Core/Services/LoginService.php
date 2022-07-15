<?php
namespace Elixer\Core\Services;

use Elixer\Core\Interfaces\ILoginService;
use Elixer\Core\Models\ProjectModel;

use LightWine\Modules\Database\Services\MysqlConnectionService;
use LightWine\Modules\Sam\Services\SamService;
use LightWine\Core\Helpers\RequestVariables;
use LightWine\Core\Helpers\StringHelpers;
use LightWine\Core\HttpResponse;
use LightWine\Core\Helpers\Helpers;

class LoginService implements ILoginService
{
    /**
     * Login the user using the specified username and password
     */
    public function Login(){
        $username = RequestVariables::Get("login_username");
        $password = RequestVariables::Get("login_password");
        $project = RequestVariables::Get("project_id");

        if(StringHelpers::IsNullOrWhiteSpace($project)){
            $projectModel = $this->ProjectFromNewFile();
        }else{
            $projectModel = $this->ProjectFromPreviousFile($project);
        }

        $databaseService = new MysqlConnectionService();
        $sam = new SamService();
        $sam->passwordBlowFish = "SeQ3H55Dp9XxndP";

        $databaseService->ClearParameters();
        $databaseService->GetDataset("SELECT COUNT(*) AS `count` FROM information_schema.`TABLES` WHERE TABLE_SCHEMA = ?currentDatabase;");
        $tableCount = $databaseService->DatasetFirstRow("count", "integer");

        if($tableCount == 0){
            $response = ["response" => "MUST_BE_INSTALLED", "project" => $projectModel->Hash];
        }else{
            $login = $sam->Login($username, $password);

            if($login->LoginCorrect){
                $response = ["response" => "LOGIN_CORRECT", "project" => $projectModel->Hash];
            }else{
                $response = ["response" => "LOGIN_INCORRECT", "project" => $projectModel->Hash];
            }
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
        $model->Hash = $hash;

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

        $model->File = $projectFile;
        $model->Hash = $projectId;

        return $model;
    }
}