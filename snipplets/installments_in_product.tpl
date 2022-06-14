{% set product_can_show_installments = product.show_installments and product.display_price and product.get_max_installments.installment > 1 %}
{% if product_can_show_installments %}
    <div class="js-max-installments-container installments m-bottom-quarter">
        {% include "snipplets/svg/credit-card.tpl" with {fa_custom_class: "payment-credit-card m-right-quarter svg-primary-fill"} %}
        {% set max_installments_without_interests = product.get_max_installments(false) %}
        {% if max_installments_without_interests and max_installments_without_interests.installment > 1 %}
                <div class="js-max-installments installments d-inline-block">{{ "<strong class='js-installment-amount installment-amount'>{1}</strong> cuotas sin interés de <strong class='js-installment-price installment-price'>{2}</strong>" | t(max_installments_without_interests.installment, max_installments_without_interests.installment_data.installment_value_cents | money) }}</div>
        {% else %}
            {% set max_installments_with_interests = product.get_max_installments %}
            {% if max_installments_with_interests %}
                <div class="js-max-installments installments d-inline-block">{{ "<strong class='js-installment-amount installment-amount'>{1}</strong> cuotas de <strong class='js-installment-price installment-price'>{2}</strong>" | t(max_installments_with_interests.installment, max_installments_with_interests.installment_data.installment_value_cents | money) }}</div>
            {% else %}
                <div class="js-max-installments installments d-inline-block" style="display: none;">
                {% if product.max_installments_without_interests %}
                    {{ "<strong class='js-installment-amount installment-amount'>{1}</strong> cuotas sin interés de <strong class='js-installment-price installment-price'>{2}</strong>" | t(null, null) }}
                {% else %}
                    {{ "<strong class='js-installment-amount installment-amount'>{1}</strong> cuotas de <strong class='js-installment-price installment-price'>{2}</strong>" | t(null, null) }}
                {% endif %}
                </div>
            {% endif %}
        {% endif %}
    </div>
{% endif %}
