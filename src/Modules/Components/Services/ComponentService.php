<?php
namespace Elixer\Modules\Components\Services;

use LightWine\Modules\Database\Services\MysqlConnectionService;
use LightWine\Components\Account\Models\AccountComponentModel;
use LightWine\Components\Dataview\Models\DataviewComponentModel;
use LightWine\Core\Helpers\StringHelpers;
use LightWine\Components\Account\Integration\AccountComponentBluePrint;
use LightWine\Components\Dataview\Integration\DataviewComponentBluePrint;
use LightWine\Core\HttpResponse;
use LightWine\Components\DeviceVerification\Models\DeviceVerificationComponentModel;

use Elixer\Modules\Components\Models\ComponentFieldModel;

use \ReflectionClass;

class ComponentService
{
    private MysqlConnectionService $databaseService;

    public function __construct(){
        $this->databaseService = new MysqlConnectionService();
    }

    /**
     * Delete a component based on the id
     * @param int $id The id of the component you want to delete
     */
    public function DeleteComponent(int $id){

    }

    public function Save(int $id, string $settings){

    }

    /**
     * Create a component based on the type and name
     * @param string $name The name of the component you want to add
     * @param string $type The type of the component you want to add
     */
    public function CreateComponent(string $name, string $type){
        $componentModel = [];

        switch($type){
            case "account": $componentModel = new AccountComponentModel; break;
            case "device-verification": $componentModel = new DeviceVerificationComponentModel; break;
            case "dataview": $componentModel = new DataviewComponentModel; break;
        }

        $this->databaseService->ClearParameters();

        $this->databaseService->AddParameter("name", $name);
        $this->databaseService->AddParameter("type", $type);
        $this->databaseService->AddParameter("settings", json_encode($componentModel));
        $this->databaseService->AddParameter("added_by", $_SESSION["UserFullname"]);
        $this->databaseService->AddParameter("mode", $componentModel->Mode);

        $newComponentId = $this->databaseService->helpers->UpdateOrInsertRecordBasedOnParameters("site_dynamic_content");

        HttpResponse::SetReturnJson(["component" => $newComponentId]);
    }

    /**
     * Gets the components from the database
     */
    public function GetComponents(){
        HttpResponse::SetReturnJson(["components" => $this->databaseService->ExecuteQueryBasedOnFile("../src/Modules/Components/Queries/GET_COMPONENTS.sql")]);
    }

    /**
     * Gets the component from the database based on the specified id
     * @param int $id The id of the component you want to get
     */
    public function GetComponentByIdAndGenerateLayout(int $id){
        $this->databaseService->ClearParameters();
        $this->databaseService->AddParameter("componentId", $id);
        $this->databaseService->GetDataset("
            SELECT
	            dync.`name`,
	            dync.`mode`,
	            dync.type,
	            dync.settings
            FROM site_dynamic_content AS dync
            WHERE dync.id = ?componentId
            LIMIT 1;
        ");

        $type = $this->databaseService->DatasetFirstRow("type");
        $values = json_decode($this->databaseService->DatasetFirstRow("settings"), true);

        $this->GenerateLayout($type, $values);
    }

    /**
     * Generates the layout containg all the fields of the specified component
     */
    public function GenerateLayout(string $componentType, array $componentValues = []){
        $fields = [];

        // Get the componentmodel based on the typeof component
        switch($componentType){
            case "account":
                $componentModel = new AccountComponentModel;
                $componentBlueprint = new AccountComponentBluePrint;
                break;

            case "dataview":
                $componentModel = new DataviewComponentModel;
                $componentBlueprint = new DataviewComponentBluePrint;
                break;
        }

        // Get the component
        $class_vars = get_class_vars(get_class($componentModel));

        // Get the component integration blueprint
        $bluePrint = get_class_vars(get_class($componentBlueprint));

        foreach ($class_vars as $name => $value) {
            $bluePrints = [];
            $field = new ComponentFieldModel;

            if(property_exists(get_class($componentBlueprint), $name)) $bluePrints = $bluePrint[$name];

            $field->Name = $name;
            $field->Caption = (array_key_exists("Caption", $bluePrints)) ? $bluePrints["Caption"] : $name;
            $field->Remark = (array_key_exists("Description", $bluePrints)) ? $bluePrints["Description"] : "";
            $field->Value = (StringHelpers::IsNullOrWhiteSpace($componentValues[$name])) ? "" : $componentValues[$name];
            $field->Type = (array_key_exists("Field", $bluePrints)) ? $bluePrints["Field"] : gettype($class_vars[$name]);
            $field->Group = (array_key_exists("Group", $bluePrints)) ? $bluePrints["Group"] : "";
            $field->Tab = (array_key_exists("Tab", $bluePrints)) ? $bluePrints["Tab"] : "";

            if(array_key_exists("FieldValues", $bluePrints)){
                // Get the values of the specified class (enum)
                if(class_exists($bluePrints["FieldValues"])){
                    $valus = new ReflectionClass($bluePrints["FieldValues"]);
                    $field->Values = ["Type" => "ClassList", "Values" => $valus->getConstants()];
                }else{
                    // Get the values based on a query
                    if(StringHelpers::Contains($bluePrints["FieldValues"], "templates")){
                        $tempateType = StringHelpers::SplitString($bluePrints["FieldValues"], "~", 1);
                        $dataset = $this->databaseService->GetDataset("SELECT name, id FROM `site_templates` WHERE type = '$tempateType' ORDER BY `name`");
                        $field->Values = ["Type" => "KeyValuePair", "Values" => $dataset];
                    }
                }

                // Todo: Get values of a commaseperated list
            }

            array_push($fields, $field);
        }

        HttpResponse::SetReturnJson(["fields" => $fields]);
    }
}