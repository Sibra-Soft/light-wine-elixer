<?php
namespace Elixer\Modules\Components\Models;

class ComponentFieldModel
{
    public string $Name = "";
    public string $Caption = "";
    public string $Value = "";
    public string $DefaultValue = "";
    public string $Type = "";
    public string $Remark = "";
    public string $RemarkDeveloper = "";
    public string $Group = "";
    public string $Tab = "";

    public array $Values = [];
}