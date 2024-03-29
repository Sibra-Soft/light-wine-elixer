﻿<div class="page page-home" id="module-templates">
	<div class="row">
	    <div class="col resizable" >
		    <div class="page-content overflow-hidden">
			    <div class="toolbar toolbar-top no-border bg-button-face">
				    <div class="toolbar-inner">
					    <a class="button button-small" id="add-new-folder"><i class="icon f7-icons">folder_badge_plus</i>&nbsp;New Folder</a>
				    </div>
				    <div class="float-right margin-right-10">
                        <a class="link icon-only searchbar-enable" id="search">
                            <i class="icon f7-icons if-not-md">search</i>
                        </a>
                    </div>
			    </div>
			    <div class="my-treeview">
					<div class="treeview folders bg-color-white scrollbar" data-treeview-key="root"><!-- Filled by JS --></div>
				</div>
		    </div><span class="resize-handler"></span>
	    </div>
	    <div class="col resizable">
		    <div class="toolbar toolbar-top no-border bg-button-face">
			    <div class="toolbar-inner">
				    <div class="card-header toolbar-border">
					    <div class="data-table-links">
						    <a class="button button-small disabled" id="save-template"><i class="icon f7-icons">floppy_disk</i>&nbsp;Save</a>
					    </div>
					    <div class="data-table-links">
						    <a class="button button-small" id="undo"><i class="icon f7-icons">arrow_counterclockwise</i>&nbsp;Undo</a>
					    </div>
					    <div class="data-table-links">
						    <a class="button button-small" id="redo"><i class="icon f7-icons">arrow_clockwise</i>&nbsp;Redo</a>
					    </div>
				    </div>
			    </div>
		    </div>

			<ul class="tabs" id="editor-tabs">
				<!-- Filled by Javascript -->
			</ul>

		    <div class="editors">
				<template id="editor-template">
					<div class="editor">
						<textarea class="codemirror" style="width:100%;height:100%;"><!-- Filled by Javascript --></textarea> 
						<div id="template-info-bar"><!-- Filled by Javascript --></div>
					</div>
				</template>
			</div>

			<span class="resize-handler"></span>
	    </div>
    </div>
</div>

<!-- Treeview item template -->
<template id="treeview-item">
    <div class="treeview-item" data-treeview-key="{key}" data-id="{id}" data-type="{type}" data-group="{group}">
        <div class="treeview-item-root">
            <div class="treeview-toggle"></div>
            <div class="treeview-item-content">
                <img src="/img/icons-png/{icon}.png">
                <div class="treeview-item-label {group}">{caption}</div>
            </div>
        </div>
    </div>
</template>