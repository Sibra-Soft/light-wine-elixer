<?php
namespace Elixer\Modules\Templates\Interfaces;

use Elixer\Modules\Templates\Models\TemplateModel;

interface ITemplatesService
{
    public function AddNewFolder(string $name, int $parent): int;
    public function AddNewTemplate(TemplateModel $template): int;
    public function DeleteTemplate(int $id);
    public function RenameTemplate(int $id, string $name);
    public function MoveTemplateToFolder(int $id, int $folderId);
    public function SaveNewVersion(int $id, string $content, int $version = null);
    public function GetTreeview();
    public function Get(int $templateId): TemplateModel;
    public function AddExternalFile(string $url);
}
