<?php
namespace Elixer\Core\Models;

class ProjectModel
{
    public string $File = "";
    public string $Name = "";
    public string $Connectionstring = "";
    public string $Hash = "";
    public string $Environment = "dev";
    public string $Domain = "";
    
    public bool $Tracing = false;
    public bool $LogAllTraffic = false;
    public bool $DebugLog = false;
    public bool $LogAllErrors = false;
    public bool $EnableGzipCompression = true;
}