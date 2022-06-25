<!DOCTYPE html>
<html lang="nl">
    <head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no, viewport-fit=cover">
	    <meta name="apple-mobile-web-app-capable" content="yes">
	    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
	    <meta name="theme-color" content="#2196f3">

        <title>{{page_title}}</title>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/codemirror@5.65.2/lib/codemirror.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/codemirror@5.65.2/addon/hint/show-hint.css" />

        <!-- Main -->
        <script src="https://cdn.jsdelivr.net/npm/codemirror@5.65.2/lib/codemirror.js"></script>

        <!-- Addons -->
        <script src="https://cdn.jsdelivr.net/npm/codemirror@5.65.2/addon/edit/matchbrackets.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/codemirror@5.65.2/addon/hint/show-hint.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/codemirror@5.65.2/addon/hint/sql-hint.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/codemirror@5.65.2/addon/fold/xml-fold.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/codemirror@5.65.2/addon/edit/matchtags.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/codemirror@5.65.2/addon/mode/simple.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/codemirror@5.65.2/addon/mode/multiplex.js"></script>

        <!-- Modes -->
        <script src="https://cdn.jsdelivr.net/npm/codemirror@5.65.2/mode/xml/xml.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/codemirror@5.65.2/mode/javascript/javascript.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/codemirror@5.65.2/mode/css/css.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/codemirror@5.65.2/mode/sql/sql.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/codemirror@5.65.2/mode/vbscript/vbscript.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/codemirror@5.65.2/mode/xml/xml.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/codemirror@5.65.2/mode/htmlmixed/htmlmixed.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/codemirror@5.65.2/mode/markdown/markdown.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/codemirror@5.65.2/mode/clike/clike.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/codemirror@5.65.2/mode/php/php.js"></script>

        <!-- Styles -->
        <link rel="stylesheet" href="/src/Stylesheets/framework7.css" />
	    <link rel="stylesheet" href="https://draggable.github.io/formeo/assets/css/formeo.min.css" />
	    <link rel="stylesheet" href="https://unpkg.com/framework7-icons" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/jqueryui@1.11.1/jquery-ui.min.css" />
        <link rel="stylesheet" href="/src/Stylesheets/over-rules.css" />
        <link rel="stylesheet" href="/src/Stylesheets/contextmenu.css" />
        <link rel="stylesheet" href="/src/Stylesheets/alerts.css" />
        <link rel="stylesheet" href="/src/Stylesheets/bootstrap.css" />
    </head>
    <body>
        <div id="app">
            {{body_content}}
        </div>

        <!-- Scripts -->
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/template7@1.4.2/dist/template7.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/jqueryui@1.11.1/jquery-ui.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/framework7@7.0.2/framework7-bundle.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.ui.position.js"></script>
        <script type="text/javascript" src="https://draggable.github.io/formeo/assets/js/formeo.min.js"></script>

        <script type="text/javascript" src="/src/Core/Scripts/views.js" ></script>
        <script type="text/javascript" src="/src/Core/Scripts/utils.js" ></script>
        <script type="text/javascript" src="/src/Core/Scripts/login.js" ></script>
        <script type="text/javascript" src="/src/Core/Scripts/masterpage.js" ></script>
        <script type="text/javascript" src="/src/Core/Scripts/loader.js" ></script>
        <script type="text/javascript" src="/src/Core/Scripts/js-templater.js" ></script>
    </body>
</html>