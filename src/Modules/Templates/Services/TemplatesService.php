<?php
namespace Elixer\Modules\Templates\Services;

use Elixer\Modules\Templates\Interfaces\ITemplatesService;
use Elixer\Modules\Templates\Models\TemplateModel;

use LightWine\Modules\Database\Services\MysqlConnectionService;
use LightWine\Core\Helpers\Helpers;
use LightWine\Core\HttpResponse;
use LightWine\Modules\Templating\Services\StringTemplaterService;

class TemplatesService implements ITemplatesService
{
    private MysqlConnectionService $databaseService;
    private StringTemplaterService $stringTemplaterService;

    public function __construct(){
        $this->databaseService = new MysqlConnectionService();
        $this->stringTemplaterService = new StringTemplaterService();
    }

    /**
     * Links the specified resources to a specified template
     * @param int $templateId The id of the template you want to link the resources to
     * @param string $scriptResources The linked script resources
     * @param string $styleResources  The linked stylesheet resources
     */
    public function LinkResources(int $templateId, string $scriptResources, string $styleResources){
        $this->databaseService->ClearParameters();
        
        $this->databaseService->AddParameter("scripts", $scriptResources);
        $this->databaseService->AddParameter("stylesheets", $styleResources);

        $this->databaseService->helpers->UpdateOrInsertRecordBasedOnParameters("site_templates", $templateId);

        HttpResponse::SetReturnJson(["template" => $templateId, "updates" => $this->databaseService->rowsAffected]);
    }

    /**
     * Gets the resources and linked resources of a specified template
     * @param int $htmlTemplate The template you want to get the linked resources of
     */
    public function GetResourceTemplates(int $htmlTemplate){
        $this->databaseService->ClearParameters();
        $this->databaseService->AddParameter("selected_template", $htmlTemplate);

        $dataset = $this->databaseService->ExecuteQueryBasedOnFile("../src/Modules/Templates/Queries/GET_RESOURCES.sql");

        HttpResponse::SetReturnJson(["resources" => $dataset]);
    }

    /**
     * Adds a new folder to a parent folder
     * @param string $name The name of the new folder
     * @param int $parent The parent id of the folder to add the folder to
     * @return int The id of the new folder row in the templates table
     */
    public function AddNewFolder(string $name, int $parent): int {
        $this->databaseService->ClearParameters();

        $this->databaseService->AddParameter("name", $name);
        $this->databaseService->AddParameter("type", "folder");
        $this->databaseService->AddParameter("parent_id", $parent);
        $this->databaseService->AddParameter("created_by", $_SESSION["UserFullname"]);

        return $this->databaseService->helpers->UpdateOrInsertRecordBasedOnParameters("site_templates");
    }

    /**
     * Adds a new template
     * @param TemplateModel $template Model containing all the details of the template
     * @return int The id of the new template
     */
    public function AddNewTemplate(TemplateModel $template): int {
        $this->databaseService->ClearParameters();

        // Add new template
        $this->databaseService->AddParameter("name", $template->Name);
        $this->databaseService->AddParameter("type", $template->Type);
        $this->databaseService->AddParameter("parent_id", $template->Folder);
        $this->databaseService->AddParameter("created_by", $_SESSION["UserFullname"]);
        $this->databaseService->AddParameter("template_version_dev", 1);

        $templateId = $this->databaseService->helpers->UpdateOrInsertRecordBasedOnParameters("site_templates");

        // Add new version of the template
        $this->databaseService->ClearParameters();
        $this->databaseService->AddParameter("template_id", $templateId);
        $this->databaseService->AddParameter("version", 1);

        $this->databaseService->helpers->UpdateOrInsertRecordBasedOnParameters("site_template_versioning");

        return $templateId;
    }

    /**
     * Adds a external file (CDN) to the database
     * @param string $url The url of the file you want to add
     */
    public function AddExternalFile(string $url){

    }

    /**
     * Deletes a template
     * @param int $id The id of the template to remove
     */
    public function DeleteTemplate(int $id){
        $this->databaseService->helpers->DeleteRecord("site_templates", $id);

        $this->databaseService->ClearParameters();
        $this->databaseService->AddParameter("template", $id);
        $this->databaseService->ExecuteQuery("DELETE FROM `site_template_versioning` WHERE template_id = ?template");

        HttpResponse::SetReturnJson(["versions_deleted" => $this->databaseService->rowsAffected, "template" => $id]);
    }

    /**
     * Changes the name of a existing template
     * @param int $id The id of the template to rename
     * @param string $name The new name you want to give the template
     */
    public function RenameTemplate(int $id, string $name){
        $this->databaseService->ClearParameters();
        $this->databaseService->AddParameter("name", $name);
        $this->databaseService->helpers->UpdateOrInsertRecordBasedOnParameters("site_templates", $id);

        HttpResponse::SetReturnJson(["template" => $id, "new_name" => $name]);
    }

    /**
     * Copy a template to a specified folder
     * @param int $id The id of the template you want to copy
     * @param int $folder The folder the template must be copied to
     */
    public function CopyTemplate(int $id, int $folder){
        $template = $this->Get($id);

        // Copy the template
        $this->databaseService->ClearParameters();
        $this->databaseService->AddParameter("name", $template->Name."_copy");
        $this->databaseService->AddParameter("type", $template->Type);
        $this->databaseService->AddParameter("parent_id", $template->Folder);
        $this->databaseService->AddParameter("template_version_dev", 1);
        $templateId = $this->databaseService->helpers->UpdateOrInsertRecordBasedOnParameters("site_templates");

        // Copy the content of the template
        $this->databaseService->ClearParameters();
        $this->databaseService->AddParameter("template_id", $templateId);
        $this->databaseService->AddParameter("version", 1);
        $this->databaseService->AddParameter("content", $template->Content);
        $this->databaseService->helpers->UpdateOrInsertRecordBasedOnParameters("site_template_versioning");
    }

