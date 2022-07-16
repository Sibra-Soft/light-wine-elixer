<?php
namespace Elixer\Core\Controllers;

use Elixer\Core\Models\ProjectModel;
use Elixer\Core\Services\ProjectService;

use LightWine\Core\Helpers\RequestVariables;

class ProjectController
{
    private ProjectService $projectService;

    public function __construct(){
        $this->projectService = new ProjectService();
    }

    /**
     * Create a new project based on the specified details
     */
    public function NewProject(){
        $model = new ProjectModel;

        $model->Name = RequestVariables::Get("name");
        $model->Environment = RequestVariables::Get("env");
        $model->Domain = RequestVariables::Get("domain");
        $model->Connectionstring = RequestVariables::Get("connection");
        $model->Tracing = RequestVariables::Get("checkbox_tracing");
        $model->LogAllTraffic = RequestVariables::Get("checkbox_log_all_traffic");
        $model->DebugLog = RequestVariables::Get("checkbox_debug_log");
        $model->LogAllErrors = RequestVariables::Get("checkbox_log_all_errors");
        $model->EnableGzipCompression = RequestVariables::Get("checkbox_gzip");

        $this->projectService->Create($model);
    }

    /**
     * Gets the file based on the specified hash
     */
    public function Download(){
        $hash = RequestVariables::Get("hash");

        $this->projectService->Download($hash);
        exit();
    }

    /**
     * Runs the initialize data queries
     */
    public function Setup(){
        $this->projectService->RunQueries();
    }
}