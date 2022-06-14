<form action="{{ store.cart_url }}" method="post" id="ajax-cart-details" class="js-ajax-cart-panel js-fullscreen-modal modal-right modal-xs modal-xs-right modal-xs-right-out" style="display: none;" data-store="cart-form">
		<div class="modal-xs-dialog">
	  	<div id="store-curr" class="hidden">{{ cart.currency }}</div>
	  	<div class="subtotal-price hidden" data-priceraw="{{ cart.total }}"></div>
		
		{# Define contitions to show shipping calculator and store branches on cart #}

		{% set show_calculator_on_cart = settings.shipping_calculator_cart_page and store.has_shipping %}
		{% set show_cart_fulfillment = settings.shipping_calculator_cart_page and (store.has_shipping or store.branches) %}
	  	
	  	{# Cart panel header #}
 	    <a class="js-toggle-cart js-fullscreen-modal-close modal-xs-header visible-xs" href="#">
	        {% include "snipplets/svg/angle-left.tpl" with {fa_custom_class: "svg-inline--fa fa-2x modal-xs-header-icon modal-xs-right-header-icon"} %}
	        <span class="modal-xs-header-text modal-xs-right-header-text">{{ "Carrito de compras" | translate }}</span>
	    </a>
	 	<div class="modal-right-header hidden-xs">
			<a href="#" class="js-toggle-cart m-bottom">
		 		{% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa fa-2x svg-text-fill opacity-50"} %}
		 	</a>
	 	</div>

	 	<div class="modal-content">
		 	{# Cart panel body #}
		 	<div class="ajax-cart-body modal-right-body modal-xs-body">
		 		<div class="cart-table container-fluid">
			 	 	<div class="ajax-cart-table-header cart-table-header hidden-xs row">
			          	<div class="pull-left p-left-half">
		            		<h5>{{ "Producto" | translate }}</h5>
		          		</div>
		          		<div class="pull-right text-right p-right-half m-right-double">
		            		<h5>{{ "Subtotal" | translate }}</h5>
		          		</div>
			        </div>

			        {# Cart panel items #}
				 	<div class="js-ajax-cart-list ajax-cart">
				 	  {% if cart.items %}
				 	  	{% for item in cart.items %}
							{% include "snipplets/cart-item-ajax.tpl" %}
						{% endfor %}
				 	  {% endif %}
				 	</div>

					{# Cart panel empty #}
		            <div class="js-empty-ajax-cart clear-both alert alert-info m-top" {% if cart.items_count > 0 %}style="display:none;"{% endif %}>
		              {{ "El carrito de compras está vacío." | translate }}
		            </div>
			 	</div>

				{# Cart panel totals #}
				<div class="js-visible-on-cart-filled cart-subtotal cart-totals" {% if cart.items_count == 0 %}style="display:none;"{% endif %} data-store="cart-subtotal">

					{# Cart panel subtotal #}
					<span>
						{{ "Subtotal" | translate }}
						<small class="js-subtotal-shipping-wording" {% if not (cart.has_shippable_products or  show_calculator_on_cart) %}style="display: none"{% endif %}>{{ " (sin envío)" | translate }}</small>
						:
					</span>
					<span class="js-ajax-cart-total js-cart-subtotal" data-priceraw="{{ cart.subtotal }}">{{ cart.subtotal | money }}</span>
		      	</div>

				{# Cart panel promos #}
			 	<div class="js-total-promotions total-promotions full-width pull-left text-right ajax-cart-promotions">
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
					<span class="js-total-promotions-detail-row total-promotions-row" id="{{ id }}">
						<span class="cart-promotion-detail">
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
						</span>
						<span class="cart-promotion-number">-{{ promotion.total_discount_amount_short }}</span>
					</span>
					{% endfor %}
		      	</div>

				{# Cart panel shipping #}

				{% if show_cart_fulfillment %}
					<div class="js-fulfillment-info js-allows-non-shippable" {% if not cart.has_shippable_products %}style="display: none"{% endif %}>
						<div class="js-visible-on-cart-filled js-has-new-shipping js-shipping-calculator-container">

							{# Saved shipping not available #}

							<div class="js-shipping-method-unavailable alert alert-warning clear-both m-top" style="display: none;">
								<div><strong>{{ 'El medio de envío que habías elegido ya no se encuentra disponible para este carrito. ' | translate }}</strong></div>
								<div>{{ '¡No te preocupes! Podés elegir otro.' | translate}}</div>
							</div>
			                
			                {# Shipping calculator and branch link #}
							<div id="cart-shipping-container" class="row clear-both" {% if cart.items_count == 0 %} style="display: none;"{% endif %} data-shipping-url="{{ store.shipping_calculator_url }}">

								{# Used to save shipping #}

	            				<span id="cart-selected-shipping-method" data-code="{{ cart.shipping_data.code }}" class="hide">{{ cart.shipping_data.name }}</span>

								<div class="container-fluid m-bottom-half m-top-half border-top border-bottom p-top p-bottom-half">
									{% if store.has_shipping %}
							    		{% include "snipplets/shipping/shipping_cost_calculator.tpl" with {'shipping_calculator_show': settings.shipping_calculator_cart_page, 'product_detail': false, 'ajax_cart': true} %}
							  		{% endif %}

							  		{% if store.branches %}

	                                    {# Link for branches #}

	                                    {% include "snipplets/shipping/branch-details.tpl" with {'product_detail': false, 'ajax_cart': true} %}
	                                {% endif %}
								</div>
							</div>	             
			            </div>
					</div>
	            {% endif %}

				{# Cart panel total #}
			 	<div class="js-visible-on-cart-filled cart-totals cart-total" {% if cart.items_count == 0 %}style="display:none;"{% endif %} data-store="cart-total">
			 		<div id="error-ajax-stock" class="row" style="display:none;">
			          	<div class='alert alert-warning' role='alert'>
			              	{{ "¡Uy! No tenemos más stock de este producto para agregarlo al carrito. Si querés podés" | translate }}
			              	<a href="{{ store.products_url }}" class="btn-link m-left-quarter">{{ "ver otros acá" | translate }}</a>
			          	</div>
		          	</div>
					<span class="text-secondary">{{ "Total" | translate }}: </span>
					<span class="js-cart-total {% if cart.free_shipping.cart_has_free_shipping %}js-free-shipping-achieved{% endif %} {% if cart.shipping_data.selected %}js-cart-saved-shipping{% endif %} text-secondary">{{ cart.total | money }}</span>
				 	{# IMPORTANT Do not remove this hidden total, it is used by JS to calculate cart total #}
		            <div class='total-price hidden'>
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

			 	<div class="js-visible-on-cart-filled full-width pull-left" {% if cart.items_count == 0 %}style="display:none;"{% endif %}>

			 		{# Cart panel CTA #}
			 		{% set cart_total = (settings.cart_minimum_value * 100) %}
			 		<div class="js-ajax-cart-submit m-bottom" {{ not cart.checkout_enabled ? 'style="display:none"' }} id="ajax-cart-submit-div">
						<input class="btn btn-primary btn-block" type="submit" name="go_to_checkout" value="{{ 'Iniciar Compra' | translate }}"/>
			 		</div>
			 		<div class="js-ajax-cart-minimum clear-both p-top-half" {{ cart.checkout_enabled ? 'style="display:none"' }} id="ajax-cart-minumum-div">
			 			<div class="alert alert-warning" role="alert">
			 		  	{{ "El monto mínimo de compra es de {1} sin incluir el costo de envío" | t(cart_total | money) }}
			 			</div>
			 		</div>

			 		{# Cart panel continue buying #}
			 		{% if settings.continue_buying %}
						<div class="text-center">
							<a href="#" class="js-toggle-cart js-fullscreen-modal-close btn btn-link m-bottom p-none">{{ 'Ver más productos' | translate }}</a>
				 		</div>
			 		{% endif %}
			 		<input type="hidden" id="ajax-cart-minimum-value" value="{{ cart_total }}"/>
			 	</div>
		 	</div>
		 </div>
 	</div>
</form>

 <div id="ajax-cart-backdrop" class="js-ajax-backdrop js-toggle-cart backdrop" style="display: none;"></div>
