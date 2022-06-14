<div class="module-wrapper-promotional">
    <div class="row">
        {% set num_banners = 0 %}
        {% for banner in ['banner_promotional_01', 'banner_promotional_02', 'banner_promotional_03'] %}
            {% set banner_show = attribute(settings,"#{banner}_show") %}
            {% set banner_image = "#{banner}.jpg" | has_custom_image %}
            {% set banner_title = attribute(settings,"#{banner}_title") %}
            {% set banner_button_text = attribute(settings,"#{banner}_button") %}
            {% set has_banner =  banner_show and (banner_title or banner_description or "#{banner}.jpg" | has_custom_image) %}
            {% if has_banner %}
                {% set num_banners = num_banners + 1 %}
            {% endif %}
        {% endfor %}

        {% for banner in ['banner_promotional_01', 'banner_promotional_02', 'banner_promotional_03'] %}
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
                    <div class="module-image module-image-promotional">
                        {% if banner_image %}
                            <img class="textbanner-image-background lazyautosizes lazyload fade-in" src="{{ 'img/empty-placeholder.png' | static_url }}" data-srcset="{{ "#{banner}.jpg" | static_url | settings_image_url('large') }} 480w, {{ "#{banner}.jpg" | static_url | settings_image_url('huge') }} 640w" data-sizes="auto" data-expand="-10" {% if banner_title %}alt="{{ banner_title }}"{% else %}alt="{{ 'Banner de' | translate }} {{ store.name }}"{% endif %} />
                        {% endif %}
                        {% if banner_url %}
                            <a class="module-link" href="{{ banner_url | setting_url }}"{% if banner_title %} alt="{{ banner_title }}" title="{{ banner_title }}"{% endif %}>
                        {% endif %}
                        {% if has_banner_text %}
                            <div class="module-text module-text-promotional">
                                {% if banner_title %}
                                    <h3 class="module-text-title">{{ banner_title }}</h3>
                                {% endif %}
                                {% if banner_description %}
                                    <div class="module-text-paragraph">{{ banner_description }}</div>
                                {% endif %}
                                {% if banner_url and banner_button_text %}
                                    <div class="module-text-button btn btn-primary">{{ banner_button_text }}</div>
                                {% endif %}
                            </div>
                        {% endif %}
                        {% if banner_url %}
                            </a>
                        {% endif %}
                    </div>
                </div>
            {% endif %}
        {% endfor %}
    </div>
</div>