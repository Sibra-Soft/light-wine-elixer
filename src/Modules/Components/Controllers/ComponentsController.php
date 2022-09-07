<?php
namespace Elixer\Modules\Components\Controllers;

use Elixer\Modules\Components\Services\ComponentService;
use LightWine\Core\Helpers\RequestVariables;

class ComponentsController
{
    private ComponentService $componentService;

    public function __construct(){
        $this->componentService = new ComponentService();
    }

    /**
     * Gets the components from the database
     */
    public function Get(){
        $this->componentService->GetComponents();
    }

    /**
     * Gets the fields of a specified component
     */
    public function GetLayout(){
        $componentId = RequestVariables::Get("component");

        $this->componentService->GetComponentByIdAndGenerateLayout($componentId);
    }

    /**
     * Deletes a component based on the specified id
     */
    public function Delete(){
        $id = (int)RequestVariables::Get("id");

        $this->componentService->DeleteComponent($id);
    }

    /**
     * Creates a new component based on the specified type and name
     */
    public function Create(){
        $name = RequestVariables::Get("name");
        $type = RequestVariables::Get("type");

        $this->componentService->CreateComponent($name, $type);
    }
}