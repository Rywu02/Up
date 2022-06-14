{% set product_url_with_selected_variant = has_filters ?  ( product.url | add_param('variant', product.selected_or_first_available_variant.id)) : product.url %}
{% if product.compare_at_price > product.price %}
    {% set price_discount_percentage = ((product.compare_at_price) - (product.price)) * 100 / (product.compare_at_price) %}
{% endif %}
{% set has_color_variant = false %}
{% if settings.product_color_variants %}
    {% for variation in product.variations if variation.name in ['Color', 'Cor'] and variation.options | length > 1 %}
        {% set has_color_variant = true %}
    {% endfor %}
{% endif %}
<div data-path-hover="M 180,400 0,400 0,140 180,160 z" class="js-item-product {% if slide_item %}js-item-slide swiper-slide products-slider-item item-container-slide{% else %}js-masonry-grid-item{% endif %} item-container" data-product-type="list" data-product-id="{{ product.id }}" data-store="product-item-{{ product.id }}"> 
  <div class="item">
    {% if settings.quick_view or settings.product_color_variants %}
      <div class="js-product-container js-quickshop-container {% if product.variations %}js-quickshop-has-variants{% endif %}" data-variants="{{ product.variants_object | json_encode }}" data-quickshop-id="quick{{ product.id }}{% if slide_item and section_name %}-{{ section_name }}{% endif %}">
    {% endif %}
    <div class="labels-floating" data-store="product-item-labels">
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
      <div class="js-stock-label label label-circle label-primary label-overlap" {% if product.has_stock %}style="display:none;"{% endif %}>{{ settings.no_stock_text }}</div>
      {% if product.free_shipping %}
        <div class="label label-circle label-primary-dark label-overlap">{{ settings.free_shipping_text }}</div>
      {% endif %}
    </div>
    <span class="hidden" data-store="stock-product-{{ product.id }}-{% if product.has_stock %}{% if product.stock %}{{ product.stock }}{% else %}infinite{% endif %}{% else %}0{% endif %}"></span>
    <div class="p-relative overflow-none">
      {% if slide_item %}
        <div class="item-image-container-slide">
      {% endif %}
        {% if has_color_variant %}

          {# Item image will be the first avaiable variant #}

          {% set item_img_width = product.featured_variant_image.dimensions['width'] %}
          {% set item_img_height = product.featured_variant_image.dimensions['height'] %}
          {% set item_img_srcset = product.featured_variant_image %}
          {% set item_img_alt = product.featured_variant_image.alt %}
        {% else %}

          {# Item image will be the first image regardless the variant #}

          {% set item_img_width = product.featured_image.dimensions['width'] %}
          {% set item_img_height = product.featured_image.dimensions['height'] %}
          {% set item_img_srcset = product.featured_image %}
          {% set item_img_alt = product.featured_image.alt %}
        {% endif %}

        {% set item_img_spacing = item_img_height / item_img_width * 100 %}
        
        <div class="js-item-image-container item-image-container" style="padding-bottom: {{ item_img_spacing }}%;" data-store="product-item-image-{{ product.id }}">
          <img alt="{{ item_img_alt }}" src="{{ item_img_srcset | product_image_url('thumb')}}" data-srcset="{{ item_img_srcset | product_image_url('small')}} 240w, {{ item_img_srcset | product_image_url('medium')}} 320w, {{ item_img_srcset | product_image_url('large')}} 480w" class="js-item-image lazyload img-absolute img-absolute-centered item-image{% if slide_item %} item-image-slider{% endif %} blur-up" width="{{ item_img_width }}" height="{{ item_img_height }}"/>
          <div class="placeholder-overlay placeholder-container">
          </div>
          <a href="{{ product_url_with_selected_variant }}" title="{{ product.name }}" aria-label="{{ product.name }}"><div class="item-overlay"></div></a>
        </div>
      {% if slide_item %}
        </div>
      {% endif %}
      <div class="item-info-container" data-store="product-item-info-{{ product.id }}">
          <div class="item-info">
            {% if settings.product_color_variants %}
              {% include 'snipplets/item-colors.tpl' %}
            {% endif %}
            {% if (settings.quick_view or settings.product_color_variants) and product.variations %}
              <div class="js-item-variants item-buy-variants hidden">
                <form class="js-product-form" method="post" action="{{ store.cart_url }}">
                  <input type="hidden" name="add_to_cart" value="{{product.id}}" />
                  {% include "snipplets/variants.tpl" with {'quickshop': true} %}
                  <div class="js-quantity pull-left full-width-xs m-top">
                    <button type="button" class="js-quantity-down cart-quantity-btn cart-quantity-btn-left">
                      <div class="cart-quantity-svg-icon">
                        {% include "snipplets/svg/minus.tpl" %}
                      </div>
                    </button>
                    <div class="cart-quantity-input-container d-inline-block">                      
                      <input type="number" class="js-quantity-input cart-quantity-input text-center" autocorrect="off" autocapitalize="off" name="quantity" value="1" min="1" aria-label="{{ 'Cambiar cantidad' | translate }}">
                    </div>
                    <button type="button" class="js-quantity-up cart-quantity-btn cart-quantity-btn-right">
                      <div class="cart-quantity-svg-icon">
                        {% include "snipplets/svg/plus.tpl" %}
                      </div>
                    </button>
                  </div>
                  {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
                  {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'catalog': "Consultar", 'nostock' : settings.no_stock_text} %}
                  <div class="m-top full-width-container">
                    <input type="submit" class="js-prod-submit-form js-addtocart js-variant-addtocart btn btn-primary btn-block m-bottom d-inline-block {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} />

                    {# Fake add to cart CTA visible during add to cart event #}
                    {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "m-bottom m-top-none"} %}
                  </div>
                </form>
              </div>
            {% endif %}
            <a href="{{ product_url_with_selected_variant }}" title="{{ product.name }}" aria-label="{{ product.name }}">
              <h2 class="js-item-name item-name" data-store="product-item-name-{{ product.id }}">{{ product.name }}</h2>
              <div class="item-price-container {% if not product.display_price%}hidden{% endif %}" data-store="product-item-price-{{ product.id }}">
            	  <span class="js-compare-price-display {% if not product.compare_at_price %}hidden{% endif %} item-price-compare price-compare">
                 {% if product.compare_at_price %}
                  {{ product.compare_at_price | money }}
                 {% endif %}
                </span>
                <span class="js-offer-label m-left-half font-small"{% if not product.compare_at_price or not product.display_price %}style="display:none;"{% endif %}>
                  <span class="js-offer-percentage">{{ price_discount_percentage |round }}</span>% OFF
                </span>
                <div class="js-price-display price item-price" {% if not product.display_price %}class="hidden"{% endif %}>
                  {% if product.display_price %}
                    {{ product.price | money }}
                  {% endif %}
                </div>
                {% set product_can_show_installments = product.show_installments and product.display_price and product.get_max_installments.installment > 1 %}
                {% if product_can_show_installments %}
                  <div class="js-max-installments-container">  
                    {% set max_installments_without_interests = product.get_max_installments(false) %}
                    {% if max_installments_without_interests and max_installments_without_interests.installment > 1 %}
                      <span class="js-max-installments installments font-small-xs item-installments">{{ "<strong class='js-installment-amount installment-amount'>{1}</strong> cuotas sin interés de <strong class='js-installment-price installment-price'>{2}</strong>" | t(max_installments_without_interests.installment, max_installments_without_interests.installment_data.installment_value_cents | money) }}</span>
                    {% else %}
                        {% if store.country != 'AR' %}
                          {% set max_installments_with_interests = product.get_max_installments %}
                          {% if max_installments_with_interests %}
                          <span class="js-max-installments installments font-small-xs item-installments">{{ "<strong class='js-installment-amount installment-amount'>{1}</strong> cuotas de <strong class='js-installment-price installment-price'>{2}</strong>" | t(max_installments_with_interests.installment, max_installments_with_interests.installment_data.installment_value_cents | money) }}</span>
                          {% endif %}
                        {% endif %}
                    {% endif %}
                  </div>
                {% endif %}
              </div>
              {% if settings.quick_view and product.available and product.display_price %}
                <div class="item-actions m-top-half">
                  {% if product.variations %}
                    <a data-toggle="modal" href="#quickshop-modal" data-modal-url="modal-fullscreen-quickshop" class="js-quickshop-modal-open {% if slide_item %}js-quickshop-slide{% endif %} js-modal-open js-fullscreen-modal-open js-trigger-modal-zindex-top btn btn-primary btn-block btn-small btn-small-xs" title="{{ 'Compra rápida de' | translate }} {{ product.name }}" aria-label="{{ 'Compra rápida de' | translate }} {{ product.name }}" >{{ 'Agregar al carrito' | translate }}</a>
                  {% else %}
                    <form class="js-product-form" method="post" action="{{ store.cart_url }}">
                        <input type="hidden" name="add_to_cart" value="{{product.id}}" />
                        {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
                        {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}

                        <input type="submit" class="js-addtocart js-prod-submit-form btn btn-primary btn-block btn-small btn-small-xs {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} />

                        {# Fake add to cart CTA visible during add to cart event #}
                        {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "btn-small btn-small-xs m-top-none"} %}

                    </form>
                  {% endif %}
                </div>
              {% endif %}
            </a>
          </div>
        
      </div>
    </div>
    {% if settings.quick_view or settings.product_color_variants %}
      </div>
    {% endif %}
  </div>
  {# Structured data to provide information for Google about the product content #}
  {% include 'snipplets/structured_data/item-structured-data.tpl' %}
</div>
