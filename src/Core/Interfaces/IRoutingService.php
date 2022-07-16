<?php
namespace Elixer\Core\Interfaces;

use LightWine\Modules\Routing\Models\RouteModel;

interface IRoutingService
{
    public function MatchRouteByUrl(string $url): RouteModel;
}
