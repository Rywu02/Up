{% set show_filters = settings.product_filters and (filter_categories or insta_colors or other_colors or size_properties_values or variants_properties) %}
{% set has_filters = insta_colors|length > 0 or other_colors|length > 0 or size_properties_values|length > 0 or variants_properties|length > 0 %}
{% paginate by settings.category_quantity_products %}
{# Only remove this if you want to take away the theme onboarding advices #}
{% set show_help = not has_products %}
{% if not show_help %}

{% if (category.images is not empty) or ("banner-products.jpg" | has_custom_image) %}
    {% include 'snipplets/category-banner.tpl' %}
{% endif %}

<div class="container">
	<div class="banner-services-category hidden-xs">
		{% if settings.banner_services_category %} 
			{% include 'snipplets/banner-services/banner-services.tpl' %}
		{% endif %} 
	</div>
	<div class="title-container" data-store="page-title">
	    {% snipplet "breadcrumbs.tpl" %}
   		<h1 class="title m-bottom-xs">{{ category.name }}</h1>
   		{% if category.description %}
	   		<div class="row">
	   			<div class="col-md-6 col-md-offset-3">
					<p class="m-bottom-double font-small-xs text-center">{{ category.description }}</p>
				</div>
			</div>
		{% endif %}
    </div>
	<div class="row category-controls m-bottom-xs p-bottom-half-xs">
		<div class="col-xs-8 col-sm-7 text-right text-left-xs sort-by-container">
	      {% snipplet 'sort_by.tpl' %}
	    </div>
		{% if show_filters %}
			<a href="#" class="js-toggle-mobile-filters js-fullscreen-modal-open visible-xs col-xs-4 m-top p-top-half p-left-none text-right btn-link-secondary" data-modal-url="modal-fullscreen-filters">
				<span>{{ 'Filtrar' | translate }}</span>
				{% include "snipplets/svg/caret-right.tpl" with {fa_custom_class: "svg-inline--fa svg-text-fill"} %}
			</a>
	    {% endif %}  
	</div>
	<div class="visible-xs visible-when-content-ready">
		{% include "snipplets/filters.tpl" with {applied_filters: true} %}
	</div>
	<div class="row m-top m-top-none-xs">
			{% if show_filters %} 
	            {% snipplet 'sidebar.tpl' %}
	        {% endif %} 
	        <div {% if show_filters %}class="col-sm-10 text-center-xs"{% else %}class="col-sm-12 text-center-xs"{% endif %} data-store="category-grid-{{ category.id }}">
        	{% if show_filter_error %}
                <div class="text-center m-top m-bottom">
                    <h4 class="text-uppercase">{{ "No tenemos productos para mostrarte :(" | translate }}</h4>
                    <h5>{{ "Quizás encuentres lo que buscabas en los productos debajo." | translate }}</h5>
                </div>
            {% endif %}   
	        {% if products %}
				<div class="{% if settings.infinite_scrolling and not pages.is_last and products%}js-product-table{% endif %} js-masonry-grid product-grid">
					{% include 'snipplets/product_grid.tpl' %}
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
			{% else %}
		        <div class="filters-msg">
		            <h4>{{(has_filters ? "No tenemos productos en esas variantes. Por favor, intentá con otros filtros." : "Próximamente") | translate}}</h4>
		        </div>
		    {% endif %}
	        </div>
        {% elseif show_help %}
            {% snipplet 'defaults/show_help_category.tpl' %}
        {% endif %}
	</div>
</div>
{% if show_filters %}
    {% snipplet 'mobile-filters.tpl' %}
{% endif %}
