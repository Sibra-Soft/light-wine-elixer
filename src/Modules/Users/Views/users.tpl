<div class="page page-home" id="module-users">
    <div class="view-container" id="main">
        <div class="card data-table data-table-init no-margin">
            <div class="card-header">
                <div class="data-table-links">
                    <a class="button" data-action="new-user"><i class="icon f7-icons">person_badge_plus_fill</i> New User</a>
                    <a class="button" data-action="roles"><i class="icon f7-icons">person_2_fill</i> Roles</a>
                    <a class="button disabled" data-action="change_password"><i class="icon f7-icons">pencil_ellipsis_rectangle</i> Change Password</a>
                    <a class="button disabled" data-action="remove"><i class="icon f7-icons">trash_fill</i> Remove</a>
                </div>
            </div>
            <div class="card-content">
                <table id="users-table">
			        <thead>
				        <tr>
                            <th class="checkbox-cell">
                                <label class="checkbox">
                                    <input type="checkbox"/>
                                    <i class="icon-checkbox"></i>
                                </label>
                            </th>
					        <th class="label-cell">Name</th>
                            <th class="label-cell">Display name</th>
					        <th class="label-cell">Date Created</th>
                            <th class="label-cell">Login Date</th>
                            <th class="label-cell">Role</th>
				        </tr>
			        </thead>
			        <tbody>
                        <template id="user-item-template" data-replace="true">
                            {{#each users}}
                                <tr data-id="{{id}}">
                                    <td class="checkbox-cell">
                                        <label class="checkbox">
                                            <input type="checkbox"/>
                                            <i class="icon-checkbox"></i>
                                        </label>
                                    </td>
                                    <td class="name"><a href="" >{{username}}</a></td>
                                    <td>{{display_name}}</td>
                                    <td>{{date_added}}</td>
                                    <td>{{last_login}}</td>
                                    <td><span class="badge color-blue">&nbsp;{{role}}&nbsp;</span></td>
                                </tr>
                            {{/each}}
                        </template>
			        </tbody>
		        </table>
            </div>		
        </div>
	</div>

    {{view::..\src\Modules\Users\Views\new-user.tpl}}
    {{view::..\src\Modules\Users\Views\roles.tpl}}
</div>