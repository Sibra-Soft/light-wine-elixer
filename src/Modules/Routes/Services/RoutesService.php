<?php
namespace Elixer\Modules\Routes\Services;

use Elixer\Modules\Routes\Interfaces\IRoutesService;

use LightWine\Core\Helpers\StringHelpers;
use LightWine\Modules\Database\Services\MysqlConnectionService;
use LightWine\Core\HttpResponse;

class RoutesService implements IRoutesService
{
    private MysqlConnectionService $databaseConnection;

    public function __construct(){
        $this->databaseConnection = new MysqlConnectionService();
    }

    /**
     * Adds the specified parameters to the route
     * @param int $routeId The id of the route, you want to add the parameters to
     * @param array $parameters A array containing the parameters
     */
    private function AddParametersToRoute(int $routeId, array $parameters){

    }

    /**
     * Remove a specified route based on the record id
     * @param int $ids The ids of the routes you want to delete
     */
    public function DeleteRoute(int $ids){
        $this->databaseConnection->helpers->DeleteMultipleRecords("site_routes", $ids);

        HttpResponse::SetReturnJson(["route" => $ids]);
    }

    /**
     * Gets all the datasources
     */
    public function GetDatasources(){
        $result = [];

        $result["templates"] = $this->databaseConnection->ExecuteQueryBasedOnFile("../src/Modules/Routes/Queries/GET_DATASOURCE_TEMPLATES.sql");
        $result["queries"] = $this->databaseConnection->ExecuteQueryBasedOnFile("../src/Modules/Routes/Queries/GET_DATASOURCE_QUERIES.sql");
        $result["tables"] = $this->databaseConnection->ExecuteQueryBasedOnFile("../src/Modules/Routes/Queries/GET_DATASOURCE_TABLES.sql");

        HttpResponse::SetReturnJson($result);
    }

    /**
     * Publishes the specified routes, based on the specified route ids
     * @param string $ids The ids of the routes you want to publish
     */
    public function Publish(string $ids){
        $this->databaseConnection->ClearParameters();
        $this->databaseConnection->ExecuteQuery("UPDATE `site_routes` SET published = 1 WHERE id IN (".$ids.")");

        HttpResponse::SetReturnJson(["updates" => $this->databaseConnection->rowsAffected]);
    }

    /**
     * Add a new route to the database
     * @param string $type The type of route (page, api or redirect)
     * @param string $method The method that must be used when reqeusting the route
     * @param string $name The name of the route
     * @param string $path The path of the route that must be used
     * @param string $datasourceType The type of datasource you want to use for the new route
     * @param string|int $datasource The datasource for the route (template, url, query or table)
     * @param array $parameters A array containing all the parameters that must be added to the route
     */
    public function AddRoute(string $type, string $method, string $name, string $path, string $datasourceType, string|int $datasource, array $parameters = []){
        $this->databaseConnection->ClearParameters();

        if($type === "api"){
            $this->databaseConnection->AddParameter("name", $name);
            $this->databaseConnection->AddParameter("match_pattern", $path);
            $this->databaseConnection->AddParameter("allowed_methodes", strtoupper($method));
            $this->databaseConnection->AddParameter("datasource", $datasourceType.":".$datasource);

            $newRouteId = $this->databaseConnection->helpers->UpdateOrInsertRecordBasedOnParameters("site_rest_api");

            $this->AddParametersToRoute($newRouteId, $parameters);
        }else{
            $this->databaseConnection->AddParameter("name", $name);
            $this->databaseConnection->AddParameter("url", $path);
            $this->databaseConnection->AddParameter("published", 0);
            $this->databaseConnection->AddParameter("template_id", $datasource);

            if($type === "redirect"){
                $methodName = StringHelpers::SplitString($method, "-", 0);
                $redirectType = StringHelpers::SplitString($method, "-", 1);

                $this->databaseConnection->AddParameter("method", strtoupper(trim($methodName)));
                $this->databaseConnection->AddParameter("redirect_url", $datasource);
                $this->databaseConnection->AddParameter("redirect_type", trim($redirectType));
                $this->databaseConnection->AddParameter("type", "redirect");
            }else{
                $this->databaseConnection->AddParameter("method", strtoupper($method));
                $this->databaseConnection->AddParameter("type", "template-link");
            }

            $newRouteId = $this->databaseConnection->helpers->UpdateOrInsertRecordBasedOnParameters("site_routes");
        }

        HttpResponse::SetReturnJson(["route_id" => $newRouteId]);
    }

    /**
     * Get all the routes
     */
    public function GetRoutes(){
        HttpResponse::SetReturnJson(["routes" => $this->databaseConnection->ExecuteQueryBasedOnFile("../src/Modules/Routes/Queries/GET_ROUTES.sql")]);
    }
}