﻿<div class="container view-container hide" id="roles">
    <h1 class="title display-4"><a href="javascript:void();" class="return-to-main" ><i class="f7-icons">arrow_left_circle_fill</i></a> Manage Roles</h1>
    <p class="lead no-margin">
        Here you can manage the roles for your website or webapplication
    </p>
    
    <div class="card data-table no-margin margin-top">
        <div class="card-header">
	        <div class="data-table-links">
		        <a class="button" data-action="new-role"><i class="f7-icons">plus_circle_fill</i>&nbsp;New Role</a>
	        </div>
        </div>

	    <div class="card-content">
            <table id="table-roles">
		        <thead>
			        <tr>
				        <th class="label-cell">Description</th>
				        <th class="label-cell">Date Created</th>
				        <th class="label-cell">Created By</th>
			        </tr>
		        </thead>
		        <tbody>
                    <template id="file-upload-item">
			            {{#each roles}}
                            <tr data-index="{{@index}}">
				                <td class="label-cell">{{name}}</td>
				                <td class="label-cell">{{type}}</td>
				                <td class="label-cell">{{size}}</td>
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
</div>