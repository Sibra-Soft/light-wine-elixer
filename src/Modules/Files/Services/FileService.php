<?php
namespace Elixer\Modules\Files\Services;

use LightWine\Core\Helpers\Helpers;
use LightWine\Core\HttpResponse;
use LightWine\Modules\Database\Services\MysqlConnectionService;
use LightWine\Core\Helpers\RequestVariables;

use Elixer\Modules\Files\Interfaces\IFileService;

class FileService implements IFileService
{
    private MysqlConnectionService $databaseConnection;

    public function __construct(){
        $this->databaseConnection = new MysqlConnectionService();
    }

    /**
     * Upload a file that has been added to the Post formdata
     */
    public function UploadFile(){
        $this->databaseConnection->helpers->UploadBlob();
    }

    /**
     * Download the file(s) with the specified id(s)
     * @param array $ids The id(s) of the file(s) you want to download
     */
    public function Download(array $ids){

    }

    /**
     * Gets all the website files from the database
     */
    public function GetFiles(){
        $query = Helpers::GetFileContent("../src/Modules/Files/Queries/GET_FILES.sql");

        $this->databaseConnection->ClearParameters();
        $this->databaseConnection->AddParameter("parent", RequestVariables::Get("parent", "#"));

        $dataset = $this->databaseConnection->GetDataset($query);

        HttpResponse::SetReturnJson(["files" => $dataset]);
    }

    /**
     * Deletes a specified file from the database based on the specified id
     * @param string $id Comma separated list of ids of the records you want to delete
     */
    public function DeleteFile(string $ids){
        $this->databaseConnection->helpers->DeleteMultipleRecords("site_files", $ids);
        exit();
    }

    /**
     * Renames a file in the database
     * @param int $id The id of the file you want to rename
     * @param string $newName The new name for the file
     */
    public function RenameFile(int $id, string $newName){
        $this->databaseConnection->ClearParameters();

        $this->databaseConnection->AddParameter("filename", $newName);

        $this->databaseConnection->helpers->UpdateOrInsertRecordBasedOnParameters("site_files", $id);
        exit();
    }

    /**
     * Add a folder to the database
     * @param string $name The name of the folder you want to add
     */
    public function AddFolder(string $name){
        $this->databaseConnection->ClearParameters();

        $this->databaseConnection->AddParameter("filename", $name);
        $this->databaseConnection->AddParameter("type", "folder");
        $this->databaseConnection->AddParameter("parent_id", 0);

        $this->databaseConnection->helpers->UpdateOrInsertRecordBasedOnParameters("site_files");
        exit();
    }
}