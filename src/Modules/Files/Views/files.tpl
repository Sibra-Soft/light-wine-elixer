<div class="page page-home auto-scroll" id="module-files">
    <div class="bg-color-white padding hide">
        <div class="card data-table data-table-init no-margin">
            <div class="card-header">
                <div class="data-table-links">
                    <a class="button" data-action="upload"><i class="icon f7-icons">cloud_upload_fill</i>&nbsp;Upload</a>
                    <a class="button disabled" data-action="remove"><i class="icon f7-icons">trash_fill</i>&nbsp;Remove</a>
                    <a class="button disabled" data-action="download"><i class="icon f7-icons">cloud_download_fill</i>&nbsp;Download</a>
                    <a class="button disabled" data-action="compress" ><i class="icon f7-icons">rectangle_compress_vertical</i> Compress</a>
                    <a class="button disabled" data-action="resize" ><i class="icon f7-icons">resize</i> Resize</a>
                    <a class="button" data-action="search"><i class="icon f7-icons">search</i> Search</a>
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
                        <!-- Filled by Javascript -->
			        </tbody>
		        </table>
            </div>		
        </div>
    </div>

    <template id="file-item-template">
        <tr data-id="{id}">
            <td class="checkbox-cell">
                <label class="checkbox">
                    <input type="checkbox"/>
                    <i class="icon-checkbox"></i>
                </label>
            </td>
	        <td class="label-cell"><img src="/img/icons-png/{icon}.png" class="v-align" /> <span class="name">{name}</span></td>
	        <td class="label-cell">{date_created}</td>
	        <td class="label-cell">{date_changed}</td>
	        <td class="label-cell">{type}</td>
	        <td class="label-cell">{size}</td>
        </tr>
    </template>

    {{view::..\src\Modules\Files\Views\upload-file.tpl}}
</div>