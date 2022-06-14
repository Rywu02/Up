{# Cookie validation #}

{% if show_cookie_banner and not params.preview %}
    <div class="js-notification js-notification-cookie-banner notification notification-fixed-bottom notification-secondary notification-above p-top-quarter p-bottom-quarter" style="display: none;">
        <div>
            <div class="m-bottom-half p-bottom-quarter text-primary">{{ 'Al navegar por este sitio <strong>aceptás el uso de cookies</strong> para agilizar tu experiencia de compra.' | translate }}</div>
            <div class="m-bottom-half">
                <a href="#" class="js-notification-close js-acknowledge-cookies btn btn-tertiary btn-small weight-strong p-right p-left" data-amplitude-event-name="cookie_banner_acknowledge_click">{{ "Entendido" | translate }}</a>
            </div>
        </div>
    </div>
{% endif %}

{# Quick login notification #}

{% if show_quick_login and not customer and store.country != 'AR' and template == 'home' %}
    <div class="js-notification js-notification-quick-login notification notification-fixed-bottom notification-secondary p-top-quarter p-bottom-quarter" style="display: none;">
        <div>
            <div class="font-small m-bottom-half m-right text-primary">{{ '<strong>¡Comprá más rápido</strong> y seguí tus pedidos!' | translate }}</div>
            <a href="#quick-login" data-toggle="modal" class="js-trigger-modal-zindex-top btn btn-tertiary btn-small btn-smallest m-bottom-quarter">{{ "Iniciá sesión" | translate }}</a>
        </div>
        <a class="js-notification-close js-dismiss-quicklogin pull-right notification-close" href="#">
            {% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa svg-primary-fill fa-lg m-top-quarter m-right-quarter"} %}
        </a>
    </div>
{% endif %}

{# Success notification for quick login (all countries) #}

{% if show_quick_login and customer and just_logged_in %}
    {% set customer_short_name = customer.name|split(' ')|slice(0, 1)|join %} 
    <div class="js-notification js-notification-quick-login js-quick-login-success notification notification-primary notification-centered font-small fade-in-vertical">
        <div class="m-right">
            {% include "snipplets/svg/user-alt.tpl" with {fa_custom_class: "svg-inline--fa svg-primary-fill m-right-quarter fa-lg"} %}
            {{ '<strong>¡Hola, {1}!</strong> Ya podés seguir con tu compra' | translate(customer_short_name) }}
        </div>
        <a class="js-notification-close pull-right notification-close m-top p-top-quarter" href="#">
            {% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa svg-primary-fill fa-lg"} %}
        </a>
    </div>
{% endif %}

{# Order cancellation #}

{% if show_order_cancellation %}
    <div class="js-notification js-notification-order-cancellation notification notification-secondary notification-fixed-bottom" style="display:none;" data-url="{{ status_page_url }}">
        <div class="container">
            <a href="{{ store.contact_url }}?order_cancellation=true"><strong>{{ "Botón de arrepentimiento" | translate }}</strong></a>
            <a class="js-notification-close js-notification-order-cancellation-close pull-right notification-close m-right" href="#">
                {% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa svg-secondary-fill"} %}
            </a>
        </div>
    </div>
{% endif %}

{# Order notification #}

{% if order_notification and status_page_url %}
    <div class="js-notification js-notification-status-page notification notification-secondary" style="display:none;" data-url="{{ status_page_url }}">
        <div class="container">
            <a href="{{ status_page_url }}"><strong>{{ "Seguí acá" | translate }}</strong> {{ "tu última compra" | translate }}</a>
            <a class="js-notification-close js-notification-status-page-close pull-right notification-close m-right" href="#">
                {% include "snipplets/svg/times.tpl" with {fa_custom_class: "svg-inline--fa svg-secondary-fill"} %}
            </a>
        </div>
    </div>
{% endif %}

