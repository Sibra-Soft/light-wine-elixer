<?php
namespace Elixer\Modules\Deployment\Services;

use LightWine\Core\Helpers\RequestVariables;
use LightWine\Core\Helpers\StringHelpers;
use LightWine\Core\HttpResponse;
use LightWine\Modules\Database\Services\MysqlConnectionService;
use LightWine\Core\Helpers\Helpers;

use Elixer\Modules\Deployment\Interfaces\IDeploymentService;

class DeploymentService implements IDeploymentService
{
    private MysqlConnectionService $databaseService;

    public function __construct(){
        $this->databaseService = new MysqlConnectionService();
    }

    /**
     * Commits the selected template(s) to the specified enviroment(s)
     * @param array $templates Array of template id's to commit
     * @param array $environments The enviroment the templates must be commited to
     */
    public function CommitTemplates(array $templates, array $environments){
        $templateIds = StringHelpers::JoinString($templates, ",");

        $this->databaseService->ClearParameters();
        $this->databaseService->AddParameter("description", RequestVariables::Get("description"));
        $this->databaseService->AddParameter("created_by", $_SESSION["UserFullname"]);
        $this->databaseService->AddParameter("templates", $templateIds);

        $commitId = $this->databaseService->helpers->UpdateOrInsertRecordBasedOnParameters("_commits");

        $this->databaseService->ClearParameters();
        $this->databaseService->AddParameter("commitId", $commitId);
        $this->databaseService->ExecuteQuery("
            INSERT INTO _commits_objects (commit_id, template_id, template_version)
            SELECT ?commitId, id, template_version_dev FROM site_templates WHERE id IN (".$templateIds.")
        ");

        HttpResponse::SetReturnJson(["commits" => $templates]);
    }

    /**
     * Get the available commits
     */
    public function GetCommits(){
        $query = Helpers::GetFileContent("../src/Modules/Deployment/Queries/AVAILABLE_COMMITS.sql");

        $this->databaseService->ClearParameters();
        $dataset = $this->databaseService->GetDataset($query);

        HttpResponse::SetReturnJson(["commits" => $dataset]);
    }
}