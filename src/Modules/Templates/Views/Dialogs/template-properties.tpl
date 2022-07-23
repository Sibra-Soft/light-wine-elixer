<div class="popup" id="popup-template-properties" data-close-by-backdrop-click="false">
	<div class="view">
		<div class="page">
			<div class="navbar">
				<div class="navbar-bg"></div>
				<div class="navbar-inner">
					<div class="title">Properties</div>
				</div>
			</div>
			<div class="page-content">
				<div class="block">
					@foreach($properties as $property)
						<div class="row">
							<div class="col-30">Name</div>
							<div class="col-70">{{$property->name}}</div>
						</div>
						<div class="row">
							<div class="col-30">Type</div>
							<div class="col-70">{{$property->type}}</div>
						</div>
						<div class="row">
							<div class="col-30">Created by</div>
							<div class="col-70">{{$property->created_by}}</div>
						</div>

						<div class="row margin-top">
							<div class="col-30">Date created</div>
							<div class="col-70">{{$property->date_added}}</div>
						</div>
						<div class="row">
							<div class="col-30">Date modified</div>
							<div class="col-70">{{$property->date_modified}}</div>
						</div>

						<div class="row margin-top">
							<div class="col-30">Current version</div>
							<div class="col-70">{{$property->template_version_dev}}</div>
						</div>
						<div class="row">
							<div class="col-30">Enabled</div>
							<div class="col-70">{{$property->active}}</div>
						</div>
					@endforeach
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