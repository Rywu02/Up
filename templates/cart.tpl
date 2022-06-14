<div id="shoppingCartPage" data-minimum="{{ settings.cart_minimum_value }}" class="container">
    <div class="title-container" data-store="page-title">
        {% snipplet "breadcrumbs.tpl" %}
        <h1 class="title">{{ "Carrito de Compras" | translate }}</h1>
    </div>
    {# Page preloader #}
    <div class="page-loading-icon-container full-width hidden-when-content-ready">
        <div class="page-loading-icon page-loading-icon opacity-80 rotate">
            {% include "snipplets/svg/spinner.tpl" %}
        </div>
    </div>

    <span class="js-has-new-shipping" data-priceraw="{{ cart.subtotal }}"></span>

	<form role="form" action="" method="post" data-store="cart-form">

        {# Define contitions to show shipping calculator and store branches on cart #}

        {% set show_calculator_on_cart = settings.shipping_calculator_cart_page and store.has_shipping %}
        {% set show_cart_fulfillment = settings.shipping_calculator_cart_page and (store.has_shipping or store.branches) %}

		{% if cart.items %}
        <div class="js-cart-contents cart-table col-xs-12 visible-when-content-ready">
            {% if error.add %}
                <div class="alert alert-info">
                    {{ "¡Uy! No tenemos más stock de este producto para agregarlo al carrito. Si querés podés" | translate }}
                    <a href="{{ store.products_url }}" class="btn-link m-left-quarter">{{ "ver otros acá" | translate }}</a>
                </div>
            {% endif %}
            {% for error in error.update %}
                <div class="alert alert-info">{{ "No podemos ofrecerte {1} unidades de {2}. Solamente tenemos {3} unidades." | translate(error.requested, error.item.name, error.stock) }}</div>
            {% endfor %}

            {# Cart items #}

            {% for item in cart.items %}

            {% set show_free_shipping_label = item.product.free_shipping and not (cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price) %}

            <ul class="js-cart-item {% if item.product.is_non_shippable %}js-cart-item-non-shippable{% else %}js-cart-item-shippable{% endif %} cart-table-row row list-unstyled" data-item-id="{{ item.id }}" data-store="cart-item-{{ item.product.id }}">
                <li class="cart-table-product col-xs-12 col-sm-4">
                    <div class="row">

                        {# Cart item image #}
                        <a href="{{ item.url }}" class="col-xs-3">
                            {{ item.featured_image | product_image_url("medium") | img_tag(item.featured_image.alt, {class: 'img-responsive'}) }}
                        </a>

                        {# Cart item name #}
                        <div class="col-xs-9 m-top-half m-none-xs p-left-none-xs p-right-double-xs">
                            <a class="h5" href="{{ item.url }}">{{ item.short_name }}<small>{{ item.short_variant_name }}</small></a>
                            {% if show_free_shipping_label %}
                                <div class="m-top-quarter m-bottom-half">
                                    <span class="label label-primary label-primary-dark  font-small-extra">{{ "Envío gratis" | translate }}</span>
                                </div>
                            {% endif %}
                        </div>
                    </div>
                </li>

                {# Cart item quantity controls #}
                <li class="cart-quantity col-xs-12 col-sm-3 m-top-half-xs">
                    <div class="cart-quantity-container m-top-half text-right text-left-xs pull-left-xs">
                        <button type="button" class="js-cart-quantity-btn cart-quantity-btn cart-quantity-btn-left small" onclick="LS.minusQuantity({{ item.id }})">
                            <div class="cart-quantity-svg-icon">
                                {% include "snipplets/svg/minus.tpl" %}
                            </div>
                        </button>
                        <div class="cart-quantity-input-container d-inline-block">

                            {# Always place this spinner before the quantity input #}
                            
                            <span class="js-cart-input-spinner cart-item-spinner" style="display: none;">
                              {% include "snipplets/svg/circle-notch.tpl" with {fa_custom_class: "svg-inline--fa fa-spin"} %}
                            </span>
                            <input type="number" name="quantity[{{ item.id }}]" value="{{ item.quantity }}" data-item-id="{{ item.id }}" onKeyUp="LS.resetItems();" class="js-cart-quantity-input cart-quantity-input small" />
                        </div>
                        <button type="button" class="js-cart-quantity-btn cart-quantity-btn cart-quantity-btn-right small" onclick="LS.plusQuantity({{ item.id }})">
                            <div class="cart-quantity-svg-icon">
                                {% include "snipplets/svg/plus.tpl" %}
                            </div>
                        </button>
                    </div>

                    {# Cart item mobile subtotal #}
                    <div class="visible-xs cart-item-subtotal pull-right h5 font-medium-xs m-top">
                        <small class="hidden-xs">{{ "Precio" | translate }}</small>
                        <div class="js-cart-item-subtotal" data-line-item-id="{{ item.id }}">{{ item.subtotal | money }}</div>
                    </div>
                </li>

                {# Cart item unit price #}
                <li class="col-price col-sm-2 hidden-xs text-center m-top-quarter">
                    <small>{{ "Precio" | translate }}</small>
                    <div class="h4 m-top-quarter">{{ item.unit_price | money }}</div>
                </li>

                {# Cart item subtotal #}
                 <li class="col-sm-2 hidden-xs text-center m-top-quarter">
                    <small>{{ "Subtotal" | translate }}</small>
                    <div class="js-cart-item-subtotal h4 m-top-quarter" data-line-item-id="{{ item.id }}">{{ item.subtotal | money }}</div>
                </li>

                {# Cart item delete #}
                <li class="cart-delete-container col-xs-1 text-right">
                    <button type="button" class="item-delete cart-btn-delete pull-right-xs" onclick="LS.removeItem({{ item.id }})">
                        <div class="cart-delete-svg-icon">
                            {% include "snipplets/svg/trash-o.tpl" with {fa_custom_class: "svg-trash-icon svg-text-fill"} %}
                        </div>
                    </button>
                </li>
            </ul>            
            {% endfor %}

            {# Cart alerts #}
            <div id="error-ajax-stock" class="row" style="display: none;">
                <span colspan="12" class='alert alert-warning col-xs-12' role='alert'>
                    {{ "No hay suficiente stock para agregar este producto al carrito." | translate }}
                </span>
            </div>
        </div>
        
        {# Cart totals #}
        <div class="cart-totals-container visible-when-content-ready clear-both">

            <div class="row">
                <div class="js-shipping-calculator-container col-12 col-sm-6 m-bottom-xs p-bottom-xs">
                    {% if show_cart_fulfillment %}

                        <div class="js-fulfillment-info js-allows-non-shippable" {% if not cart.has_shippable_products %}style="display: none"{% endif %}>

                            {# Saved shipping not available #}

                            <div class="js-shipping-method-unavailable alert alert-warning clear-both m-top" style="display: none;">
                                <div>
                                    <strong>{{ 'El medio de envío que habías elegido ya no se encuentra disponible para este carrito. ' | translate }}</strong>
                                </div>
                                <div>
                                    {{ '¡No te preocupes! Podés elegir otro.' | translate}}
                                </div>
                            </div>
                            
                            {# Shipping calculator and branch link #}
                            <div id="cart-shipping-container" class="row clear-both" {% if cart.items_count == 0 %} style="display: none;"{% endif %} data-shipping-url="{{ store.shipping_calculator_url }}">

                                {# Used to save shipping #}

                                <span id="cart-selected-shipping-method" data-code="{{ cart.shipping_data.code }}" class="hide">{{ cart.shipping_data.name }}</span>

                                <div class="col-md-8">
                                    <div class="m-bottom-half m-top-half border-bottom p-bottom-half">

                                        {% if store.has_shipping %}
                                            <div class="row">
                                                {% include "snipplets/shipping/shipping_cost_calculator.tpl" with { 'product_detail': false} %}
                                            </div>
                                        {% endif %}

                                        {% if store.branches %}

                                            {# Link for branches #}

                                            {% include "snipplets/shipping/branch-details.tpl" with {'product_detail': false} %}
                                        {% endif %}
                                    </div>
                                </div>
                            </div>
                        </div>                          
                    {% endif %}

                    {% if cart.items and settings.continue_buying %}
                        {% set last_item_added = (cart.items | first) %}
                        <div class="continue-buying-container hidden-xs">
                            <a href="{{ last_item_added.product.category.url }}" class="btn-link continue-buying pull-left m-top m-bottom">{{ 'Ver más productos' | translate }}</a>
                        </div>
                    {% endif %}
                </div>

                <div class="col-xs-12 col-sm-6">
                    {# Cart subtotal #}
                    <div class="cart-totals cart-subtotal" data-store="cart-subtotal">
                        <span>
                            {{ "Subtotal" | translate }}
                        </span>
                        <small class="js-subtotal-shipping-wording" {% if not (cart.has_shippable_products or show_calculator_on_cart) %}style="display: none"{% endif %}>{{ " (sin envío)" | translate }}</small>
                        :
                        <span class='js-cart-subtotal' data-priceraw="{{ cart.subtotal }}">
                            {{ cart.subtotal | money }}
                        </span>
                    </div>

                    {# Cart promos #}
                    <div class="js-total-promotions total-promotions clear-both m-top-none pull-right">
                        <span class="js-promo-in" style="display:none;">{{ "en" | translate }}</span>
                        <span class="js-promo-all" style="display:none;">{{ "todos los productos" | translate }}</span>
                        <span class="js-promo-buying" style="display:none;"> {{ "comprando" | translate }}</span>
                        <span class="js-promo-units-or-more" style="display:none;"> {{ "o más." | translate }}</span>
                        {% for promotion in cart.promotional_discount.promotions_applied %}
                            {% if(promotion.scope_value_id) %}
                                {% set id = promotion.scope_value_id %}
                            {% else %}
                                {% set id = 'all' %}
                            {% endif %}
                            <span class="js-total-promotions-detail-row total-promotions-row p-bottom-quarter" id="{{ id }}">
                                {% if promotion.discount_script_type != "custom" %}
                                    {% if promotion.discount_script_type == "NAtX%off" %}
                                        {{ promotion.selected_threshold.discount_decimal_percentage * 100 }}% OFF
                                    {% else %}
                                        {{ promotion.discount_script_type }}
                                    {% endif %}

                                    {{ "en" | translate }} {% if id == 'all' %}{{ "todos los productos" | translate }}{% else %}{{ promotion.scope_value_name }}{% endif %}

                                    {% if promotion.discount_script_type == "NAtX%off" %}
                                        <span class="text-lowercase">{{ "Comprando {1} o más." | translate(promotion.selected_threshold.quantity) }}</span>
                                    {% endif %}
                                {% else %}
                                    {{ promotion.scope_value_name }}
                                {% endif %}
                                :  
                                <span class="cart-promotion-number">-{{ promotion.total_discount_amount_short }}</span>
                            </span>
                        {% endfor %}
                    </div>

                    {# Cart total #}
                    <div class="cart-totals cart-total" data-store="cart-total">
                        <span class="text-secondary">{{ "Total" | translate }}: </span>
                        <span class="js-cart-total {% if cart.free_shipping.cart_has_free_shipping %}js-free-shipping-achieved{% endif %} {% if cart.shipping_data.selected %}js-cart-saved-shipping{% endif %} text-secondary" data-priceraw="{{ cart.total }}">{{ cart.total | money }}</span>

                        {# IMPORTANT Do not remove this hidden total, it is used by JS to calculate cart total #}
                        <div class="total-price hidden" data-priceraw="{{ cart.total }}">
                            {{ "Total" | translate }} {{ cart.total | money }}
                        </div>
                        
                        {# Cart installments #}
  
                        {% if cart.installments.max_installments_without_interest > 1 %}
                            {% set installment =  cart.installments.max_installments_without_interest  %}
                            {% set total_installment = cart.total %}
                            {% set interest = false %}
                            {% set interest_value = 0 %}
                        {% else %}
                            {% set installment = cart.installments.max_installments_with_interest  %}
                            {% set total_installment = (cart.total * (1 + cart.installments.interest)) %}
                            {% set interest = true %}
                            {% set interest_value = cart.installments.interest %}
                        {% endif %}
                        <div {% if installment < 2 or ( store.country == 'AR' and interest == true ) %} style="display: none;" {% endif %} data-interest="{{ interest_value }}" data-cart-installment="{{ installment }}" class="js-installments-cart-total font-body">    
                            {{ 'O hasta' | translate }}
                            {% if interest == true %}
                              {{ "<span class='js-cart-installments-amount'>{1}</span> cuotas de <span class='js-cart-installments installment-price'>{2}</span>" | t(installment, (total_installment / installment) | money) }}
                            {% else %}
                              {{ "<span class='js-cart-installments-amount'>{1}</span> cuotas sin interés de <span class='js-cart-installments installment-price'>{2}</span>" | t(installment, (total_installment / installment) | money) }}
                            {% endif %}
                        </div>

                    </div>

                    <div class="go-to-checkout m-top full-width-container visible-when-content-ready">
                        {# Cart CTA #}
                        {% set cart_total = (settings.cart_minimum_value * 100) %}
                        {% if cart.checkout_enabled %}
                            <input id="go-to-checkout" class="btn btn-primary pull-right full-width-xs m-bottom m-top-half-xs" type="submit" name="go_to_checkout" value="{{ 'Iniciar Compra' | translate }}" autocomplete="off"/>
                        {% else %}
                            <h5 class="text-right pull-right">{{ "El monto mínimo de compra (sin envío) es de" | translate }} <strong>{{ cart_total | money }}</strong></h5>
                        {% endif %}
                        {% if cart.items and settings.continue_buying %}
                            {% set last_item_added = (cart.items | first) %}
                            <div class="continue-buying-container text-center visible-xs">
                                <a href="{{ last_item_added.product.category.url }}" class="btn-link continue-buying pull-left m-bottom full-width">{{ 'Ver más productos' | translate }}</a>
                            </div>
                        {% endif %}
                        <input class="hidden pull-right" type="submit" name="update" value="{{ 'Cambiar cantidad' | translate }}" id="change-quantities"/>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">    		
    		
        </div>
		{% else %}
		<div class="alert alert-warning">
			{% if error %}
				{{ "¡Uy! No tenemos más stock de este producto para agregarlo al carrito. Si querés podés" | translate }}
                <a href="{{ store.products_url }}" class="btn-link m-left-quarter">{{ "ver otros acá" | translate }}</a>
			{% else %}
				{{ "El carrito de compras está vacío." | translate }}
			{% endif %}
			{{ ("Ver más productos" | translate ~ " »") | a_tag(store.products_url) }}
		</div>
		{% endif %}		
	</form>

	<div id="store-curr" class="hidden">{{ store.currency }}</div>

</div>
