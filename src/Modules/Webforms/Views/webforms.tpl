<div class="page page-home" id="module-webforms">
    <div class="view-container" id="main">
        <div class="card data-table data-table-init no-margin">
            <div class="card-header">
                <div class="data-table-links">
                    <a class="button" data-action="new-webform"><i class="icon f7-icons">doc_text</i> Add New</a>
                    <a class="button disabled" data-action="edit"><i class="icon f7-icons">square_pencil</i> Edit</a>
                    <a class="button disabled" data-action="remove"><i class="icon f7-icons">trash_fill</i> Remove</a>
                    <a class="button" data-action="duplicate"><i class="icon f7-icons">square_on_square</i> Duplicate</a>
                </div>
            </div>
            
            <div class="card-content">
                <table id="webforms-table">
			        <thead>
				        <tr>
                            <th class="checkbox-cell">
                                <label class="checkbox">
                                    <input type="checkbox"/>
                                    <i class="icon-checkbox"></i>
                                </label>
                            </th>
					        <th class="label-cell">Name</th>
                            <th class="label-cell">Categorie</th>
                            <th class="label-cell">Description</th>
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
                            <td>CONTACT_FORM</td>
                            <td>Website</td>
                            <td>Formulier met mail functionaliteit om contact op te kunnen nemen</td>
                        </tr>
			        </tbody>
		        </table>
            </div>	
        </div>
    </div>

    {{view::..\src\Modules\Webforms\Views\new-webform.tpl}}
</div>