    /**
     * Moves a existing template to a existing folder
     * @param int $id The id of the template to move
     * @param int $folderId The folder id you want to move the template to
     */
    public function MoveTemplateToFolder(int $id, int $folderId){
        $this->databaseService->ClearParameters();
        $this->databaseService->AddParameter("parent_id", $folderId);
        $this->databaseService->helpers->UpdateOrInsertRecordBasedOnParameters("site_templates", $id);

        HttpResponse::SetReturnJson(["template" => $id, "move_to" => $folderId]);
    }

    /**
     * Saves a new version of the specified template
     * @param int $id The id of the template to update
     * @param string $content The content of the new version to save
     * @param int $version (optional) The version you want to overwrite
     */
    public function SaveNewVersion(int $id, string $content, int $version = null){
        // Get the number of the next version of the template
        $this->databaseService->ClearParameters();
        $this->databaseService->AddParameter("templateId", $id);
        $this->databaseService->GetDataset("
            SELECT
	            MAX(version) + 1 AS next_version,
	            template.`name` AS template_name
            FROM `site_template_versioning` AS version
            INNER JOIN `site_templates` AS template ON template.id = version.template_id
            WHERE template_id = ?templateId
            LIMIT 1
        ");

        $templateName = $this->databaseService->DatasetFirstRow("template_name", "string");
        $newVersionNumber = $this->databaseService->DatasetFirstRow("next_version", "integer");

        // Save the new version of the template to the database
        $this->databaseService->ClearParameters();
        $this->databaseService->AddParameter("template_id", $id);
        $this->databaseService->AddParameter("version", $newVersionNumber);
        $this->databaseService->AddParameter("content", $content);
        $this->databaseService->helpers->UpdateOrInsertRecordBasedOnParameters("site_template_versioning");

        // Update the version in the templates table
        $this->databaseService->ClearParameters();
        $this->databaseService->AddParameter("template_version_dev", $newVersionNumber);
        $this->databaseService->helpers->UpdateOrInsertRecordBasedOnParameters("site_templates", $id);

        HttpResponse::SetReturnJson([
            "template" => $id,
            "version" => $newVersionNumber,
            "name" => $templateName
        ]);
    }

    /**
     * Gets the treeview items as Json object
     */
    public function GetTreeview(){
        $query = Helpers::GetFileContent("../src/Modules/Templates/Queries/GET_TEMPLATES_TREEVIEW.sql");

        $this->databaseService->ClearParameters();
        $dataset = $this->databaseService->GetDataset($query);

        HttpResponse::SetReturnJson($dataset);
    }

    /**
     * Gets a specified template and all it's details
     * @param int $templateId The id of the template you want to get
     */
    public function Get(int $templateId): TemplateModel {
        $model = new TemplateModel;

        $query = Helpers::GetFileContent("../src/Modules/Templates/Queries/GET_TEMPLATE.sql");

        $this->databaseService->ClearParameters();
        $this->databaseService->AddParameter("templateId", $templateId);
        $this->databaseService->GetDataset($query);

        // Populate model
        $model->Id = $this->databaseService->DatasetFirstRow("id");
        $model->Name = $this->databaseService->DatasetFirstRow("name");
        $model->Content = $this->databaseService->DatasetFirstRow("content");
        $model->SizeInBytes = $this->databaseService->DatasetFirstRow("size", "integer");
        $model->Scripts = explode(",", $this->databaseService->DatasetFirstRow("scripts"));
        $model->Stylesheets = explode(",", $this->databaseService->DatasetFirstRow("stylesheets"));
        $model->DateCreated = $this->databaseService->DatasetFirstRow("date_added", "datetime");
        $model->DateMofified = $this->databaseService->DatasetFirstRow("date_modified", "datetime");
        $model->Type = $this->databaseService->DatasetFirstRow("type");
        $model->Version = $this->databaseService->DatasetFirstRow("version");
        $model->Folder = $this->databaseService->DatasetFirstRow("parent_id");

        return $model;
    }

    /**
     * This function creates a new binding for the specified template
     * @param string $name The name of the new binding to add
     * @param int $templateId The id of the template you want to add the binding to
     * @param int $datasourceTemplateId The id of the query template containg the query that fetches the data
     * @param bool $datasourceEmpty Tels if the result of the query can be empty
     * @param bool $returnJson Will return the result of the query in json format
     */
    public function NewBinding(string $name, int $templateId, int $datasourceTemplateId, bool $datasourceEmpty = false, bool $returnJson = false){
        $this->databaseService->ClearParameters();

        $this->databaseService->AddParameter("name", $name);
        $this->databaseService->AddParameter("type", "query-template");
        $this->databaseService->AddParameter("destination_template_id", $templateId);
        $this->databaseService->AddParameter("source_template_id", $datasourceTemplateId);
        $this->databaseService->AddParameter("result_can_be_empty", $datasourceEmpty, 0);
        $this->databaseService->AddParameter("result_as_json", $returnJson, 0);

        $bindingId = $this->databaseService->helpers->UpdateOrInsertRecordBasedOnParameters("site_bindings");

        HttpResponse::SetReturnJson(["binding_id" => $bindingId]);
    }
}