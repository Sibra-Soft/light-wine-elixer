<?php
namespace Elixer\Modules\Templates\Models;

use \DateTime;

class TemplateModel
{
    public string $Name = "";
    public string $Type = "html";
    public string $Policies = "";
    public string $CreatedBy = "";
    public string $ModifiedBy = "";
    public string $Content = "";

    public int $Id = 0;
    public int $Folder = 0;
    public int $Order = 0;
    public int $Icon = 0;
    public int $Version = 1;
    public int $CachingHours = 0;
    public int $SizeInBytes = 0;

    public bool $Enabled = true;

    public DateTime $DateMofified;
    public DateTime $DateCreated;

    public array $Scripts = [];
    public array $Stylesheets = [];
}