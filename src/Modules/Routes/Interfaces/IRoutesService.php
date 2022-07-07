<?php
namespace Elixer\Modules\Routes\Interfaces;

interface IRoutesService
{
    public function DeleteRoute(int $id);
    public function AddRoute(string $type, string $method, string $name, string $path, string $datasourceType, string|int $datasource, array $parameters = []);
    public function Publish(string $ids);
}
