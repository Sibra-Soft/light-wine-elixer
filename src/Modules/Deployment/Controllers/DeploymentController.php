<?php
namespace Elixer\Modules\Deployment\Controllers;

use Elixer\Modules\Deployment\Services\DeploymentService;
use LightWine\Core\Helpers\RequestVariables;

class DeploymentController
{
    private DeploymentService $deploymentService;

    public function __construct(){
        $this->deploymentService = new DeploymentService();
    }

    public function GetCommits(){
        $this->deploymentService->GetCommits();
    }

    public function Commit(){
        $templates = RequestVariables::Get("items");
        $enviroments = RequestVariables::Get("enviroments");

        $this->deploymentService->CommitTemplates($templates, $enviroments);
    }
}