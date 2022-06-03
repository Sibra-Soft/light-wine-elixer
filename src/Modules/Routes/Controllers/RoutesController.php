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

    }

    public function Update(){

    }

    /**
     * Remove a specified route from the database
     */
    public function Delete(){
        $routeId = RequestVariables::Get("route_id");

        $this->routeService->DeleteRoute($routeId);
    }
}