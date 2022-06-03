<div class="page page-home auto-scroll" id="module-routes">
    <div class="padding hide">
        <div class="card data-table data-table-init">
            <div class="card-header">
                <div class="data-table-links">
                    <a class="button" data-action="add-route"><i class="icon f7-icons">placemark_fill</i> New Route</a>
                    <a class="button disabled" data-action="remove"><i class="icon f7-icons">trash_fill</i> Remove</a>
                    <a class="button" data-action="search"><i class="icon f7-icons">search</i> Search</a>
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
                        <!-- Filled by Javascript -->
			        </tbody>
		        </table>
            </div>		
	    </div>
    </div>

    <template id="route-item-template">
        <tr>
            <td class="checkbox-cell">
                <label class="checkbox">
                    <input type="checkbox"/>
                    <i class="icon-checkbox"></i>
                </label>
            </td>
            <td><span class="badge color-{color}">&nbsp;{method}&nbsp;</span></td>
            <td class="name"><a href="" >{name}</a></td>
            <td>{path}</td>
            <td>{date_created}</td>
            <td><span class="badge color-gray">&nbsp;{type}&nbsp;</span></td>
        </tr>
    </template>

    {{view::..\src\Modules\Routes\Views\add-new-route.tpl}}
</div>