<?php
namespace Elixer\Modules\Users\Controllers;

use Elixer\Modules\Users\Services\UsersService;

class UsersController
{
    private UsersService $usersService;

    public function __construct(){
        $this->usersService = new UsersService();
    }

    /**
     * Gets the users
     */
    public function GetUsers(){
        $this->usersService->GetUsers();
    }

    /**
     * Gets the roles
     */
    public function GetRoles(){
        $this->usersService->GetRoles();
    }
}