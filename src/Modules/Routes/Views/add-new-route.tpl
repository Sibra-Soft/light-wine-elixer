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
                        <div class="form-group">
                            <label class="control-label label-margin">Type</label>
                            <select class="form-control" asp-items="items">
                                <option value="page">Page</option>
                                <option value="api">Api</option>
                                <option value="redirect">Redirect</option>
                            </select>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group">
                            <label class="control-label label-margin">Method</label>
                            <select class="form-control">
                                <option value="get">Get</option>
                                <option value="post">Post</option>
                                <option value="put">Put</option>
                                <option value="delete">Delete</option>
                            </select>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group">
                            <label class="control-label label-margin">Datasource</label>
                            <select class="form-control">
                                <option value="get">Template</option>
                                <option value="post">Query</option>
                                <option value="put">Table</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col">
                        <div class="form-group">
                            <label class="control-label label-margin">Name</label>
                            <input class="form-control" type="text" />
                        </div>
                    </div>

                    <div class="col">
                        <div class="form-group">
                            <label class="control-label label-margin">Path</label>
                            <input class="form-control" type="text" />
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col">

                    </div>
                </div>

                <div class="data-table card no-margin">
                    <div class="card-header">
                        <div class="data-table-links">
                            <a class="button" data-action="upload"><i class="icon f7-icons">plus_circle_fill</i>&nbsp;Add Parameter</a>
                        </div>
                    </div>
                    <div class="card-content">
                        <table id="route-table">
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
                                <tr>
                                    <td class="label-cell"><a href="javascript:void(0);" class="delete no-hover" >&#9932;</a></td>
                                    <td>description</td>
                                    <td>String</td>
                                    <td>&#10003;</td>
                                    <td>&#10003;</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="padding"></div>
                <input type="button" class="btn btn-success" value="Add" />
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