<?php
namespace Elixer\Core\Services;

use Elixer\Core\Models\ProjectModel;

use LightWine\Core\Helpers\Helpers;
use LightWine\Core\HttpResponse;
use LightWine\Modules\Database\Services\MysqlConnectionService;

class ProjectService
{
    /**
     * Creates a new project based on the specified model
     * @param ProjectModel $project Model containing the details of the project
     */
    public function Create(ProjectModel $project){
        $hash = Helpers::NewGuid();

        $project = [
            "Name" => $project->Name,
            "Domain" => $project->Domain,
            "Connections" => [
                "DefaultConnectionString" => $project->Connectionstring
            ],
            "CacheFolder" => "../cache/",
            "Environment" => $project->Environment,
            "Tracing" => $project->Tracing,
            "LogTraffic" => $project->LogAllTraffic,
            "CreateDebugLog" => $project->DebugLog,
            "LogDatabase" => $project->LogAllErrors,
            "GzipEncode" => $project->EnableGzipCompression
        ];

        // Save file
        $file = $_SERVER["DOCUMENT_ROOT"]."/temp/".$hash.".json";
        file_put_contents($file, json_encode($project));

        HttpResponse::SetReturnJson(["hash" => $hash]);
    }

    /**
     * Downloads a created project file based on the hash
     * @param string $hash The hash of the project file to download
     */
    public function Download(string $hash){
        // Download file
        $file = $_SERVER["DOCUMENT_ROOT"]."/temp/".$hash.".json";

        header('Content-Type: application/octet-stream');
        header("Content-Transfer-Encoding: Binary");
        header("Content-disposition: attachment; filename=\"" . basename($file) . "\"");

        readfile($file);
        unlink($file);
    }

    /**
     * Runs all the queries for tables and data that is need for running the framework
     */
    public function RunQueries(){
        $databaseService = new MysqlConnectionService();

        $tableQueriesPath = $_SERVER["DOCUMENT_ROOT"]."/queries/tables";
        $dataQueriesPath = $_SERVER["DOCUMENT_ROOT"]."/queries/initial_data";

        // Run all table queries
        foreach(glob($tableQueriesPath.'/*.sql') as $file) {
            $databaseService->ExecuteQueryBasedOnFile($file);
        }

        // Run all data queries
        foreach(glob($dataQueriesPath.'/*.sql') as $file) {
            $databaseService->ExecuteQueryBasedOnFile($file);
        }
    }
}