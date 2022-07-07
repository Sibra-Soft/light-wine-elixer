<div class="container view-container hide" id="add-new-route">
    <h1 class="title display-4"><a href="javascript:void();" class="return-to-main" ><i class="f7-icons">arrow_left_circle_fill</i></a> Add new route</h1>
    <p class="lead no-margin">
        This form allows you to add a new route. Routes are used for handeling page and api requests
    </p>

    <hr />
    
    <div class="row">
        <div class="col-60">
            <form method="post">
                <div class="row">
                    <div class="col">
                        <div class="block-title no-margin">Route Type</div>
                        <div class="block bg-color-white padding">
                            <label class="radio"><input type="radio" value="page" name="type" checked="checked"><i class="icon-radio"></i></label>&nbsp; Page<br />
                            <label class="radio"><input type="radio" value="api" name="type"><i class="icon-radio"></i></label>&nbsp; Api<br />
                            <label class="radio"><input type="radio" value="redirect" name="type"><i class="icon-radio"></i></label>&nbsp; Redirect
                        </div>
                    </div>
                    <div class="col">
                        <div class="block-title no-margin">Method</div>
                        <div class="block bg-color-white padding">
                            <div class="for api-type page-type"><label class="radio"><input type="radio" value="get" name="method" checked="checked"><i class="icon-radio"></i></label>&nbsp; GET</div>
                            <div class="for redirect-type"><label class="radio"><input type="radio" value="get-301" name="method" checked="checked"><i class="icon-radio"></i></label>&nbsp; GET - 301</div>
                            <div class="for redirect-type"><label class="radio"><input type="radio" value="get-302" name="method" checked="checked"><i class="icon-radio"></i></label>&nbsp; GET - 302</div>
                            <div class="for api-type page-type"><label class="radio"><input type="radio" value="post" name="method"><i class="icon-radio"></i></label>&nbsp; POST</div>
                            <div class="for api-type page-type"><label class="radio"><input type="radio" value="put" name="method"><i class="icon-radio"></i></label>&nbsp; PUT</div>
                            <div class="for api-type page-type"><label class="radio"><input type="radio" value="delete" name="method"><i class="icon-radio"></i></label>&nbsp; DELETE</div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="block-title no-margin">Datasource</div>
                        <div class="block bg-color-white padding">
                            <div class="hide for page-type redirect-type"><label class="radio"><input type="radio" value="template" name="datasource"><i class="icon-radio"></i></label>&nbsp; Template</div>
                            <div class="hide for api-type"><label class="radio"><input type="radio" value="query" name="datasource"><i class="icon-radio"></i></label>&nbsp; Query</div>
                            <div class="hide for api-type"><label class="radio"><input type="radio" value="table" name="datasource"><i class="icon-radio"></i></label>&nbsp; Table</div>
                            <div class="hide for redirect-type"><label class="radio"><input type="radio" value="url" name="datasource"><i class="icon-radio"></i></label>&nbsp; Url</div>
                        </div>
                    </div>
                </div>

                <div class="block-title no-margin">Datasource</div>
                <div class="block bg-color-white padding datasources">
                    <div class="form-group for template-type">
                        <label class="control-label label-margin">Templates</label>
                        <select class="form-control" name="datasource_template">
                            <template id="datasource-template-item">
                                {{#each templates}}
                                    <option value="{{value}}">{{caption}} ({{value}})</option>
                                {{/each}}
                            </template>
                        </select>
                    </div>

                    <div class="form-group for query-type">
                        <label class="control-label label-margin">Query</label>
                        <select class="form-control" name="datasource_query">
                            <template id="datasource-query-item">
                                {{#each queries}}
                                    <option value="{{value}}">{{caption}}</option>
                                {{/each}}
                            </template>
                        </select>
                    </div>

                    <div class="form-group for table-type">
                        <label class="control-label label-margin">Tables</label>
                        <select class="form-control" name="datasource_table">
                            <template id="datasource-table-item">
                                {{#each tables}}
                                    <option value="{{value}}">{{caption}}</option>
                                {{/each}}
                            </template>
                        </select>
                    </div>

                    <div class="form-group for url-type">
                        <label class="control-label label-margin">Url</label>
                        <input class="form-control" type="text" name="url" />
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <div class="form-group">
                            <label class="control-label label-margin">Name</label>
                            <input class="form-control" type="text" name="name" />
                        </div>
                    </div>

                    <div class="col">
                        <div class="form-group">
                            <label class="control-label label-margin">Path</label>
                            <input class="form-control" type="text" name="path" />
                        </div>
                    </div>
                </div>

                <div class="data-table card no-margin">
                    <div class="card-header">
                        <div class="data-table-links">
                            <a class="button" data-action="add_paramter"><i class="icon f7-icons">plus_circle_fill</i>&nbsp;Add Parameter</a>
                        </div>
                    </div>
                    <div class="card-content">
                        <table id="parameters-table">
	                        <thead>
		                        <tr>
                                    <th class="label-cell"></th>
			                        <th class="label-cell">Parameter</th>
			                        <th class="label-cell">Type</th>
			                        <th class="label-cell">Key</th>
			                        <th class="label-cell">Required</th>
		                        </tr>
	                        </thead>
                            <tbody>
			                    <template id="template-parameter-item" data-replace="false">
                                    {{#each parameters}}
                                    <tr>
                                        <td class="label-cell"><a href="javascript:void(0);" class="delete no-hover" >&#9932;</a></td>
                                        <td>{{parameter_name}}</td>
                                        <td>{{data_type}}</td>
                                        <td>
                                            {{#if is_primary_key}}
                                            &#10003;
                                            {{/if}}
                                        </td>
                                        <td>
                                            {{#if is_required}}
                                            &#10003;
                                            {{/if}}
                                        </td>
                                    </tr>
                                    {{/each}}
                                </template>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="padding"></div>
                <input type="button" class="btn btn-success disabled" value="Add" id="btn-add-new-route" />
                <div class="padding"></div>
            </form>
        </div>
        <div class="col-40">
            <div class="card">
                <div class="card-header">Routes</div>
                <div class="card-content card-content-padding">
                    Routes are used for directing a incomming request to the correct page or api function of your webiste/webapplication.
                    <br /><br />
                    <strong>Method</strong><br />
                    Make sure you always specify a method so that the framework can check if the route is requested with the specified method.
                    <br /><br />
                    <strong>Path</strong><br />
                    The path must always match the requested url. Use {} to specify parameters in the url.
                </div>
            </div>
        </div>
    </div>
</div>