<?php
namespace Elixer\Modules\Routes\Services;

use Elixer\Modules\Routes\Interfaces\IRoutesService;

use LightWine\Modules\Database\Services\MysqlConnectionService;
use LightWine\Core\Helpers\RequestVariables;
use LightWine\Core\Helpers\Helpers;
use LightWine\Core\HttpResponse;

class RoutesService implements IRoutesService
{
    private MysqlConnectionService $databaseConnection;

    public function __construct(){
        $this->databaseConnection = new MysqlConnectionService();
    }

    /**
     * Remove a specified route based on the record id
     * @param int $id The id of the route you want to delete
     */
    public function DeleteRoute(int $id){
        $this->databaseConnection->helpers->DeleteRecord("site_routes", $id);
    }

    /**
     * Add a new route to the database
     * @param string $Method The method that must be used when reqeusting the route
     * @param string $Name The name of the route
     * @param string $Path The path of the route that must be used
     */
    public function AddRoute(string $Method, string $Name, string $Path){
        $this->databaseConnection->ClearParameters();

        $this->databaseConnection->AddParameter("name", $Name);
        $this->databaseConnection->AddParameter("url", $Path);
        $this->databaseConnection->AddParameter("method", $Method);

        $this->databaseConnection->helpers->UpdateOrInsertRecordBasedOnParameters("site_routes");
    }

    /**
     * Get all the routes
     */
    public function GetRoutes(){
        $query = Helpers::GetFileContent("../src/Modules/Routes/Queries/GET_ROUTES.sql");
        $dataset = $this->databaseConnection->GetDataset($query);

        HttpResponse::SetReturnJson($dataset);
    }
}