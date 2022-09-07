<div class="page page-home auto-scroll" id="module-routes">
    <div class="view-container" id="main">
        <div class="card data-table data-table-init no-margin">
            <div class="card-header">
                <div class="data-table-links">
                    <a class="button" data-action="add_route"><i class="icon f7-icons">placemark_fill</i>&nbsp;New Route</a>
                    <a class="button disabled" data-action="remove"><i class="icon f7-icons">trash_fill</i>&nbsp;Remove</a>
                    <a class="button disabled" data-action="publish"><i class="icon f7-icons">arrow_up_square</i>&nbsp;Publish</a>
                    <a class="button" data-action="search"><i class="icon f7-icons">search</i>&nbsp;Search</a>
                    <a class="button hide" data-action="delete_search"><i class="icon f7-icons">multiply_square_fill</i>&nbsp;Remove Search</a>
                </div>
                <form class="searchbar searchbar-expandable searchbar searchbar-init">
                    <div class="searchbar-inner">
                        <div class="searchbar-input-wrap">
                            <input type="search" placeholder="Search" id="table-search">
                            <i class="searchbar-icon"></i>
                            <span class="input-clear-button"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="card-content">
                <table id="routes-table">
			        <thead>
				        <tr>
                            <th class="checkbox-cell">
                                <label class="checkbox">
                                    <input type="checkbox"/>
                                    <i class="icon-checkbox"></i>
                                </label>
                            </th>
					        <th class="label-cell">Method</th>
                            <th class="label-cell">Name</th>
                            <th class="label-cell">Path</th>
					        <th class="label-cell">Date Created</th>
                            <th class="label-cell">Type</th>
				        </tr>
			        </thead>
			        <tbody>
                        <template id="route-item-template" data-replace="false">
                            {{#each routes}}
                                <tr data-id="{{id}}" data-published="{{is_published}}">
                                    <td class="checkbox-cell">
                                        <label class="checkbox">
                                            <input type="checkbox"/>
                                            <i class="icon-checkbox"></i>
                                        </label>
                                    </td>
                                    <td><span class="badge color-{{color}}">&nbsp;{{method}}&nbsp;</span></td>
                                    <td class="name"><a href="" >{{name}}</a></td>
                                    <td>{{path}}</td>
                                    <td>{{date_created}}</td>
                                    <td><span class="badge color-gray">&nbsp;{{type}}&nbsp;</span></td>
                                </tr>
                            {{/each}}
                        </template>
			        </tbody>
		        </table>
            </div>		
	    </div>

        <div class="loader-container pad-10 text-align-center">
            <div class="row">
                <div class="col">&nbsp;</div>
                <div class="col">
                    <strong>Please wait...</strong><br />
                    Loading the content of the module
                    <div class="clear"></div>
                    <img src="/img/loader.gif" />
                </div>
                <div class="col">&nbsp;</div>
            </div>
        </div>
    </div>

    {{view::..\src\Modules\Routes\Views\add-new-route.tpl}}
</div>