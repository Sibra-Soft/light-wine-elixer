<?php
namespace Elixer\Core\Controllers;

use Elixer\Core\Services\LoginService;

class LoginController
{
    private LoginService $loginService;

    public function __construct(){
        $this->loginService = new LoginService();
    }

    public function HandleLogin(){
        $this->loginService->Login();
    }

    public function HandleLogoff(){
        $this->HandleLogoff();
    }
}