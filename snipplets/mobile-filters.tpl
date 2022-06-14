<div class="js-fullscreen-modal js-mobile-filters-panel mobile-filters modal-xs modal-xs-right modal-xs-right-out visible-xs">
	<div class="modal-xs-dialog">
	    <a class="js-toggle-mobile-filters js-fullscreen-modal-close modal-xs-header" href="#">
	        {% include "snipplets/svg/angle-left.tpl" with {fa_custom_class: "svg-inline--fa fa-2x modal-xs-header-icon modal-xs-right-header-icon"} %}
	        <span class="modal-xs-header-text modal-xs-right-header-text">{{ 'Filtrar por:' | translate }}</span>
	    </a>
	    <div class="modal-content">
		    <div class="modal-xs-body">
		    	{% include "snipplets/categories.tpl" with {mobile: true}%}
		        {% snipplet "filters.tpl" %}
		    </div>
		</div>
	</div>
</div>
<div class="js-filters-overlay filters-overlay" style="display: none;">
	<div class="filters-updating-message">
		<h4 class="js-applying-filter" style="display: none;">{{ 'Aplicando filtro...' | translate }}</h4>
		<h4 class="js-removing-filter" style="display: none;">{{ 'Borrando filtro...' | translate }}</h4>
	</div>
</div>