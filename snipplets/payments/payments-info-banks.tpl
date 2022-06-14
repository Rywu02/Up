{% set gateways = installmentsv2['methods'][method] %}

{# Gateways with banks #}

{# Credit cards #}
{% if gateways.cc is not null %}
  <div class="box-title">{{'Tarjetas de crédito' | translate }}</div>
  <div class="box-container">
      <div class="pull-left full-width border-box">

        {# Installments without interest modules by groups, E.g: 3, 6, 9, 12 #}

        {% if gateways.cc is null or gateways.cc is empty is not null %}
          {% for installment, banks in gateways.cc.no_interest %}
            <div class="installments-container">

              {# Installment amount, cost, CFT, 1 payment info and total cost #}

              <h4 class="h5-xs m-top-none m-bottom-quarter">
                {{ installment }}
                {{ 'cuotas' | translate }}
                <span class="text-primary">{{ 'sin interés' | t }}</span>
                {{'de' | t}}
                <span class="js-modal-installment-price text-primary weight-strong" data-installment="{{installment}}"> {{ (product.price / installment) | money }}</span>
              </h4>
              <div class="legal-info p-bottom-half">
                <span class="m-right-quarter">
                  <span>{{ 'CFT: ' | translate }}</span><span class="weight-strong">0,00%</span>
                </span>
                <span class="m-right-quarter">
                  <span>{{ 'Total: ' | translate }}</span><span class="js-installments-one-payment weight-strong">{{ product.price | money }}</span>
                </span>
                <span class="m-right-quarter">
                  <span>{{ 'En 1 pago: ' | translate }}</span><span class="js-installments-one-payment weight-strong">{{ product.price | money }}</span>
                </span>
              </div>

              {# Banks with installments without interest flags #}

              <div class="flags-container">
                {% for bank in banks %}
                  <span class="installments-card">
                    <img src="{{ 'img/empty-placeholder.png' | static_url }}" data-src="{{ bank | bank_code_by_name | payment_new_logo }}" class="lazyload card-img card-img-big" alt="{{ bank }}">
                  </span>
                {% endfor %}
              </div>
              <div class="divider"></div>
            </div>
          {% endfor %}
        {% endif %}

        {# Installments with interest in one module #}

        {% if gateways.cc.interest is not null %}
          <div class="installments-container">

            {# Installment amount #}

            <h4 class="h5-xs m-top-none m-bottom-quarter">
              {{ gateways.max_with_interests ~ ' cuotas con otras tarjetas' | translate }}
            </h4>
            <div class="legal-info p-bottom-half">
              <span>{{ 'O en 1 pago de: ' | translate }}</span>
              <span class="js-installments-one-payment weight-strong text-primary">{{ product.price | money }}</span>
            </div>

            {# Banks with installments with interest flags #}

            {% for bank in gateways.cc.interest %}
              <span class="installments-card js-installments-flag-tab js-installments-cash-tab">
                <img src="{{ 'img/empty-placeholder.png' | static_url }}" data-src="{{ bank | bank_code_by_name | payment_new_logo }}" class="lazyload card-img card-img-big" alt="{{ bank }}">
              </span>
            {% endfor %}
          </div>
        {% endif %}
      </div>
  </div>
{% endif %}

{# Cash methods #}

{% if gateways.debit is not null or gateways.cash is not null or gateways.transfer is not null %}
  <div class="box-title">{{'Tarjeta de débito y efectivo' | translate }}</div>
  <div class="box-container">

    {# Debit card #}

    {% if gateways.debit is not null %}

      {# Debit price #}

      <h4 class="h5-xs m-top-none m-bottom-quarter">{{ 'Débito' | translate }}</h4>
      <div class="h6-xs m-bottom-half">
        <span>{{ 'Precio:' | translate }} </span><span class="js-installments-one-payment weight-strong text-primary"> {{ product.price | money }}</span>
      </div>

      {# Debit flags #}

      {% for logo in gateways.debit %}
        <span class="installments-card" data-type="dd" data-code="{{ card }}">
          <img src="{{ 'img/empty-placeholder.png' | static_url }}" data-src="{{ logo | payment_new_logo }}" class="lazyload card-img card-img-big">
        </span>
      {% endfor %}

      <div class="divider"></div>

    {% endif %}

    {# Cash #}

    {% if gateways.cash is not null %}

      {# Cash price #}

      <h4 class="h5-xs m-top-none m-bottom-quarter">{{'Efectivo' | translate }}</h4>
      <div class="h6-xs m-bottom-half">
        <span>{{ 'Precio:' | translate }} </span><span class="js-installments-one-payment weight-strong text-primary"> {{ product.price | money }}</span>
      </div>

      {# Cash flags #}

      {% for logo in gateways.cash %}
        <span class="installments-card" data-type="dd" data-code="{{ card }}">
          <img src="{{ 'img/empty-placeholder.png' | static_url }}" data-src="{{ logo | payment_new_logo }}" class="lazyload card-img card-img-big">
        </span>
      {% endfor %}

      <div class="divider"></div>

    {% endif %}

    {# Wire transfer #}

    {% if gateways.transfer is not null %}

      {# Transfer price #}

      <h4 class="h5-xs m-top-none m-bottom-quarter">{{ 'Transferencia o déposito' | translate }}</h4>
      <div class="h6-xs m-bottom-half">
        <span>{{ 'Precio:' | translate }} </span><span class="js-installments-one-payment weight-strong text-primary"> {{ product.price | money }}</span>
      </div>

      {# Transfer logos #}

      {% for logo in gateways.transfer %}
        <span class="installments-card js-installments-flag-tab js-installments-cash-tab" data-type="dd" data-code="{{ card }}">
          <img src="{{ 'img/empty-placeholder.png' | static_url }}" data-src="{{ logo | payment_new_logo }}" class="lazyload card-img card-img-big">
        </span>
      {% endfor %}
    {% endif %}
  </div>
{% endif %}
