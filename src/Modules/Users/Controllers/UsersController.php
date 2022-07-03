<?php
namespace Elixer\Modules\Users\Controllers;

use Elixer\Modules\Users\Services\UsersService;
use LightWine\Core\Helpers\RequestVariables;

class UsersController
{
    private UsersService $usersService;

    public function __construct(){
        $this->usersService = new UsersService();
    }

    public function GetUsers(){
        $this->usersService->GetUsers();
    }
}