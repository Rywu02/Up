{% if thumb %}
	{% set svg_size = 'fa-lg' %}
{% else %}
	{% set svg_size = 'fa-2x' %}
{% endif %}

<div class="{% if not thumb %}js-video {% if product_video %}js-video-product{% endif %}{% endif %} video-container embed-responsive embed-responsive-16by9 {% if template == 'product' %}product-video m-none{% endif %} visible-when-content-ready">
	{% if thumb %}
		<div class="player-container">
	{% else %}
		{% if product_video %}

            {# Open modal on mobile with product video inside #}

            <a href="#modal-product-video" data-toggle="modal" data-modal-url="#modal-fullscreen-video" class="js-play-button js-fullscreen-modal-open player-container visible-xs">
                <div class="btn btn-primary {% if thumb %}btn-small{% endif %}">{% include "snipplets/svg/play.tpl" with {fa_custom_class: "svg-inline--fa play-icon " ~ svg_size ~ ""} %}</div>
            </a>
        {% endif %}
		<a href="#" class="js-play-button player-container {% if product_video %}hidden-xs{% endif %}">
	{% endif %}
			<div class="btn btn-primary {% if thumb %}btn-small{% endif %}">
				{% include "snipplets/svg/play.tpl" with {fa_custom_class: "svg-inline--fa play-icon " ~ svg_size ~ ""} %}
			</div>
	{% if thumb %}
		</div>
	{% else %}
		</a>
	{% endif %}
	<div class="js-video-image">
		<img src="{{ 'img/empty-placeholder.png' | static_url }}" data-src="" class="lazyload video-image fade-in" alt="{{ 'Video de' | translate }} {% if template != 'product' %}{{ product.name }}{% else %}{{ store.name }}{% endif %}" style="display: none;">
		<div class="placeholder-fade">
		</div>
	</div>
</div>

{% if not thumb %}
	
	{# Empty iframe component: will be filled with JS on play button click #}

	<div class="js-video-iframe embed-responsive embed-responsive-16by9" style="display: none;" data-video-color="{{ settings.primary_color | trim('#') }}">
	</div>
{% endif %}