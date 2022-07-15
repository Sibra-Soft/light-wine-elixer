<?php
namespace Elixer\Core\Interfaces;

interface IPageService
{
    public function Render(RouteModel $route): PageModel;
}
