<div class="page page-home auto-scroll" id="module-components">
    <div class="view-container" id="main">
        <div class="card data-table data-table-init no-margin">
            <div class="card-header">
                <div class="data-table-links">
                    <a class="button after-loading" data-action="new_component"><i class="icon f7-icons">cube_fill</i>&nbsp;New Component</a>
                    <a class="button disabled" data-action="remove"><i class="icon f7-icons">trash</i>&nbsp;Remove</a>
                    <a class="button after-loading" data-action="search"><i class="icon f7-icons">search</i> Search</a>
                    <a class="button hide" data-action="delete_search"><i class="icon f7-icons">multiply_square_fill</i>&nbsp;Remove Search</a>
                </div>
            </div>
            <div class="card-content">
                <table id="components-table">
			        <thead>
				        <tr>
                            <th class="checkbox-cell">
                                <label class="checkbox">
                                    <input type="checkbox"/>
                                    <i class="icon-checkbox"></i>
                                </label>
                            </th>
					        <th class="label-cell">Name</th>
                            <th class="label-cell">Type</th>
                            <th class="label-cell">Mode</th>
                            <th class="label-cell">Date Created</th>
				        </tr>
			        </thead>
			        <tbody>
                        <template id="component-item" data-replace="false">
                            {{#each components}}
                            <tr>
                                <td class="checkbox-cell">
                                    <label class="checkbox">
                                        <input type="checkbox"/>
                                        <i class="icon-checkbox"></i>
                                    </label>
                                </td>
                                <td><a href="javascript:void(0);" class="load-component" data-id="{{id}}" >{{name}}</a></td>
                                <td>{{type}}</td>
                                <td>{{mode}}</td>
                                <td>{{added_on}}</td>
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

    <!-- Views -->
    {{view::..\src\Modules\Components\Views\new-component.tpl}}

    <!-- Fields -->
    {{view::..\src\Modules\Components\Views\Templates\field-container.tpl}}
    {{view::..\src\Modules\Components\Views\Templates\checkbox-field.tpl}}
    {{view::..\src\Modules\Components\Views\Templates\codemirror-field.tpl}}
    {{view::..\src\Modules\Components\Views\Templates\dropdown-field.tpl}}
    {{view::..\src\Modules\Components\Views\Templates\input-field.tpl}}
</div>