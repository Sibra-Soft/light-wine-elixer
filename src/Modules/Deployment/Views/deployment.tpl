<div class="page page-home" id="module-deployment" style="overflow: auto;">
	<div class="view-container auto-scroll" id="main">
        <div class="subnavbar">
		    <div class="subnavbar-inner">
			    <div class="segmented segmented-strong">
				    <button class="button" data-show-tab="commits">Commit</button> 
                    <button class="button" data-show-tab="deployment">Deployment</button> 
                    <button class="button" data-show-tab="releases">Releases</button> 
                    <span class="segmented-highlight"></span>
			    </div>
		    </div>
	    </div>

        <!-- Commits -->
        <div class="card data-table data-table-init no-margin" style="margin-top: 45px !important;" data-tab-name="commits">
            <div class="card-header">
                <div class="data-table-links">
                    <a class="button" data-action="commit"><i class="icon f7-icons">arrow_right_circle_fill</i>&nbsp;Commit</a>
                    <a class="button" data-action="select-all"><i class="icon f7-icons">layers_alt_fill</i>&nbsp;Select all</a>
                </div>
                <form data-search-container=".search-list" data-search-in=".item-title" class="searchbar searchbar-expandable searchbar-demo searchbar-init">
                    <div class="searchbar-inner">
                        <div class="searchbar-input-wrap">
                            <input type="search" placeholder="Search" class="">
                            <i class="searchbar-icon"></i>
                            <span class="input-clear-button"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="card-content">
                <table id="commits-table">
			        <thead>
				        <tr>
                            <th class="checkbox-cell">
                                <label class="checkbox">
                                    <input type="checkbox"/>
                                    <i class="icon-checkbox"></i>
                                </label>
                            </th>
					        <th class="label-cell">Template</th>
					        <th class="label-cell">Date modified</th>
                            <th class="label-cell">Modified by</th>
					        <th class="label-cell">Type</th>
					        <th class="label-cell">Version</th>
                            <th class="label-cell hide">id</th>
				        </tr>
			        </thead>
			        <tbody>
                        <template id="commit-item-template" data-replace="false">
                            {{#each commits}}
                                <tr data-id="{{id}}">
                                    <td class="checkbox-cell">
                                        <label class="checkbox">
                                            <input type="checkbox"/>
                                            <i class="icon-checkbox"></i>
                                        </label>
                                    </td>
	                                <td class="label-cell"><img src="/img/icons-png/{{type}}.png" class="v-align" /> <span class="name">{{name}}</span></td>
	                                <td class="label-cell">{{date_modified}}</td>
	                                <td class="label-cell">{{modified_by}}</td>
	                                <td class="label-cell">{{type}}</td>
	                                <td class="label-cell">{{current_version}}</td>
                                    <td class="label-cell hide">{{id}}</td>
                                </tr>
                            {{/each}}
                        </template>
			        </tbody>
		        </table>
            </div>		
	    </div>

        <!-- Deployment -->
        <div class="card data-table data-table-init hide no-margin" style="margin-top: 45px !important;" data-tab-name="deployment">
            <div class="card-header">
                <div class="data-table-links">
                    <a class="button" data-action="deploy"><i class="icon f7-icons">arrow_right_circle_fill</i>&nbsp;New Release</a>
                    <a class="button" data-action="select-all"><i class="icon f7-icons">layers_alt_fill</i>&nbsp;Select all</a>
                </div>
                <form data-search-container=".search-list" data-search-in=".item-title" class="searchbar searchbar-expandable searchbar-demo searchbar-init">
                    <div class="searchbar-inner">
                        <div class="searchbar-input-wrap">
                            <input type="search" placeholder="Search" class="">
                            <i class="searchbar-icon"></i>
                            <span class="input-clear-button"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="card-content">
                <table id="deployments-table">
			        <thead>
				        <tr>
                            <th class="checkbox-cell">
                                <label class="checkbox">
                                    <input type="checkbox"/>
                                    <i class="icon-checkbox"></i>
                                </label>
                            </th>
					        <th class="label-cell">Description</th>
					        <th class="label-cell">Date created</th>
                            <th class="label-cell">Created by</th>
					        <th class="label-cell">Templates</th>
                            <th class="label-cell">Test</th>
                            <th class="label-cell">Acceptance</th>
				        </tr>
			        </thead>
			        <tbody>
                        <tr>
                            <td>
                                <label class="checkbox">
                                    <input type="checkbox"/>
                                    <i class="icon-checkbox"></i>
                                </label>
                            </td>
                            <td><img src="/img/icons-png/rocket.png" class="v-align" /> Dit is een test commit</td>
                            <td>14-06-2022 16:50:12</td>
                            <td>Alex van den Berg</td>
                            <td>
                                <div class="padding">
                                    <small>
                                        masterpage<br />
                                        homepage<br />
                                        framework-utils
                                    </small>
                                </div>
                            </td>
                            <td>
                                <label class="checkbox">
                                    <input type="checkbox" checked="checked" disabled="disabled" />
                                    <i class="icon-checkbox"></i>
                                </label>
                            </td>
                            <td>
                                <label class="checkbox">
                                    <input type="checkbox" disabled="disabled" />
                                    <i class="icon-checkbox"></i>
                                </label>
                            </td>
                        </tr>
			        </tbody>
		        </table>
            </div>	
        </div>

        <!-- Releases -->
        <div class="card data-table data-table-init hide no-margin" style="margin-top: 45px !important;" data-tab-name="releases">
            Test
        </div>
    </div>

    {{view::..\src\Modules\Deployment\Views\commit-templates.tpl}}
</div>