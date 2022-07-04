<?php
namespace Elixer\Modules\Users\Services;

use LightWine\Core\Helpers\Helpers;
use LightWine\Core\HttpResponse;
use LightWine\Modules\Database\Services\MysqlConnectionService;

class UsersService
{
    private MysqlConnectionService $databaseService;

    public function __construct(){
        $this->databaseService = new MysqlConnectionService();
    }

    public function GetUsers(){
        $query = Helpers::GetFileContent("../src/Modules/Users/Queries/GET_USERS.sql");

        $this->databaseService->ClearParameters();
        $dataset = $this->databaseService->GetDataset($query);

        HttpResponse::SetReturnJson(["users" => $dataset]);
    }

    public function GetRoles(){
        $query = Helpers::GetFileContent("../src/Modules/Users/Queries/GET_ROLES.sql");

        $this->databaseService->ClearParameters();
        $dataset = $this->databaseService->GetDataset($query);

        HttpResponse::SetReturnJson(["roles" => $dataset]);
    }
}