<div class="page page-home" id="module-templates">
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
			    <div class="treeview folders bg-color-white scrollbar" data-treeview-key="root">
				    <div class="treeview-item add-after hide">
					    <div class="treeview-item-root treeview-item-selectable">
						    <div class="treeview-item-content no-margin">
							    <img src="/img/icons-png/bin-empty.png">
							    <div class="treeview-item-label">
								    Recycle Bin
							    </div>
						    </div>
					    </div>
				    </div>
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
            <div class="block no-margin bg-color-white no-padding pad-left-5" id="template-info-bar"></div>

		    <textarea class="hide" id="coremirror" style="width:100%;height:100%;"></textarea> <span class="resize-handler"></span>
	    </div>
    </div>
</div>

<template id="treeview-item">
    <div class="treeview-item" data-treeview-key="{key}" data-id="{id}" data-type="{type}">
        <div class="treeview-item-root">
            <div class="treeview-toggle"></div>
            <div class="treeview-item-content">
                <img src="/img/icons-png/{icon}.png">
                <div class="treeview-item-label">{caption}</div>
            </div>
        </div>
    </div>
</template>