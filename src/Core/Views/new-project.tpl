<div class="view">
    <div class="page create-new-project">
        <div class="container">
            <h1 class="title display-4"><a href="/" class="return-to-login" ><i class="f7-icons">arrow_left_circle_fill</i></a> Create new project</h1>
            <p class="lead no-margin">
                Enter the details of the new project you want to add
            </p>

            <hr />

            <div class="row w-100">
                <div class="col">
                    <div class="form-group">
                        <label class="control-label label-margin">Name</label>
                        <input class="form-control" name="project_name" placeholder="My Website" />
                        <span class="text-danger"></span>
                    </div>
                </div>

                <div class="col">
                    <div class="form-group">
                        <label class="control-label label-margin">Domain</label>
                        <input class="form-control" name="project_domain" placeholder="www.example.com" />
                        <span class="text-danger"></span>
                    </div>
                </div>

                <div class="col">
                    <div class="form-group">
                        <label class="control-label label-margin">Environment</label>
                        <select class="form-control" name="project_environment">
                            <option value="dev">Development</option>
                            <option value="test">Test</option>
                            <option value="acceptance">Acceptance</option>
                            <option value="live">Live</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label label-margin">Database Connection</label>
                <select class="form-control size-400" name="datasource_template">
                    <option>Mysql Database Connection</option>
                </select>
            </div>

            <div class="card data-table no-margin">
                <div class="card-header">
	                <div class="data-table-links">
		                <a class="button" data-action="new-connection"><i class="f7-icons">plus_circle_fill</i>&nbsp;New connection</a>
	                </div>
                </div>
	            <div class="card-content">
                    <table id="new-project-connections">
		                <thead>
			                <tr>
				                <th class="label-cell">Host</th>
                                <th class="label-cell">Port</th>
				                <th class="label-cell">Database</th>
				                <th class="label-cell">Username</th>
                                <th class="numeric-cell"></th>
			                </tr>
		                </thead>
		                <tbody>
                            <template id="connection-item" data-replace="false">
			                    {{#each connections}}
                                    <tr data-index="{{@index}}">
				                        <td class="label-cell">{{server}}</td>
				                        <td class="label-cell">{{port}}</td>
				                        <td class="label-cell">{{database}}</td>
                                        <td class="label-cell">{{user}}</td>
                                        <td class="numeric-cell"><a href="javascript:void(0);" class="delete no-hover" >&#9932;</a></td>
			                        </tr>
                                {{/each}}
                            </template>
		                </tbody>
	                </table>
                </div>
            </div>

            <div class="block-title">Options</div>
            <div class="block bg-color-white padding">
                <label class="checkbox"><input type="checkbox" name="tracing" checked><i class="icon-checkbox"></i></label>&nbsp; Tracing<br />
                <label class="checkbox"><input type="checkbox" name="log_all_traffic"><i class="icon-checkbox"></i></label>&nbsp; Log all traffic<br />
                <label class="checkbox"><input type="checkbox" name="debug_log"><i class="icon-checkbox"></i></label>&nbsp; Create debug log for website<br />
                <label class="checkbox"><input type="checkbox" name="log_all"><i class="icon-checkbox"></i></label>&nbsp; Log all errors, warnings, etc. to the database<br />
                <label class="checkbox"><input type="checkbox" name="gzip_compression" checked><i class="icon-checkbox"></i></label>&nbsp; Enable Gzip compression
            </div>

            <input id="save-new-project" type="button" class="btn btn-success disabled" value="Save" />
        </div>
    </div>
</div>