<div class="page page-home auto-scroll" id="module-translations">
    <div class="view-container" id="main">
        <div class="card data-table data-table-init no-margin">
            <div class="card-header">
                <div class="data-table-links">
                    <a class="button" data-action="add-route"><i class="icon f7-icons">placemark_fill</i> Add Translation(s)</a>
                    <a class="button" data-action="add-language"><i class="icon f7-icons">flag_circle_fill</i> Add Language</a>
                    <a class="button disabled" data-action="remove"><i class="icon f7-icons">trash_fill</i> Remove</a>
                    <a class="button" data-action="search"><i class="icon f7-icons">search</i> Search</a>
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
                <table id="translations-table">
			        <thead>
				        <tr>
                            <th class="checkbox-cell">
                                <label class="checkbox">
                                    <input type="checkbox"/>
                                    <i class="icon-checkbox"></i>
                                </label>
                            </th>
					        <th class="label-cell">Anchor</th>
                            <th class="label-cell">Translation</th>
				        </tr>
			        </thead>
			        <tbody>
                        <template id="translation-item-template" data-replace="false">
                            {{#each translations}}
                                <tr data-id="{{id}}" data-empty="{{is_empty}}">
                                    <td class="checkbox-cell">
                                        <label class="checkbox">
                                            <input type="checkbox"/>
                                            <i class="icon-checkbox"></i>
                                        </label>
                                    </td>
                                    <td><a href="" >{{anchor}}</a></td>
                                    <td>{{translation}}</td>
                                </tr>
                            {{/each}}
                        </template>
			        </tbody>
		        </table>
            </div>	
	    </div>

        <div class="statusbar">Loading...</div>
    </div>

    <!-- Popover menu for languages -->
    <div class="popover my-popover">
        <div class="popover-inner">
            <div class="list">
                <ul>
                    <template id="language-item" data-replace="true">
                        {{#each languages}}
                        <li><a class="list-button item-link" href="javascript:void(0);">{{this}}</a></li>
                        {{/each}}
                    </template>
                </ul>
            </div>
        </div>
    </div>
</div>