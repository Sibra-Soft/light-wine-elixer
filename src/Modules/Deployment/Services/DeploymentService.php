<?php
namespace Elixer\Modules\Deployment\Services;

use LightWine\Core\HttpResponse;
use LightWine\Modules\Database\Services\MysqlConnectionService;
use LightWine\Core\Helpers\Helpers;

class DeploymentService
{
    private MysqlConnectionService $databaseService;

    public function __construct(){
        $this->databaseService = new MysqlConnectionService();
    }

    /**
     * Get the available commits
     */
    public function GetCommits(){
        $query = Helpers::GetFileContent("../src/Modules/Deployment/Queries/AVAILABLE_COMMITS.sql");

        $this->databaseService->ClearParameters();
        $dataset = $this->databaseService->GetDataset($query);

        HttpResponse::SetReturnJson($dataset);
    }
}