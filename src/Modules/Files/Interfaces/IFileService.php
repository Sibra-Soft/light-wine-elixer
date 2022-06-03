<?php
namespace Elixer\Modules\Files\Interfaces;

interface IFileService
{
    public function UploadFile();
    public function GetFiles();
    public function DeleteFile(string $ids);
    public function RenameFile(int $id, string $newName);
    public function AddFolder(string $name);
}
