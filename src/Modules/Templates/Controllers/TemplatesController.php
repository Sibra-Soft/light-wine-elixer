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
     * Adds a external resource file to the database
     */
    public function AddExternalFile(){
        $url = RequestVariables::Get("url");

        $this->templateService->AddExternalFile($url);
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

        $this->templateService->AddNewTemplate($model);
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
}