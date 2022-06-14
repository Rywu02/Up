{% for banner in ['product_informative_banner_01', 'product_informative_banner_02', 'product_informative_banner_03'] %}
    {% set product_banner_show = attribute(settings,"#{banner}_show") %}
    {% set product_informative_banner_icon = attribute(settings,"#{banner}_icon") %}
    {% set product_informative_banner_title = attribute(settings,"#{banner}_title") %}
    {% set product_informative_banner_description = attribute(settings,"#{banner}_description") %}
    {% set product_informative_banner_url = attribute(settings,"#{banner}_url") %}
    {% set product_informative_banner_link_text = attribute(settings,"#{banner}_link_text") %}
    {% set has_product_informative_banner =  product_banner_show and (product_informative_banner_title or product_informative_banner_description) %}
    {% if has_product_informative_banner %} 
        <div class="container-fluid p-bottom-half m-bottom {% if loop.first and store.branches %}m-top{% endif %}">
            <div class="row">
                <div class="m-bottom-half">
                    {% if product_informative_banner_icon != 'none' %}
                        <span class="d-flex pull-left">
                            {% if product_informative_banner_icon == 'security' %}
                                {% include "snipplets/svg/lock.tpl" with {fa_custom_class: "svg-inline--fa fa-lg svg-primary-fill"} %}
                            {% elseif product_informative_banner_icon == 'returns' %}
                                {% include "snipplets/svg/refresh.tpl" with {fa_custom_class: "svg-inline--fa fa-lg svg-primary-fill"} %}
                            {% elseif product_informative_banner_icon == 'delivery' %}
                                {% include "snipplets/svg/delivery.tpl" with {fa_custom_class: "svg-inline--fa fa-lg svg-primary-fill"} %}
                            {% elseif product_informative_banner_icon == 'whatsapp' %}
                                {% include "snipplets/svg/whatsapp-solid.tpl" with {fa_custom_class: "svg-inline--fa fa-lg svg-primary-fill"} %}
                            {% elseif product_informative_banner_icon == 'cash' %}
                                {% include "snipplets/svg/dollar.tpl" with {fa_custom_class: "svg-inline--fa fa-lg fa-w-15 svg-primary-fill"}   %}
                            {% endif %}
                        </span>
                    {% endif %}
                    {% if product_informative_banner_title %}
                        <span {% if product_informative_banner_icon != 'none' %}class="p-left-half d-flex"{% endif %}>{{ product_informative_banner_title }}</span>
                    {% endif %}
                </div>
                {% if product_informative_banner_description %}
                    <div class="box-container m-none">{{ product_informative_banner_description }}</div>
                {% endif %}
            </div>
        </div>
    {% endif %}
{% endfor %} 