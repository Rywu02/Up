<div class="js-product-variants {% if quickshop %}js-product-quickshop-variants{% endif %} product-variants">
  {# Color and size variants #}
  {% for variation in product.variations if variation.name in ['Color', 'Cor', 'Talle', 'Tamanho', 'Size'] %}
    <div data-variant="{{ variation.name }}" class="variation_{{loop.index}} {% if settings.product_color_variants and variation.name in ['Color', 'Cor'] %}js-color-variant-bullet{% endif %} row-fluid variant-container btn-variant-container">
      <label class="variant-label" for="variation_{{loop.index}}">
        <span>{{variation.name}}: </span>
        <span class="js-insta-variation-label variant-label-property">{{ product.default_options[variation.id] }}</span>
      </label>
      <div class="full-width">
        {% for option in variation.options if option.custom_data %}
          <a data-option="{{ option.id }}" class="js-insta-variations btn-variant{% if not(variation.name in ['Color', 'Cor']) %} btn-variant-custom{% endif %} {{ variation.name }} {% if product.default_options[variation.id] == option.id %}selected{% endif %}">
            <span class="btn-variant-content"{% if variation.name in ['Color', 'Cor'] %} style="background: {{ option.custom_data }}"{% endif %} data-name="{{ option.name }}">
              {% if not(variation.name in ['Color', 'Cor']) %}
                {{ option.name }}
              {% endif %}
            </span>
          </a>
        {% endfor %}
        {% for option in variation.options if not option.custom_data %}
          <a data-option="{{ option.id }}" class="js-insta-variations btn-variant btn-variant-custom {{ variation.name }} {% if product.default_options[variation.id] == option.id %}selected{% endif %}">
            <span class="btn-variant-content" data-name="{{ option.name }}">{{ option.name }}</span>
          </a>
        {% endfor %}
      </div>
    </div>
  {% endfor %}
  {# Custom variants #}
  {% for variation in product.variations %}
    <div class="js-mobile-variations-container {% if variation.name in ['Color', 'Cor', 'Talle', 'Tamanho', 'Size']%} m-none {% endif %}">
      <div class="desktop-product-variation variant-container {% if not(variation.name in ['Color', 'Cor', 'Talle', 'Tamanho', 'Size']) and not quickshop %}hidden-xs{% endif %} {% if product.variations >= 2 %} col-md-4 col-sm-4 {% else %} col-md-6 col-sm-6 {% endif %} col-xs-12" {% if variation.name in ['Color', 'Cor', 'Talle', 'Tamanho', 'Size']%}style="display: none"{% endif %}>
        <label class="variant-label" for="variation_{{loop.index}}">
          {{variation.name}}:
        </label>
        <div class="js-product-variants-group {% if variation.name in ['Color', 'Cor'] %}js-color-variants-container{% endif %} select-container">
          {% if variation.options | length > 1 %}
            <select class="js-variation-option js-refresh-installment-data form-control select" data-variant-id="variation_{{loop.index}}" name="variation[{{ variation.id }}]">
               {% for option in variation.options %}
                   <option value="{{ option.id }}" {% if product.default_options[variation.id] == option.id %}selected="selected"{% endif %}>{{ option.name }}</option>
               {% endfor %}
           </select>
          {% else %}
            <p>{{ variation.options[0].name }}</p>
            <input type="hidden" name="variation[{{ variation.id }}]" value="{{variation.options[0].id}}">
          {% endif %}
        </div>
      </div>
      {% if not(variation.name in ['Color', 'Cor', 'Talle', 'Tamanho', 'Size']) and not quickshop %}
        <div class="js-mobile-vars mobile-vars visible-xs">
          <a href="javascript:void(0)" class="js-mobile-vars-btn btn-module" id="{{variation.name}}" style="{% if variation.name in ['Color', 'Cor', 'Talle', 'Tamanho', 'Size']%}display:none;{% endif %}">
              <p class="text-wrap m-none">{{variation.name}}:</p>
              <span class="js-mobile-vars-selected-label text-primary text-wrap">{{ product.default_options[variation.id] }}</span>
              <div class="btn-module-icon btn-module-icon-right">
                {% include "snipplets/svg/angle-right.tpl" %}
              </div>  
          </a>
          <div class="js-mobile-vars-panel modal-xs modal-xs-right panel-mobile-variant modal-xs-right-out" data-custom="{{variation.name}}" style="{% if quickshop %}top: 60px;{% endif %}{% if variation.name in ['Color', 'Cor', 'Talle', 'Tamanho', 'Size']%}display:none;{% endif %}">
            <div class="modal-xs-dialog">
              <a href="javascript:void(0)" class="js-close-panel modal-xs-header">
                {% include "snipplets/svg/angle-left.tpl" with {fa_custom_class: "svg-inline--fa fa-2x modal-xs-header-icon modal-xs-right-header-icon"} %}
                <span class="modal-xs-header-text modal-xs-right-header-text">{{variation.name}}</span>
              </a>
              <div class="modal-xs-body modal-xs-body-list">
                {% for option in variation.options %}
                  <a href="javascript:void(0)" class="js-mobile-vars-property modal-xs-list-item" data-option="{{ option.id }}">
                    <div class="modal-xs-radio-icon-container">
                      <span class="m-right-half modal-xs-radio-icon">
                        {% include "snipplets/svg/check.tpl" with {fa_custom_class: "svg-inline--fa"} %}
                      </span>
                      </div>
                    <div class="modal-xs-radio-text">
                      {{ option.name }}
                    </div>
                  </a>
                {% endfor %}
              </div>
            </div>
          </div>
        </div>
      {% endif %}
    </div>
  {% endfor %}
</div>
