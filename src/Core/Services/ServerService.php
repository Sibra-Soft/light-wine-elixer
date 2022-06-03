<?php
namespace Elixer\Core\Services;

use LightWine\Core\Enums\RouteTypeEnum;
use LightWine\Core\HttpResponse;
use LightWine\Core\HttpRequest;
use LightWine\Core\Helpers\StringHelpers;

class ServerService
{
    private RoutingService $routingService;
    private PageService $pageService;

    public function __construct(){
        $this->routingService = new RoutingService();
        $this->pageService = new PageService();
    }

    /**
     * Runs a webmethod based on a file on the server or template from the cms
     * @param string $module The name of the module to run
     * @return string The return content of the function
     */
    private function RunWebMethod(string $module): string {
        if(class_exists('Elixer\\Providers\\'.$module.'\\'.$module)){
            $class = 'Elixer\\Providers\\'.$module.'\\'.$module;
            $pageObject = new $class;

            if(method_exists($pageObject , "Render")){
                return call_user_func(array($pageObject, 'Render'));
            }else{
                return "";
            }
        }

        return "";
    }

    private function RunController(string $source): string {
        $path = StringHelpers::SplitString($source, "~", 0);
        $classFilename = StringHelpers::SplitString(StringHelpers::SplitString($source, "~", 1), "@", 0);
        $className =  StringHelpers::SplitString(StringHelpers::SplitString($source, "~", 1), "@", 1);

        if(class_exists('Elixer\\'.$path.'\\Controllers\\'.$classFilename)){
            $class = 'Elixer\\'.$path.'\\Controllers\\'.$classFilename;
            $pageObject = new $class;

            if(method_exists($pageObject , $className)){
                return call_user_func(array($pageObject, $className));
            }else{
                return "";
            }
        }

        return "";
    }

    /**
     * Starts a new instance of the framework server
     * @return string The content to return to the webbrowser
     */
    public function Start(): string {
        $content = "";
        $route = $this->routingService->MatchRouteByUrl(HttpRequest::RequestUrlWithoutQuerystring());

        // Show error page if the requested route could not be found
        if($route->NotFound) HttpResponse::ShowError(404, "Not found", "The specified content could not be found");

        if((bool)$route->Options["LoginRequired"] && !isset($_SESSION["Checksum"])){
            HttpResponse::ShowError(403, "Forbidden", "You do not have permission to access the requested content");
        }

        // Check the type of the current route
        switch($route->Type){
            case RouteTypeEnum::VIEW: $content = $this->pageService->Render($route)->Content; break;
            case RouteTypeEnum::WEBMETHOD: $content = $this->RunWebMethod($route->Datasource); break;
            case RouteTypeEnum::CONTROLLER: $content = $this->RunController($route->Datasource); break;
        }

        return $content;
    }
}