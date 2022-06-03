<?php
namespace Elixer\Modules\Deployment\Controllers;

use Elixer\Modules\Deployment\Services\DeploymentService;

class DeploymentController
{
    private DeploymentService $deploymentService;

    public function __construct(){
        $this->deploymentService = new DeploymentService();
    }

    public function GetCommits(){
        $this->deploymentService->GetCommits();
    }
}