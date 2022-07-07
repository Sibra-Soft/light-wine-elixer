<div class="popup" id="popup-add-parameter" data-close-by-backdrop-click="false" style="height:550px;">
	<div class="view">
		<div class="page">
			<div class="navbar">
				<div class="navbar-bg"></div>
				<div class="navbar-inner">
					<div class="title">Add Parameter</div>
				</div>
			</div>
			<div class="page-content">
                <div class="block">
                    Enter the details of the parameter you want to add
                </div>

                <div class="block">
                    <div class="form-group">
                        <label class="control-label label-margin">Name</label>
                        <input class="form-control size-400 return-value" type="text" name="parameter_name" />
                    </div>

                    <div class="form-group">
                        <label class="control-label label-margin">Data type</label>
                        <select class="form-control return-value" name="data_type">
                            <option>STRING</option>
                            <option>INTEGER</option>
                            <option>DATE</option>
                            <option>DATETIME</option>
                        </select>
                    </div>

                    <label class="checkbox"><input type="checkbox" class="return-value" value="is_primary_key" /><i class="icon-checkbox"></i></label>&nbsp; This parameter is a primarykey<br />
                    <label class="checkbox"><input type="checkbox" class="return-value" value="is_required" /><i class="icon-checkbox"></i></label>&nbsp; This parameter is required for the request
                    
                    <div class="form-group margin-top">
                        <label class="control-label label-margin">Default value</label>
                        <input class="form-control size-400 return-value" type="text" name="default_value" />
                    </div>
                </div>
			</div>
            <div class="toolbar toolbar-bottom">
                <div class="toolbar-inner">
                    <a class="link close-popup">Cancel</a>
                    <a class="link confirm">Save</a>
                </div>
            </div>
		</div>
	</div>
</div>