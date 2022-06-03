<div class="container">
    <h1 class="title display-4">Upload File(s)</h1>
    <p class="lead no-margin">
        This form allows you to upload files to your website enviroment. You can upload one file or multiple file(s)
    </p>

    <hr />

    <div class="row">
        <div class="col-60">
            <form method="post">
                <div asp-validation-summary="ModelOnly" class="text-danger"></div>

                <div class="form-group">
                    <label class="control-label label-margin">Name for this upload</label>
                    <input asp-for="LoanApplication.FirstName" class="form-control size-400" />
                    <span asp-validation-for="LoanApplication.FirstName" class="text-danger"></span>
                </div>

                <div class="card data-table no-margin">
                    <div class="card-header">
	                    <div class="data-table-links">
		                    <a class="button"><i class="f7-icons">plus_circle_fill</i>&nbsp;Add Upload</a>
	                    </div>
                    </div>
	                <div class="card-content">
                        <table>
		                    <thead>
			                    <tr>
				                    <th class="label-cell">Filename</th>
				                    <th class="label-cell">Type</th>
				                    <th class="numeric-cell">Size</th>
			                    </tr>
		                    </thead>
		                    <tbody>
			                    <tr>
				                    <td class="label-cell">test.jpg</td>
				                    <td class="label-cell">JPG File</td>
				                    <td class="numeric-cell">56654 Bytes</td>
			                    </tr>
		                    </tbody>
	                    </table>
                    </div>
                </div>
                
                <div class="padding"></div>

                <input type="button" class="btn btn-success" value="Upload" />
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