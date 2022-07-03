<div class="popup" id="popup-new-binding" data-close-by-backdrop-click="false" style="height:500px;">
	<div class="view">
		<div class="page">
			<div class="navbar">
				<div class="navbar-bg"></div>
				<div class="navbar-inner">
					<div class="title">Add new binding</div>
				</div>
			</div>
			<div class="page-content">
                <div class="block">
                    Bellow you can use the form for adding a new binding to a template. Use the checkboxes to active various extra options for this binding.
                </div>

                <div class="block">
                    <div class="form-group">
                        <label class="control-label label-margin">Name</label>
                        <input class="form-control size-400 return-value" type="text" name="binding_name" />
                    </div>

                    <div class="form-group">
                        <div class="form-group">
                            <label class="control-label label-margin">Datasource</label>
                            <select class="form-control return-value" name="datasource_template">
                                @foreach($datasources as $datasource)
                                    <option value="{{$datasource->id}}">{{$datasource->name}}</option>
                                @endforeach
                            </select>
                        </div>
                    </div>
                </div>

                <div class="block bg-color-white padding">
                    <label class="checkbox"><input type="checkbox" value="acceptance" id="env-acceptance"><i class="icon-checkbox"></i></label>&nbsp; The result of the datasource can be empty<br />
                    <label class="checkbox"><input type="checkbox" value="test" id="env-test"><i class="icon-checkbox"></i></label>&nbsp; Return the result of the datasource as Json
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