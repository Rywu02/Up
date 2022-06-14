<!-- Modal -->
{% if settings.show_news_box %}
    {% include 'snipplets/newsletter-popup.tpl' %}
{% endif %}

{# Only remove this if you want to take away the theme onboarding advices #}
{% set show_help = not has_products %}


{% set has_mobile_slider = settings.toggle_slider_mobile and settings.slider_mobile and settings.slider_mobile is not empty %}

<section data-store="slider-main">
    {% include 'snipplets/home-slider.tpl' %}
    {% if has_mobile_slider %}
        {% include 'snipplets/home-slider.tpl' with {mobile: true} %}
    {% endif %}
</section>

{% if settings.banner_services_home %} 
     {% include 'snipplets/banner-services/banner-services.tpl' %}
{% endif %}

{% set help_url = has_products ? '/admin/products/feature/' : '/admin/products/new/' %}

{# This will show default products in the home page before you upload some products #}
{% if show_help %}
    {% snipplet 'defaults/show_help.tpl' %}
{% endif %}
{# END of show default products in the home page #}

{#  **** Features Order ****  #}
{% set newArray = [] %}

{% for section in ['home_order_position_1', 'home_order_position_2', 'home_order_position_3', 'home_order_position_4', 'home_order_position_5', 'home_order_position_6', 'home_order_position_7', 'home_order_position_8', 'home_order_position_9'] %}
    {% set section_select = attribute(settings,"#{section}") %}

    {% if section_select not in newArray %}

        {% if section_select == 'categories' %}
            {#  **** Categories banners ****  #}
            {% include 'snipplets/home-banners.tpl' %}
        {% elseif section_select == 'main_categories' %}
            {% if categories %}
                {% include 'snipplets/home-categories.tpl' %}
            {% endif %}
        {% elseif section_select == 'products' %}
        	{% if sections.primary.products %}
                <div class="container">
                	<div class="title-container row m-top">
                   		<h2 class="title h1 h5-xs">{{"Destacados" | translate}}</h2>
                    </div>
                	<div class="row text-center-xs" data-store="products-home-featured">
                		<section id="grid" class="js-masonry-grid grid clearfix">
                			<div class="js-masonry-grid" >
                				{% for product in sections.primary.products %}
                					{% include 'snipplets/single_product.tpl' %}
                				{% endfor %}
                			</div>
                		</section>
                	</div>
                    <div class="row">
                        <div class="text-center p-left-half p-right-half full-width d-inline-block m-bottom m-top">
                	        <a href="{{ store.products_url }}" class="btn btn-secondary col-xs-12 col-sm-4 col-sm-offset-4 col-md-4 col-md-offset-4">{{ "Ver todos los productos" | translate }}</a>
                	    </div>
                    </div>
                </div>
        	{% endif %}
        {% elseif section_select == 'modules' %}
            <div class="container">
            	{#  **** Modules with images and text ****  #}
            	{% include 'snipplets/home-modules.tpl' %}
            </div>
        {% elseif section_select == 'sale' %}
        	{% if sections.sale.products %}
                <div class="container">
                    <div class="row text-center-xs">
                    	{% if settings.sale_products_title %}
                    		<div class="title-container m-top">
                            	<h2 class="title h1 h5-xs m-top">{{ settings.sale_products_title }}</h2>
                        	</div>
                        {% endif %}
                        <div class="products-slider p-relative">
                            <div class="js-swiper-sale-products swiper-container grid-row">
                                <div class="swiper-wrapper">
                                    {% for product in sections.sale.products %}
                                        {% include 'snipplets/single_product.tpl' with {'slide_item': true} %}
                                    {% endfor %}
                                </div>
                                <div class="js-swiper-sale-products-pagination swiper-pagination"></div>
                                <div class="js-swiper-sale-products-prev swiper-button-prev hidden-xs">{% include "snipplets/svg/angle-left.tpl" with {fa_custom_class: "slider-arrow"} %}</div>
                                <div class="js-swiper-sale-products-next swiper-button-next hidden-xs">{% include "snipplets/svg/angle-right.tpl" with {fa_custom_class: "slider-arrow"} %}</div>
                            </div>
                        </div>
                    </div>
                </div>
        	{% endif %}
        {% elseif section_select == 'promotional' %}
            <div class="container">
            	{#  **** Promotional banners ****  #}
            	{% include 'snipplets/home-promotional-banners.tpl' %}
            </div>
        {% elseif section_select == 'newsletter' %}
            <div class="container">
            	<div class="row home-widgets m-top-double">
            		{% set blocksCount = 1%}
            		{% if settings.show_footer_fb_like_box and store.facebook %}
            			{% set blocksCount = blocksCount + 1 %}
            		{% endif %}
            		{% if settings.twitter_widget %}
            			{% set blocksCount = blocksCount + 1 %}
            		{% endif %}
            		{% if blocksCount == 1 %}
            		<div class="col-xs-12 col-md-4 col-md-offset-4 p-bottom-xs">
            		{% elseif blocksCount == 2 %}
            		<div class="col-xs-12 col-md-6 p-bottom-xs">
            		{% else %}
            		<div class="col-xs-12 col-md-4 p-bottom-xs">
            		{% endif%}
            			<div class="title-container">
            		   		<h4 class="subtitle h5-xs">{{"Nuestro Newsletter" | translate}}</h4>
            		    </div>
            			{% snipplet "newsletter.tpl" %}
            		</div>
            		{% if settings.show_footer_fb_like_box and store.facebook %}
            		{% if blocksCount == 2 %}
            		<div class="col-xs-12 col-md-6">
            		{% else %}
            		<div class="col-xs-12 col-md-4">
            		{% endif%}
            			<div class="title-container">
            		   		<h4 class="subtitle h5-xs">{{"Estamos en Facebook" | translate}}</h4>
            		    </div>
                        <div class="followus-container">
                            <div class="fb-page">
                                <div class="fb-page-head p-all-half">
                                    <div class="d-flex">
                                        <div class="fb-page-img-container m-right-half text-center">
            		                        {% if has_logo %}
            		                            <img src="{{ 'img/empty-placeholder.png' | static_url }}" class="fb-page-img lazyload" data-src="{{ store.logo('thumb')}}"/>
            		                        {% else %}
            		                        	{% include "snipplets/svg/facebook.tpl" with {fa_custom_class: "svg-inline--fa fa-3x fb-page-icon"} %}
            		                        {% endif %}
            		                    </div>
                                        <div>
                                            <div class="fb-page-title h4 m-top-none weight-normal">{{ store.name }}</div>
                                            <div class="m-top-half">
                                                <a href="{{ store.facebook }}" target="_blank" class="fb-like weight-strong">
                                                    {% include "snipplets/svg/thumbs-up.tpl" with {fa_custom_class: "svg-inline--fa m-right-quarter"} %}
                                                    {{ 'Me gusta' | translate }}
                                                </a>
                                        	</div>
                                    	</div>
                                	</div>
                                </div>
                                <div class="fb-page-footer p-all-half">
                                    <div class="fb-page-box">
                                        <a href="{{ store.facebook }}" target="_blank" class="fb-page-link">
                                            <span class="weight-strong opacity-80">{{ 'Visitá nuestra página' | translate }}</span>
                                            {% include "snipplets/svg/facebook.tpl" with {fa_custom_class: "svg-inline--fa fa-lg m-left-quarter"} %}
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
            		</div>
            		{% endif %}
            		{% if settings.twitter_widget %}
            		{% if blocksCount == 2 %}
            		<div class="col-xs-12 col-md-6">
            		{% else %}
            		<div class="col-xs-12 col-md-4">
            		{% endif%}
            			<div class="title-container">
            		   		<h4 class="subtitle h5-xs">{{"Estamos en Twitter" | translate}}</h4>
            		    </div>
            			{{ settings.twitter_widget | raw }}
            		</div>
            		{% endif %}
            	</div>
            </div>
        {% elseif section_select == 'video' %}
        	{# Home video #}
        	{% if settings.video_embed %}
                <div class="container">
            		<div class="row" data-store="video-home">
            			<div class="col-xs-12">
            				{% include 'snipplets/video-item.tpl' %}
            			</div>
            		</div>
                </div>
        	{% endif %}
        {% elseif section_select == 'instafeed' %}
        	{% if settings.show_instafeed and store.instagram %}
                <div class="container">
            	    <div class="row">
            	        {% set instuser = store.instagram|split('/')|last %}
            	        <div class="col-xs-12 text-center">
            	        	<div class="title-container">
            	            	<h3 class="subtitle">
            	            		<a target="_blank" href="{{ store.instagram }}" aria-label="{{ 'Instagram de' | translate }} {{ store.name }}">
                        				{% include "snipplets/svg/instagram.tpl" with {fa_custom_class: "svg-inline--fa m-right-quarter svg-text-fill"} %}
            	            			@{{ instuser }}
            	            		</a>
            	            	</h3>
            	        	</div>

            	        	{# Instagram fallback info in case feed fails to load #}
            				<div class="js-ig-fallback text-center m-bottom">
            					<a target="_blank" href="{{ store.instagram }}" aria-label="{{ 'Ver perfil' | translate }}">
            						{% include "snipplets/svg/instagram.tpl" with {fa_custom_class: "svg-inline--fa fa-4x m-right-quarter svg-primary-fill"} %}
            						<div class="text-uppercase m-top-half m-bottom">{{ 'Nuestro Instagram' | translate }}</div>
            						<span class="btn btn-secondary">{{ 'Ver perfil' | translate }}</span>
            					</a>
            				</div>
            			</div>
            		</div>

            		{# Instagram feed #}

            		{% if store.hasInstagramToken() %}
            			<div class="js-ig-success instafeed-module text-center" data-store="instagram-feed" style="display: none;">
            				<div class="row">
            					<div id="instagram-feed"
            						data-ig-feed
            						data-ig-items-count="4"
            						data-ig-item-class="instafeed-item col-md-3 col-xs-6 m-bottom p-left-half-xs p-right-half-xs"
            						data-ig-link-class="instafeed-link"
            						data-ig-image-class="instafeed-img img-responsive fade-in"
            						data-ig-aria-label="{{ 'Publicación de Instagram de' | translate }} {{ store.name }}">
            					</div>
            				</div>
            			</div>
            		{% endif %}
                </div>
        	{% endif %}
        {% endif %}

    {% set newArray = newArray|merge([section_select]) %}
   
    {% endif %}

{% endfor %}
            

