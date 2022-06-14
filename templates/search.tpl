{% paginate by settings.category_quantity_products %}
<div class="container">
	<div class="title-container" data-store="page-title">
	    {% snipplet "breadcrumbs.tpl" %}
   		<h1 class="title">{{ "Resultados de búsqueda" | translate }}</h1>
    </div>
	{% if products %}
		<div class="text-center-xs">
			<div class="{% if settings.infinite_scrolling and not pages.is_last and products%}js-product-table{% endif %} js-masonry-grid product-grid">
				{% for product in products %}
					{% include 'snipplets/single_product.tpl' %}
				{% endfor %}
			</div>
			{% if settings.infinite_scrolling and not pages.is_last and products%}
			    <div class="load-more-container clear-both m-bottom text-center">
			        <a class="js-load-more-btn btn btn-secondary m-top m-bottom full-width-xs">
			        	{{ 'Mostrar más productos' | t }}
			        	<span class="js-load-more-spinner pull-left m-right-quarter" style="display:none;">{% include "snipplets/svg/circle-notch.tpl" with {fa_custom_class: "svg-inline--fa fa-spin"} %}</span>
			        </a>
			    </div>
			{% endif %}
			<div class="visible-when-content-ready" {% if settings.infinite_scrolling %}style="display:none;"{% endif %}>
				{% snipplet "pagination.tpl" %}
			</div>
		</div>
	{% else %}
		<p class="text-secondary text-center">{{ "No hubo resultados para tu búsqueda" | translate }}</p>
		<p class="text-center">{{ "A continuación te sugerimos algunos productos que podrían interesarte" | translate }}</p>
		{% set related_products = sections.primary.products | take(4) | shuffle %}
		{% if related_products | length > 1 %}
		<div class="row">
			<div class="col-xs-12">
				<div class="title-container m-top">
			   		<h2 class="subtitle">{{"Productos recomendados" | translate}}</h2>
			    </div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<section id="grid" class="grid clearfix">
					<div class="js-masonry-grid">
						{% for related in related_products %}
							{% include 'snipplets/single_product.tpl' with {product : related} %}
						{% endfor %}
					</div>
				</section>
			</div>
		</div>
		{% endif %}	
	{% endif %}
</div>
