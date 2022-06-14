{% set num_modules = 0 %}
{% for module in ['module_01', 'module_02'] %}
    {% set module_show = attribute(settings,"#{module}_show") %}
    {% set module_image = "#{module}.jpg" | has_custom_image %}
    {% set module_title = attribute(settings,"#{module}_title") %}
    {% set module_text = attribute(settings,"#{module}_text") %}
    {% set module_button_text = attribute(settings,"#{module}_button") %}
    {% set has_module =  module_show and (module_title or module_text or module_image) %}
    {% if has_module %}
        {% set num_modules = num_modules + 1 %}
    {% endif %}
{% endfor %}

{% if num_modules > 0 %}
    <div class="module-wrapper">
{% endif %}
{% for module in ['module_01', 'module_02'] %}
    {% set module_show = attribute(settings,"#{module}_show") %}
    {% set module_image = "#{module}.jpg" | has_custom_image %}
    {% set module_title = attribute(settings,"#{module}_title") %}
    {% set module_text = attribute(settings,"#{module}_text") %}
    {% set module_button_text = attribute(settings,"#{module}_button") %}
    {% set module_url = attribute(settings,"#{module}_url") %}
    {% set module_align = attribute(settings,"#{module}_align") %}
    {% set has_module =  module_show and (module_title or module_text or module_image) %}
    {% set has_module_text =  module_title or module_text or (module_url and module_button_text) %}
    {% if has_module %}
        <div class="row">
            <div class="col-sm-12">
                <div class="module-image">
                    {% if module_image %}
                        <img class="textbanner-image-background lazyautosizes lazyload fade-in" src="{{ 'img/empty-placeholder.png' | static_url }}" data-srcset='{{ "#{module}.jpg" | static_url | settings_image_url('large') }} 480w, {{ "#{module}.jpg" | static_url | settings_image_url('huge') }} 640w, {{ "#{module}.jpg" | static_url | settings_image_url('original') }} 1024w, {{ "#{module}.jpg" | static_url | settings_image_url('1080p') }} 1920w' data-sizes="auto" {% if module_title %}alt="{{ module_title }}"{% else %} alt="{{ 'Módulo de' | translate }} {{ store.name }}"{% endif %}/>
                        <div class="placeholder-overlay placeholder-container">
                        </div>
                    {% endif %}
                    {% if module_url %}
                        <a href="{{ module_url | setting_url }}"{% if module_title %} alt="{{ module_title }}" title="{{ module_title }}"{% endif %}>
                    {% endif %}
                    {% if has_module_text %}
                        <div class="module-text{% if module_align == 'left' %} pull-left{% elseif module_align == 'center' %} module-center pull-left{% elseif module_align == 'right' %} pull-right{% endif %}">
                            {% if module_title %}
                                <h3 class="module-text-title">{{ module_title }}</h3>
                            {% endif %}
                            {% if module_text %}
                                <div class="module-text-paragraph">{{ module_text }}</div>
                            {% endif %}
                            {% if module_url and module_button_text %}
                                <div class="module-text-button btn btn-primary">{{ module_button_text }}</div>
                            {% endif %}
                        </div>
                    {% endif %}
                    {% if module_url %}
                        </a>
                    {% endif %}
                </div>
            </div>
        </div>
    {% endif %}
{% endfor %}
{% if num_modules > 0 %}
    </div>{#  **** This close the module-wrapper ****  #}
    <div class="shape-container">
        <div class="background-shape"></div>
    </div>
{% endif %}