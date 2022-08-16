<?php
namespace Elixer\Modules\Templates\Controllers;

use Elixer\Modules\Templates\Services\TemplatesService;
use Elixer\Modules\Templates\Models\TemplateModel;

use LightWine\Core\Helpers\RequestVariables;
use LightWine\Modules\Database\Services\MysqlConnectionService;
use LightWine\Core\HttpResponse;

class TemplatesController
{
    private TemplatesService $templateService;
    private MysqlConnectionService $databaseService;

    public function __construct(){
        $this->templateService = new TemplatesService();
        $this->databaseService = new MysqlConnectionService();
    }

    /**
     * Links specified resources to a specified template
     */
    public function LinkResources(){
        $templateId = (int)RequestVariables::Get("template");
        $scripts = RequestVariables::Get("scripts");
        $stylesheets = RequestVariables::Get("stylesheets");

        $this->templateService->LinkResources($templateId, $scripts, $stylesheets);
    }

    /**
     * Gets the available resource templates
     */
    public function GetResources(){
        $templateId = (int)RequestVariables::Get("template");

        $this->templateService->GetResourceTemplates($templateId);
    }

    /**
     * Adds a external resource file to the database
     */
    public function AddExternalFile(){
        $url = RequestVariables::Get("package_url");
        $folder = RequestVariables::Get("folder");

        $this->templateService->AddExternalFile($url, $folder);
    }

    /**
     * Moves a template to a specified folder
     */
    public function Move(){
        $id = RequestVariables::Get("template_id");
        $target = RequestVariables::Get("target");

        $this->templateService->MoveTemplateToFolder($id, $target);
    }

    /**
     * Copy a template to a specified folder
     */
    public function Copy(){
        $id = RequestVariables::Get("template_id");
        $target = RequestVariables::Get("target");

        $this->templateService->CopyTemplate($id, $target);
    }

    /**
     * Add new folder to a parent folder
     */
    public function AddFolder(){
        $parentId = RequestVariables::Get("parent");
        $name = RequestVariables::Get("name");

        $this->templateService->AddNewFolder($name, $parentId);
    }

    /**
     * Handle the add new template request
     */
    public function AddTemplate(){
        $model = new TemplateModel;

        $model->Name = RequestVariables::Get("name");
        $model->Folder = RequestVariables::Get("folder");
        $model->Type = RequestVariables::Get("type");

        $newTemplateId = $this->templateService->AddNewTemplate($model);

        HttpResponse::SetReturnJson(["template_id" => $newTemplateId]);
    }

    /**
     * Handels the delete request for a template
     */
    public function Delete(){
        $id = RequestVariables::Get("template_id");

        $this->templateService->DeleteTemplate($id);
    }

    /**
     * Renames a item from the treeview
     */
    public function Rename(){
        $id = RequestVariables::Get("template_id");
        $newName = RequestVariables::Get("new_name");

        $this->templateService->RenameTemplate($id, $newName);
    }

    /**
     * Saves the content of the template
     */
    public function Save(){
        $id = RequestVariables::Get("template_id");
        $content = RequestVariables::Get("content");

        $this->templateService->SaveNewVersion($id, $content);
    }

    /**
     * Gets the items for the treeview
     */
    public function Treeview(){
        $this->templateService->GetTreeview();
    }

    /**
     * Gets a template from the database
     */
    public function Get(){
        $id = RequestVariables::Get("template_id");
        $content = $this->templateService->Get($id);

        HttpResponse::$MinifyHtml = false;
        HttpResponse::SetContentType("application/json");
        HttpResponse::SetData(json_encode($content));

        exit();
    }

    /**
     * Adds a new binding to a specified template
     */
    public function NewBinding(){
        $name = RequestVariables::Get("name");
        $templateId = (int)RequestVariables::Get("template_id");
        $datasource = (int)RequestVariables::Get("datasource");

        $this->templateService->NewBinding($name, $templateId, $datasource);
    }
}