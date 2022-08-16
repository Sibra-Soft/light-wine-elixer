<?php
namespace Elixer\Modules\Translations\Controllers;

use Elixer\Modules\Translations\Services\TranslationsService;

class TranslationsController
{
    private TranslationsService $translationsService;

    public function __construct(){
        $this->translationsService = new TranslationsService();
    }

    /**
     * Gets the translations in Json format
     */
    public function Get(){
        $this->translationsService->GetTranslations();
    }

    /**
     * Gets the stats in Json format
     */
    public function GetStats(){
        $this->translationsService->GetStats();
    }
}