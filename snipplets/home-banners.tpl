<div class="container banner-wrapper" data-store="banner-home-categories">
    <div class="row">
        {% set num_banners = 0 %}
        {% set first_banner = true %}
        {% for banner in ['banner_01', 'banner_02', 'banner_03'] %}
            {% set banner_show = attribute(settings,"#{banner}_show") %}
            {% set banner_image = "#{banner}.jpg" | has_custom_image %}
            {% set banner_title = attribute(settings,"#{banner}_title") %}
            {% set banner_button_text = attribute(settings,"#{banner}_button") %}
            {% set has_banner =  banner_show and (banner_title or banner_description or "#{banner}.jpg" | has_custom_image) %}
            {% if has_banner %}
                {% set num_banners = num_banners + 1 %}
            {% endif %}
        {% endfor %}

        {% for banner in ['banner_01', 'banner_02', 'banner_03'] %}
            {% set banner_show = attribute(settings,"#{banner}_show") %}
            {% set banner_image = "#{banner}.jpg" | has_custom_image %}
            {% set banner_title = attribute(settings,"#{banner}_title") %}
            {% set banner_description = attribute(settings,"#{banner}_description") %}
            {% set banner_button_text = attribute(settings,"#{banner}_button") %}
            {% set banner_url = attribute(settings,"#{banner}_url") %}
            {% set has_banner =  banner_show and (banner_title or banner_description or "#{banner}.jpg" | has_custom_image) %}
            {% set has_banner_text =  banner_title or banner_description or (banner_button_text and banner_url) %}
            {% if has_banner %}
                <div class="col-sm-{% if num_banners == 1 %}6 col-sm-offset-3{% elseif num_banners == 2 %}6{% elseif num_banners == 3 %}4{% endif %}">
                    <div class="textbanner">
                        {% if banner_url %}
                            <a class="textbanner-link" href="{{ banner_url | setting_url }}"{% if banner_title %} alt="{{ banner_title }}" title="{{ banner_title }}"{% endif %}>
                        {% endif %}
                        {% if banner_image %}
                            <div class="textbanner-image">
                                <img class="textbanner-image-background lazyautosizes lazyload blur-up-huge" src="{{ "#{banner}.jpg" | static_url | settings_image_url('tiny') }}" data-srcset="{{ "#{banner}.jpg" | static_url | settings_image_url('large') }} 480w, {{ "#{banner}.jpg" | static_url | settings_image_url('huge') }} 640w" data-sizes="auto" data-expand="-10" {% if banner_title %}alt="{{ banner_title }}"{% else %}alt="{{ 'Banner de' | translate }} {{ store.name }}"{% endif %} />
                            </div>
                        {% else %}
                            <div class="textbanner-image">
                                {% include "snipplets/svg/image.tpl" with {fa_custom_class: "svg-inline--fa fa-4x placeholder-icon"} %}
                            </div>
                        {% endif %}
                        {% if has_banner_text %}
                            <div class="textbanner-text">
                                <div class="textbanner-shape"></div>
                                {% if banner_title %}
                                    <h3 class="textbanner-title">{{ banner_title }}</h3>
                                {% endif %}
                                {% if banner_description %}
                                    <div class="textbanner-paragraph">{{ banner_description }}</div>
                                {% endif %}
                                {% if banner_url and banner_button_text %}
                                    <div class="textbanner-button btn btn-primary">{{ banner_button_text }}</div>
                                {% endif %}
                            </div>
                        {% endif %}
                        {% if banner_url %}
                            </a>
                        {% endif %}
                    </div>
                </div>
            {% set first_banner = false %}
            {% endif %}
        {% endfor %}
    </div>
</div>