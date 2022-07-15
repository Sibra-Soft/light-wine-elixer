<?php
namespace Elixer\Modules\Deployment\Interfaces;

interface IDeploymentService
{
    public function CommitTemplates(array $templates, array $environments);
    public function GetCommits();
}
