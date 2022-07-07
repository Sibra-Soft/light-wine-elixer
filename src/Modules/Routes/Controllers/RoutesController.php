<?php
namespace Elixer\Modules\Routes\Controllers;

use Elixer\Modules\Routes\Services\RoutesService;

use LightWine\Core\Helpers\RequestVariables;

class RoutesController
{
    private RoutesService $routeService;

    public function __construct(){
        $this->routeService = new RoutesService();
    }

    /**
     * Gets all the routes in Json format
     */
    public function Get(){
        $this->routeService->GetRoutes();
    }

    /**
     * Create a new route
     */
    public function Create(){
        $type = RequestVariables::Get("type");
        $method = RequestVariables::Get("method");
        $datasourceType = RequestVariables::Get("datasource_type");
        $datasource = RequestVariables::Get("datasource");
        $name = RequestVariables::Get("name");
        $path = RequestVariables::Get("path");
        $parameters = (array)RequestVariables::Get("parameters");

        $this->routeService->AddRoute($type, $method, $name, $path, $datasourceType, $datasource, $parameters);
    }

    /**
     * Will publish the specified route
     */
    public function Publish(){
        $ids = RequestVariables::Get("ids");

        $this->routeService->Publish($ids);
    }

    /**
     * Updates a specified route
     */
    public function Update(){
        $routeId = RequestVariables::Get("route_id");
    }

    /**
     * Gets the datasources
     */
    public function GetDatasources(){
        $this->routeService->GetDatasources();
    }

    /**
     * Remove a specified route from the database
     */
    public function Delete(){
        $routeId = (int)RequestVariables::Get("ids");

        $this->routeService->DeleteRoute($routeId);
    }
}