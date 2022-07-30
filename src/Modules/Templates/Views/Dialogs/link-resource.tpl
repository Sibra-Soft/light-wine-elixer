<div class="popup" id="popup-link-resource" data-close-by-backdrop-click="false">
	<div class="view">
		<div class="page">
			<div class="navbar">
				<div class="navbar-bg"></div>
				<div class="navbar-inner">
					<div class="title sliding">Link resource template</div>
					<div class="right">
						<a class="link icon-only searchbar-enable">
							<i class="icon f7-icons if-not-md">search</i>
						</a>
					</div>

					<form class="searchbar searchbar-expandable">
						<div class="searchbar-inner">
							<div class="searchbar-input-wrap">
								<input type="search" placeholder="Search" class="" autofocus>
								<i class="searchbar-icon"></i>
								<span class="input-clear-button"></span>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="page-content">
				<div class="block">
					Select the resource templates you want to link to the selected template.
				</div>
				<div class="list search-list">
					<ul>
						<template id="resource-item-template">
							{{#each resources}}
							<li data-selected="{{linked}}" data-value="{{name}}">
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