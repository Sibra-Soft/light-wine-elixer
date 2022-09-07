<div class="page page-home auto-scroll" id="module-files">
    <div class="view-container" id="main">
        <div class="card data-table data-table-init no-margin">
            <div class="card-header">
                <div class="data-table-links">
                    <a class="button" data-action="upload"><i class="icon f7-icons">cloud_upload_fill</i>&nbsp;Upload</a>
                    <a class="button disabled" data-action="remove"><i class="icon f7-icons">trash_fill</i>&nbsp;Remove</a>
                    <a class="button disabled" data-action="download"><i class="icon f7-icons">cloud_download_fill</i>&nbsp;Download</a>
                    <a class="button disabled" data-action="compress" ><i class="icon f7-icons">rectangle_compress_vertical</i> Compress</a>
                    <a class="button disabled" data-action="resize" ><i class="icon f7-icons">resize</i> Resize</a>
                    <a class="button" data-action="search"><i class="icon f7-icons">search</i> Search</a>
                    <a class="button hide" data-action="delete_search"><i class="icon f7-icons">multiply_square_fill</i>&nbsp;Remove Search</a>
                </div>
                <form data-search-container=".search-list" data-search-in=".item-title" class="searchbar searchbar-expandable searchbar-demo searchbar-init">
                    <div class="searchbar-inner">
                        <div class="searchbar-input-wrap">
                            <input type="search" placeholder="Search" class="">
                            <i class="searchbar-icon"></i>
                            <span class="input-clear-button"></span>
                        </div>
                    </div>
                </form>
                <div class="clear">

                </div>
            </div>
            <div class="card-content">
                <table id="files-table">
			        <thead>
				        <tr>
                            <th class="checkbox-cell">
                                <label class="checkbox">
                                    <input type="checkbox"/>
                                    <i class="icon-checkbox"></i>
                                </label>
                            </th>
					        <th class="label-cell">Name</th>
					        <th class="label-cell">Date Created</th>
					        <th class="label-cell">Date Changed</th>
					        <th class="label-cell">Type</th>
					        <th class="label-cell">Size</th>
				        </tr>
			        </thead>
			        <tbody>
                        <template id="file-item-template" data-replace="false">
                            {{#each files}}
                                <tr data-id="{{id}}">
                                    <td class="checkbox-cell">
                                        <label class="checkbox">
                                            <input type="checkbox"/>
                                            <i class="icon-checkbox"></i>
                                        </label>
                                    </td>
	                                <td class="label-cell">
                                        {{#if is_folder}}
                                            <img src="/img/icons-png/folder.png" class="v-align" /> <a href="javascript:void(0);" ><span class="name">{{name}}</span></a>
                                        {{else}}
                                            <img src="/img/icons-png/{{icon}}.png" class="v-align" /> <span class="name">{{name}}</span>
                                        {{/if}}
                                    </td>
	                                <td class="label-cell">{{date_added}}</td>
	                                <td class="label-cell">{{date_modified}}</td>
	                                <td class="label-cell">{{type}}</td>
	                                <td class="label-cell">{{size}}</td>
                                </tr>
                            {{/each}}
                        </template>
			        </tbody>
		        </table>
            </div>		
        </div>

        <div class="loader-container pad-10 text-align-center">
            <div class="row">
                <div class="col">&nbsp;</div>
                <div class="col">
                    <strong>Please wait...</strong><br />
                    Loading the content of the module
                    <div class="clear"></div>
                    <img src="/img/loader.gif" />
                </div>
                <div class="col">&nbsp;</div>
            </div>
        </div>
    </div>

    {{view::..\src\Modules\Files\Views\upload-file.tpl}}
</div>