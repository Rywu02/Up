{% if product.compare_at_price > product.price %}
    {% set price_discount_percentage = ((product.compare_at_price) - (product.price)) * 100 / (product.compare_at_price) %}
{% endif %}

{% set has_multiple_slides = product.images_count > 1 or product.video_url %}

<div class="container js-product-container js-product-detail js-shipping-calculator-container js-has-new-shipping">
    <div class="row m-bottom m-bottom-half-xs">
        {% snipplet "breadcrumbs.tpl" %}
    </div>
    <div class="row" id="single-product" data-variants="{{product.variants_object | json_encode }}">
        <div class="col-xs-12 col-sm-6" data-store="product-image-{{ product.id }}">
            <div class="row">
                {% snipplet 'placeholders/product-detail-image-placeholder.tpl' %}
                <div id="product-slider-container" class="js-product-image-container product-slider-container {% if not has_multiple_slides %}product-single-image{% endif %}">
                    {% if product.images_count > 0 %}
                        <div class="js-swiper-product product-slider no-slide-effect-md swiper-container">
                            <div class="swiper-wrapper">
                                {% for image in product.images %}
                                    <div class="js-product-slide swiper-slide product-slide" data-image="{{image.id}}" data-image-position="{{loop.index0}}" data-zoom-url="{{ image | product_image_url('huge') }}">
                                        <a href="{{ image | product_image_url('original') }}" class="js-desktop-zoom cloud-zoom" rel="position: 'inside', showTitle: false, loading: '{{ 'Cargando...' | translate }}'" style="padding-bottom: {{ image.dimensions['height'] / image.dimensions['width'] * 100}}%;">
                                            <img data-sizes="auto" src="{{ image | product_image_url('small') }}" data-srcset='{{  image | product_image_url('large') }} 480w, {{  image | product_image_url('huge') }} 640w' class="js-product-slide-img js-image-open-mobile-zoom product-slider-image img-absolute img-absolute-centered lazyautosizes lazyload  blur-up" {% if image.alt %}alt="{{image.alt}}"{% endif %} />
                                        </a>
                                    </div>
                                {% endfor %}
                                {% include 'snipplets/product-video.tpl' %}
                            </div>
                            {% if has_multiple_slides %}
                                <div class="js-swiper-product-pagination swiper-pagination visible-xs"></div>
                                <div class="js-swiper-product-prev swiper-button-prev hidden-xs">{% include "snipplets/svg/angle-left.tpl" with {fa_custom_class: "slider-arrow"} %}</div>
                                <div class="js-swiper-product-next swiper-button-next hidden-xs">{% include "snipplets/svg/angle-right.tpl" with {fa_custom_class: "slider-arrow"} %}</div>
                            {% endif %}
                        </div>
                    {% endif %}
                      <div class="{% if product.video_url and product %}js-labels-group{% endif %} labels-floating m-left-quarter" data-store="product-item-labels">
                        {% if product.promotional_offer %}
                          {% if product.promotional_offer.script.is_percentage_off %}
                            <div class="label label-circle label-secondary label-text label-accent" data-store="product-item-promotion-label">
                              <div>{{ product.promotional_offer.parameters.percent * 100 }}%</div>
                              <div> OFF</div>
                            </div>
                          {% elseif product.promotional_offer.script.is_discount_for_quantity %}
                            <div class="label label-circle label-secondary label-text label-accent" data-store="product-item-promotion-label">
                              <div class="p-top-quarter"><strong>{{ product.promotional_offer.selected_threshold.discount_decimal_percentage * 100 }}% OFF</strong></div>
                              <div class="label-small">{{ "Comprando {1} o más." | translate(product.promotional_offer.selected_threshold.quantity) }}</div>
                            </div>
                          {% else %}
                            <div class="label label-circle label-secondary label-accent" {% if not product.display_price %} style='display: none'{% endif %} data-store="product-item-promotion-label">
                              {% if store.country == 'BR' %}
                                {{ "Leve {1} Pague {2}" | translate(product.promotional_offer.script.quantity_to_take, product.promotional_offer.script.quantity_to_pay) }}
                              {% else %}
                                {{ product.promotional_offer.script.type }}
                              {% endif %}
                            </div>
                          {% endif %}
                        {% elseif product.compare_at_price > product.price %}
                          <div class="js-offer-label label label-circle label-secondary label-text label-accent" {% if not product.display_price %} style='display: none'{% endif %} data-store="product-item-offer-label">
                            {{ settings.offer_text }}
                          </div>
                        {% endif %}
                        {% if not product.has_stock %}
                          <div class="label label-circle label-primary label-accent label-overlap">{{ settings.no_stock_text }}</div>
                        {% endif %}
                        {% if product.free_shipping %}
                          <div class="label label-circle label-primary-dark label-overlap">{{ settings.free_shipping_text }}</div>
                        {% endif %}
                    </div>
                    <span class="hidden" data-store="stock-product-{{ product.id }}-{% if product.has_stock %}{% if product.stock %}{{ product.stock }}{% else %}infinite{% endif %}{% else %}0{% endif %}"></span>
                    <div class="visible-when-content-ready visible-xs">
                        <a href="#" class="js-open-mobile-zoom btn-floating" aria-label="{{ 'Zoom de la imagen' | translate }}">
                            <div class="zoom-svg-icon">
                                {% include 'snipplets/svg/arrows-alt.tpl' with {fa_custom_class: "svg-text-fill"} %}
                            </div>
                        </a>
                    </div>
                </div>
            </div>
            <div class="row hidden-xs">
                {% if has_multiple_slides %}
                    <div class="thumbs visible-when-content-ready m-top">
                        {% for image in product.images %}
                            <a href="#" class="js-product-thumb thumb-link" data-slide-index="{{loop.index0}}">
                                <img data-sizes="auto" src="{{ image | product_image_url('small') }}" data-srcset='{{  image | product_image_url('large') }} 480w, {{  image | product_image_url('huge') }} 640w' class="thumb-image lazyautosizes lazyload blur-up" {% if image.alt %}alt="{{image.alt}}"{% endif %} />
                            </a>
                        {% endfor %}
                        
                        {# Video thumb #}

                        {% include 'snipplets/product-video.tpl' with {thumb: true} %}
                    </div>
                {% endif %}
            </div>
        </div>
        <div class="col-xs-12 col-sm-6 product-form-container" data-store="product-info-{{ product.id }}">
            <h1 itemprop="name" class="product-name" data-store="product-name-{{ product.id }}">{{ product.name }}</h1>
            <div>
                {% if product.promotional_offer.script.is_percentage_off %}
                    <input class="js-promotional-parameter" type="hidden" value="{{product.promotional_offer.parameters.percent}}">
                {% endif %}
                <div class="product-price-container" data-store="product-price-{{ product.id }}">
                    <h4 id="compare_price_display" class="js-compare-price-display product-price-compare price-compare m-bottom-quarter-xs" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% endif %}>
                    {% if product.compare_at_price %}
                        {{ product.compare_at_price | money }}
                    {% endif %}
                    </h4>
                    <h2 class="h1 product-price js-price-display d-inline" {% if not product.display_price %}style="display:none;"{% endif %} id="price_display">
                    {% if product.display_price %}
                        {{ product.price | money }}
                    {% endif %}
                    </h2>
                    <span class="js-offer-label"{% if not product.compare_at_price or not product.display_price %}style="display:none;"{% endif %}>
                        <span>
                            <span class="js-offer-percentage">{{ price_discount_percentage |round }}</span>% OFF
                        </span>
                    </span>

                    {% if product.promotional_offer and not product.promotional_offer.script.is_percentage_off and product.display_price %}
                    <div class="row-fluid" data-store="product-promotion-info">
                        {% if product.promotional_offer.script.is_discount_for_quantity %}
                            {% for threshold in product.promotional_offer.parameters %}
                                <h4 class="promo-title"><strong>{{ "¡{1}% OFF comprando {2} o más!" | translate(threshold.discount_decimal_percentage * 100, threshold.quantity) }}</strong></h4>
                            {% endfor %}
                        {% else %}
                            <h4 class="promo-title"><strong>{{ "¡Llevá {1} y pagá {2}!" | translate(product.promotional_offer.script.quantity_to_take, product.promotional_offer.script.quantity_to_pay) }}</strong></h4>
                        {% endif %}
                        {% if product.promotional_offer.scope_type == 'categories' %}
                            <p class="promo-message">{{ "Válido para" | translate }} {{ "este producto y todos los de la categoría" | translate }}:
                            {% for scope_value in product.promotional_offer.scope_value_info %}
                               {{ scope_value.name }}{% if not loop.last %}, {% else %}.{% endif %}
                            {% endfor %}</br>{{ "Podés combinar esta promoción con otros productos de la misma categoría." | translate }}</p>
                        {% elseif product.promotional_offer.scope_type == 'all'  %}<p class="promo-message">{{ "Vas a poder aprovechar esta promoción en cualquier producto de la tienda." | translate }}</p>
                        {% endif %}
                    </div>
                    {% endif %}
                </div>
                {% snipplet 'placeholders/product-detail-form-placeholder.tpl' %}

                {# Product Installments button and info #}
                {% if product.show_installments and product.display_price %}
                    {% set installments_info_base_variant = product.installments_info %}
                    {% set installments_info = product.installments_info_from_any_variant %}
                    {% if installments_info %}
                        <a href="#installments-modal" data-toggle="modal" data-modal-url="modal-fullscreen-payments" class="js-fullscreen-modal-open js-refresh-installment-data js-product-payments-container display-when-content-ready link-module" {% if (not product.get_max_installments) and (not product.get_max_installments(false)) %}style="display: none;"{% endif %}>
                            {% snipplet "installments_in_product.tpl" %}

                            {# Cash discount #}
                            {% if custom_payment.discount > 0 %}
                                <div class="span12 m-left-none m-bottom-half p-right-double">
                                    {% include "snipplets/svg/money-bill.tpl" with { fa_custom_class: "payment-credit-card m-right-quarter svg-primary-fill" } %}
                                    <span class="text-tertiary"><strong>{{ custom_payment.discount }}% {{'de descuento' | translate }}</strong> {{'pagando con' | translate }} {{ custom_payment.name }}</span>
                                </div>
                            {% endif %}
                            

                            {% if product.show_installments and product.display_price %}
                                <div id="btn-installments" class="btn-link btn-link-small" {% if (not product.get_max_installments) and (not product.get_max_installments(false)) %}style="display: none;"{% endif %}>
                                    {% set store_set_for_new_installments_view = store.is_set_for_new_installments_view %}
                                    {% if store_set_for_new_installments_view %}
                                        {{ "Ver medios de pago" | translate }}
                                    {% else %}
                                        {{ "Ver el detalle de las cuotas" | translate }}
                                    {% endif %}
                                </div>
                                <div class="visible-xs link-module-icon-right">
                                    {% include "snipplets/svg/angle-right.tpl" %}
                                </div>
                            {% endif %}
                        </a>
                    {% endif %}
                {% endif %}

                <form id="product_form" method="post" action="{{ store.cart_url }}" class="display-when-content-ready" data-store="product-form-{{ product.id }}">
                    <input type="hidden" name="add_to_cart" value="{{product.id}}" />
                    {% if product.variations %}
                        {% include "snipplets/variants.tpl" with {'quickshop': false} %}
                    {% endif %}

                    {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
                    {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'catalog': "Consultar", 'nostock' : settings.no_stock_text} %}

                    {# Add to cart CTA #}

                    <div class="m-top full-width-container">
                        <input type="submit" class="js-prod-submit-form js-addtocart btn btn-primary btn-block m-bottom d-inline-block {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} data-store="product-buy-button"/>

                        {# Fake add to cart CTA visible during add to cart event #}
                        {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "m-top-none m-bottom"} %}
                        
                        {% if settings.ajax_cart %}
                            <div class="js-added-to-cart-product-message pull-left full-width m-bottom p-bottom-quarter m-top-half" style="display: none;">
                                {{'Ya agregaste este producto.' | translate }}
                                <a href="#" class="js-toggle-cart js-fullscreen-modal-open btn-link btn-link-small p-left-quarter"  data-modal-url="modal-fullscreen-cart">{{ 'Ver carrito' | translate }}</a>
                            </div>
                        {% endif %}

                    </div>

                    {# Define contitions to show shipping calculator and store branches on product page #}

                    {% set show_product_fulfillment = settings.shipping_calculator_product_page and (store.has_shipping or store.branches) and not product.free_shipping and not product.is_non_shippable %}

                    {% if show_product_fulfillment %}
                        
                        <div class="row clear-both">

                            {# Shipping calculator and branch link #}

                            <div class="container-fluid">
                                <div id="product-shipping-container" class="product-shipping-calculator list-readonly m-bottom-double" {% if not product.display_price or not product.has_stock %}style="display:none;"{% endif %} data-shipping-url="{{ store.shipping_calculator_url }}">
                                    {% if store.has_shipping %}
                                        <div class="row">
                                            {% include "snipplets/shipping/shipping_cost_calculator.tpl" with { 'shipping_calculator_variant' : product.selected_or_first_available_variant, 'product_detail' : true} %}
                                        </div>
                                    {% endif %}
                                    {% if store.branches %}
                                        {# Link for branches #}

                                        {% include "snipplets/shipping/branch-details.tpl" with {'product_detail': true} %}
                                    {% endif %}
                                </div>
                            </div>
                        </div>
                    {% endif %}
                    
                    {# Product informative banners #}

                    {% include 'snipplets/product-informative-banner.tpl' %}
                    
                    {% include 'snipplets/social-widgets.tpl'%}
                    {% if not settings.show_description_bottom %}
                        <div class="description user-content m-top" data-store="product-description-{{ product.id }}">{{ product.description }}</div>
                    {% endif %}
                </form>
            </div>
        </div>
    </div>
	<div class="row visible-when-content-ready">
		{% if settings.show_description_bottom %}
    		<div class="col-xs-12 user-content m-top" data-store="product-description-{{ product.id }}">
    			<div class="description user-content">{{ product.description }}</div>
    		</div>
		{% endif %}
		<div class="col-xs-12 visible-when-content-ready">
			<div class="comments-area m-top">
                {% if settings.show_product_fb_comment_box %}
				    <div class="fb-comments" data-href="{{ product.social_url }}" data-num-posts="5" data-width="100%"></div>
                {% endif %}
            </div>
		</div>
	</div>
    <div id="related-products" data-store="related-products">
        {% set related_products = [] %}
        {% set related_products_ids_from_app = product.metafields.related_products.related_products_ids %}
        {% set has_related_products_from_app = related_products_ids_from_app | get_products | length > 0 %}
        {% if has_related_products_from_app %}
            {% set related_products = related_products_ids_from_app | get_products %}
        {% endif %}
        {% if related_products is empty %}
            {% set max_related_products_length = 4 %}
            {% set max_related_products_achieved = false %}
            {% set related_products_without_stock = [] %}
            {% set max_related_products_without_achieved = false %}
            
            {% set products_from_category = category.products | shuffle %}
            {% for product_from_category in products_from_category if not max_related_products_achieved and product_from_category.id != product.id %}
                {%  if product_from_category.stock is null or product_from_category.stock > 0 %}
                    {% set related_products = related_products | merge([product_from_category]) %}
                {% elseif (related_products_without_stock | length < max_related_products_length) %}
                    {% set related_products_without_stock = related_products_without_stock | merge([product_from_category]) %}
                {% endif %}
                {%  if (related_products | length == max_related_products_length) %}
                    {% set max_related_products_achieved = true %}
                {% endif %}
            {% endfor %}
            {% if (related_products | length < max_related_products_length) %}
                {% set number_of_related_products_for_refill = max_related_products_length - (related_products | length) %}
                {% set related_products_for_refill = related_products_without_stock | take(number_of_related_products_for_refill) %}
                
                {% set related_products = related_products | merge(related_products_for_refill)  %}
            {% endif %}
        {% endif %}

        {% if related_products | length > 0 %}
            <div class="title-container">
                <h2 class="subtitle">{{"Productos Relacionados" | translate}}</h2>
            </div>
            <div class="row">
                <div class="col-md-12 text-center-xs">
                    <section id="grid" class="js-masonry-grid grid clearfix">
                        <div class="js-masonry-grid">
                            {% for related in related_products %}
                                {% include 'snipplets/single_product.tpl' with {product : related} %}
                            {% endfor %}
                        </div>
                    </section>
                </div>
                </div>
        {% endif %}
    </div>
</div>

{# Payments details #}

{% include 'snipplets/payments/payments.tpl' %}

<div class="js-mobile-zoom-panel mobile-zoom-panel">
    {% include "snipplets/svg/circle-notch.tpl" with {fa_custom_class: "svg-inline--fa js-mobile-zoom-spinner mobile-zoom-spinner fa-2x fa-spin svg-text-fill"} %}
    <div class="js-mobile-zoomed-image mobile-zoom-image-container">
       {# Container to be filled with the zoomable image #}
    </div>
    <a class="js-close-mobile-zoom btn btn-default btn-floating">
        {% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa fa-2x"} %}
    </a>
</div>

{# Product video modal on mobile #}

{% include 'snipplets/product-video.tpl' with {product_video_modal: true} %}
