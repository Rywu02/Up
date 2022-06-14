<div class="col-sm-2 visible-when-content-ready hidden-xs">
	{% include "snipplets/categories.tpl" %}
	{% set has_filters = insta_colors|length > 0 or other_colors|length > 0 or size_properties_values|length > 0 or variants_properties|length > 0 %}
	{% if has_filters %}
		<div class="full-width-container">
			<h4 class="m-bottom">{{ "Filtros" | translate }}</h4>
			{% snipplet "filters.tpl" %}
		</div>
	{% endif %}
</div>
