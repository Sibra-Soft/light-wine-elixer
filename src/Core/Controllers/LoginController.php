<?php
namespace Elixer\Core\Controllers;

use Elixer\Core\Services\LoginService;

class LoginController
{
    private LoginService $loginService;

    public function __construct(){
        $this->loginService = new LoginService();
    }

    /**
     * Handles the login
     */
    public function HandleLogin(){
        $this->loginService->Login();
    }

    /**
     * Handles the logoff
     */
    public function HandleLogoff(){
        $this->HandleLogoff();
    }
}