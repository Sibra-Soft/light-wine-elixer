<?php
namespace Elixer\Core\Interfaces;

interface IRoutingService
{
    public function MatchRouteByUrl(string $url): RouteModel;
}
