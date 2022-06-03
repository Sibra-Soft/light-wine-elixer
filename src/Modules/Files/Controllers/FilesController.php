<?php
namespace Elixer\Modules\Files\Controllers;

use Elixer\Modules\Files\Services\FileService;

use LightWine\Core\Helpers\RequestVariables;

class FilesController
{
    private FileService $fileService;

    public function __construct(){
        $this->fileService = new FileService();
    }

    /**
     * Gets all the files
     */
    public function Get(){
        $this->fileService->GetFiles();
    }

    /**
     * Upload a new file
     */
    public function Upload(){
        $this->fileService->UploadFile();
    }

    /**
     * Deletes a specified file
     */
    public function Delete(){
        $ids = RequestVariables::Get("ids");

        $this->fileService->DeleteFile($ids);
    }

    /**
     * Rename a file based on the id and new name
     */
    public function Rename(){
        $id = RequestVariables::Get("file_id");
        $name = RequestVariables::Get("new_name");

        $this->fileService->RenameFile($id, $name);
    }

    /**
     * Adds a folder to the database
     */
    public function AddFolder(){
        $name = RequestVariables::Get("name");

        $this->fileService->AddFolder($name);
    }

    /**
     * Download the specified file(s) based on the specified id(s)
     */
    public function Download(){
        $ids = explode(",", RequestVariables::Get("ids"));

        $this->fileService->Download($ids);
    }
}