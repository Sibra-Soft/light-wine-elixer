<div class="popup" id="popup-link-resource" data-close-by-backdrop-click="false">
	<div class="view">
		<div class="page">
			<div class="navbar">
				<div class="navbar-bg"></div>
				<div class="navbar-inner">
					<div class="title">Link resource template</div>
				</div>
			</div>
			<div class="page-content">
				<div class="block">
					Select the resource templates you want to link to the selected template.
				</div>
				<div class="list">
					<ul>
						<template id="resource-item-template">
							{{#each resources}}
							<li data-selected="{{linked}}">
								<label class="item-checkbox item-content">
									<input type="checkbox" name="resource" value="{{id}}"><i class="icon icon-checkbox"></i>
									<div class="item-inner">
										<div class="item-title"><img src="/img/icons-png/{{type}}.png" class="valign" />&nbsp;{{name}}</div>
										<div class="item-after">{{type}}</div>
									</div>
								</label>
							</li>
							{{/each}}
						</template>
					</ul>
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