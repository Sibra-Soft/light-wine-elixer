<div class="container view-container hide" id="commit-templates">
    <h1 class="title display-4"><a href="javascript:void();" class="return-to-main" ><i class="f7-icons">arrow_left_circle_fill</i></a> Commit Templates</h1>
    <p class="lead no-margin">
        Use this form for commiting templates
    </p>

    <hr />

    <div class="row">
        <div class="col-60">
            <form method="post">
                <div class="form-group">
                    <label class="control-label label-margin">Commit description</label>
                    <input class="form-control" name="commit-description" />
                    <span class="text-danger"></span>
                </div>
            </form>

            <div class="card data-table no-margin">
	            <div class="card-content">
                    <table id="templates-to-commit">
		                <thead>
			                <tr>
				                <th class="label-cell">Name</th>
				                <th class="label-cell">Version</th>
				                <th class="label-cell">Type</th>
                                <th>&nbsp;</th>
			                </tr>
		                </thead>
		                <tbody>
                            <template id="template-commit-item">
			                    {{#each items}}
                                    <tr data-index="{{@index}}" data-id="{{id}}">
				                        <td class="label-cell">{{template}}</td>
				                        <td class="label-cell">{{version}}</td>
				                        <td class="label-cell">{{type}}</td>
                                        <td class="label-cell"><a href="javascript:void(0);" class="delete no-hover" >&#9932;</a></td>
			                        </tr>
                                {{/each}}
                            </template>
		                </tbody>
	                </table>
                </div>
            </div>   

            <div class="block-title">Enviroment(s)</div>
            <div class="block bg-color-white padding">
                <label class="checkbox"><input type="checkbox" value="acceptance" id="env-acceptance"><i class="icon-checkbox"></i></label>&nbsp; Commit template(s) to acceptance enviroment<br />
                <label class="checkbox"><input type="checkbox" value="test" id="env-test"><i class="icon-checkbox"></i></label>&nbsp; Commit template(s) to test enviroment
            </div>

            <input id="btn-commit" type="button" class="btn btn-success disabled" value="Commit" />
        </div>

        <div class="col-40">
            <div class="card">
                <div class="card-header">Commit Templates</div>
                <div class="card-content card-content-padding">
                    Commit the templates you want to deploy to your test, acceptance enviroment. After a templates is deployed you can create a release and release all the changes to the live enviroment.
                </div>
            </div>
        </div>
    </div>
</div>