<div class="container">
    <h1 class="title display-4">Add new route</h1>
    <p class="lead no-margin">
        This form allows you to add a new route. Routes are used for handeling page and api requests
    </p>

    <hr />
    
    <div class="row">
        <div class="col-50">
            <form method="post">
                <div class="row">
                    <div class="col">
                        <div class="form-group">
                            <label class="control-label label-margin">Type</label>
                            <select class="form-control" asp-items="items">
                                <option value="page">Page</option>
                                <option value="api">Api</option>
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
                </div>

                <div class="form-group">
                    <label class="control-label label-margin">Name</label>
                    <input class="form-control" type="text" />
                </div>

                <div class="form-group">
                    <label class="control-label label-margin">Path</label>
                    <input class="form-control" type="text" />
                </div>
               
                <div class="padding"></div>

                <input type="button" class="btn btn-success" value="Upload" />
            </form>
        </div>
        <div class="col-40">
            <div class="card no-margin margin-top">
                <div class="card-header">Routes</div>
                <div class="card-content card-content-padding">
                    Routes are used for directing the website visitor to the correct page. A route is connected to a template and when a specific route is called the template will be rendered and shown.
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