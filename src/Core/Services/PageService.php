<?php
namespace Elixer\Core\Services;

use LightWine\Core\Models\PageModel;
use LightWine\Modules\Database\Services\MysqlConnectionService;
use LightWine\Modules\Routing\Models\RouteModel;
use LightWine\Core\Helpers\Helpers;
use LightWine\Modules\Templating\Services\StringTemplaterService;
use LightWine\Core\Helpers\StringHelpers;
use LightWine\Core\Helpers\RequestVariables;
use LightWine\Modules\Templating\Services\TemplatingEngineService;

class PageService
{
    private StringTemplaterService $stringTemplater;
    private TemplatingEngineService $templatingEngine;

    public function __construct(){
        $this->stringTemplater = new StringTemplaterService();
        $this->templatingEngine = new TemplatingEngineService();
    }

    private function GetViewData(array $templateOptions): array {
        $return = [];

        if(array_key_exists("ViewData", $templateOptions)){
            $databaseService = new MysqlConnectionService();

            foreach($templateOptions["ViewData"] as $name => $query){
                $queryFile = Helpers::GetFileContent($query);
                $dataset = $databaseService->GetDataset($queryFile);

                $return = [$name => json_decode(json_encode($dataset), false)];
            }

            return $return;
        }else{
            return $return;
        }
    }

    /**
     * Gets the content of the files that must be included
     * @param string $template The template that contains include statements
     */
    private function HandleTemplateImports(string $template){
        preg_match_all('/(?<=\{{).+?(?=\}})/', $template, $matches);

        foreach($matches[0] as $variable){
            if(StringHelpers::Contains($variable, "view::")){
                $viewLocation = StringHelpers::SplitString($variable, "::", 1);
                $viewLocation = str_replace("~", "..\src\Core\Views", $viewLocation);

                $viewContent = Helpers::GetFileContent(Helpers::MapPath($viewLocation));

                $this->stringTemplater->AssignVariable($variable, $viewContent);
            }
        }
    }

    /**
     * Render the requested page and fill the pagemodel
     * @return PageModel Model containing all the details of the requested page
     */
    public function Render(RouteModel $route): PageModel {
        $pageModel = new PageModel;
        $viewData = [];

        $start = microtime(true); // Start recording the render time
        $masterpage = Helpers::GetFileContent(Helpers::MapPath("../src/Core/Views/main.tpl"));
        $content = Helpers::GetFileContent(Helpers::MapPath($route->Datasource));
        $viewData = $this->GetViewData($route->Options);

        $this->stringTemplater->ClearVariables();
        $this->stringTemplater->AssignVariable("body_content", $content);
        $this->stringTemplater->AssignVariable("page_title", "Elixer");

        $this->HandleTemplateImports($content);

        if(RequestVariables::Get("masterpage") !== "false") $content = $this->stringTemplater->DoReplacements($masterpage);

        $content = $this->stringTemplater->DoReplacements($content);

        if(count($viewData) > 0){
            $content = $this->templatingEngine->RunEngineCompilers($content, $viewData);
        }

        $pageModel->Content = $content;
        $pageModel->SizeInBytes = strlen($content);
        $pageModel->RenderTimeInMs = round(microtime(true) - $start * 1000); // Stop recording the render time

        return $pageModel;
    }
}