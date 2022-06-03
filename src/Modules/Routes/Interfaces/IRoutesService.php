<?php
namespace Elixer\Modules\Routes\Interfaces;

interface IRoutesService
{
    public function DeleteRoute(int $id);
    public function AddRoute(string $Method, string $Name, string $Path);
}
