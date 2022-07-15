<?php
namespace Elixer\Core\Services;

use LightWine\Modules\RegexBuilder\Services\RegexBuilderService;
use LightWine\Core\Route;
use LightWine\Modules\Routing\Models\RouteModel;

use Elixer\Core\Interfaces\IRoutingService;

class RoutingService implements IRoutingService
{

    /**
     * Gets the parameters from the current routing pattern
     * @param array $arr The parameter matches
     * @return array The parameters from the current route
     */
    private function GetRoutingParameters(array $arr): array {
        foreach ($arr as $key => $value) {
            if (is_int($key)) {
                unset($arr[$key]);
            }
        }

        return $arr;
    }

    /**
     * Adds the current parameters to the request
     * @param array $parameters Array of parameters
     */
    private function AddRoutingParametersToRequest(array $parameters){
        foreach ($parameters as $Parameter => $Value){
            $_GET[$Parameter] = str_replace("/", "", $Value);
        }
    }

    /**
     * Adds the current routes to the cache
     */
    private function AddRoutingToCache(){
        $this->cacheService->AddArrayToCache("routing", Route::$Routes);
    }

    /**
     * This functions generates the matching pattern for urls
     * @param string $url The url to convert to a matching pattern
     * @return string The matching pattern
     */
    private function GenerateMatchingPattern(string $url): string {
        $parts = explode("/", $url);
        $pattern = RegexBuilderService::Expression()->startOfString("");
        $counter = 0;

        foreach($parts as $part){
            if(preg_match("/(?<=\{).+?(?=\})/", $part, $matches)){
                foreach($matches as $match){
                    $part = str_replace("{".$match."}", RegexBuilderService::Group($match)->raw(".*?"), $part);
                }
            }

            if($counter == count($parts)-1){
                $pattern->raw($part)->endOfString();
            }else{
                $pattern->raw($part)->raw("/");
            }

            $counter++;
        }

        $pattern = str_replace("/", "\/", $pattern);

        return $pattern;
    }

    /**
     * Main function for getting the url from the current request
     * @param string $url The url of the current request
     * @return RouteModel The routemodel created from the current request
     */
    public function MatchRouteByUrl(string $url): RouteModel {
        $returnModel = new RouteModel;

        // Loop trough routes to match the current url
        foreach(Route::$Routes as $route){
            $pattern = $this->GenerateMatchingPattern($route["url"]);

            if(preg_match($pattern, $url, $matches)){
                $this->AddRoutingParametersToRequest($this->GetRoutingParameters($matches));

                $returnModel->MatchPattern = $pattern;
                $returnModel->NotFound = false;
                $returnModel->MetaTitle = "";
                $returnModel->MetaDescription = "";
                $returnModel->Type = $route["type"];
                $returnModel->Datasource = $route["source"];
                $returnModel->MetaTitle = "Elixer";
                $returnModel->MetaDescription = "Elixer";
                $returnModel->AllowedMethod = $route["method"];
                $returnModel->Options = $route["options"];

                break;
            }else{
                $returnModel->NotFound = true;
            }
        }

        return $returnModel;
    }
}