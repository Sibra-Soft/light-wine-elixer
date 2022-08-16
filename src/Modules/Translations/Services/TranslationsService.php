<?php
namespace Elixer\Modules\Translations\Services;

use Elixer\Modules\Translations\Interfaces\ITranslationsService;

use LightWine\Core\HttpResponse;
use LightWine\Modules\Database\Services\MysqlConnectionService;

class TranslationsService implements ITranslationsService
{
    private MysqlConnectionService $databaseConnection;

    public function __construct(){
        $this->databaseConnection = new MysqlConnectionService();
    }

    public function GetTranslations(){
        $translations = $this->databaseConnection->ExecuteQueryBasedOnFile("../src/Modules/Translations/Queries/GET_TRANSLATIONS.sql");

        HttpResponse::SetReturnJson([
            "translations" => $translations
        ]);
    }

    public function GetStats(){
        $stats = $this->databaseConnection->ExecuteQueryBasedOnFile("../src/Modules/Translations/Queries/GET_STATS.sql");

        HttpResponse::SetReturnJson($stats);
    }
}