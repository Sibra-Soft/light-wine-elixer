<div class="container view-container hide" id="upload-file">
    <h1 class="title display-4"><a href="javascript:void();" class="return-to-main" ><i class="f7-icons">arrow_left_circle_fill</i></a> Upload File(s)</h1>
    <p class="lead no-margin">
        This form allows you to upload files to your website enviroment. You can upload one file or multiple file(s)
    </p>

    <hr />

    <div class="row">
        <div class="col-60">
            <form method="post">
                <div class="form-group">
                    <label class="control-label label-margin">Name for this upload</label>
                    <input class="form-control size-400" name="upload-name" />
                    <span class="text-danger"></span>
                </div>

                <div class="card data-table no-margin">
                    <div class="card-header">
	                    <div class="data-table-links">
		                    <a class="button" data-action="select-files"><i class="f7-icons">plus_circle_fill</i>&nbsp;Select files</a>
                            <input type="file" name="upload" class="hide" multiple />
	                    </div>
                    </div>
	                <div class="card-content">
                        <table id="files-to-upload">
		                    <thead>
			                    <tr>
				                    <th class="label-cell">Filename</th>
				                    <th class="label-cell">Type</th>
				                    <th class="numeric-cell">Size</th>
                                    <th class="label-cell">Status</th>
                                    <th class="label-cell"></th>
			                    </tr>
		                    </thead>
		                    <tbody>
                                <template id="file-upload-item">
			                        {{#each files}}
                                        <tr data-index="{{@index}}">
				                            <td class="label-cell">{{name}}</td>
				                            <td class="label-cell">{{type}}</td>
				                            <td class="numeric-cell">{{size}}</td>
                                            <td>
                                                <span class="text">Ready</span>
                                                <p class="progbar hide"><span class="progressbar-infinite"></span></p>
                                            </td>
                                            <td class="label-cell"><a href="javascript:void(0);" class="delete no-hover" >&#9932;</a></td>
			                            </tr>
                                    {{/each}}
                                </template>
		                    </tbody>
	                    </table>
                    </div>
                </div>
                
                <div class="padding"></div>

                <input id="upload" type="button" class="btn btn-success disabled" value="Upload" />
            </form>
        </div>
        <div class="col-40">
            <div class="card no-margin margin-top">
                <div class="card-header">Uploading</div>
                <div class="card-content card-content-padding">
                    Add the files you want to upload. You can only add files:
                    <ul>
                        <li>Image files (.png, .jpg, .gif)</li>
                        <li>Pdf document (.pdf)</li>
                    </ul>
                    Files over 5 MB can't be uploaded to the database. Make sure your image files are compressed before uploading them.
                </div>
            </div>
        </div>
    </div>
</div>