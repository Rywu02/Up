<section class="pills-container home-categories horizontal-container pills-container container-fluid{% if not settings.home_main_categories %} visible-xs{% endif %}">
	<h4 class="text-center hidden-xs ">{{ "Categorías principales" | translate }}</h4>
	<ul class="list-inline p-none m-none text-center text-left-xs">
		{% for category in categories %}
			<li data-item="{{ loop.index }}" class="pill {% if loop.first %} m-left-half {% endif %} {% if loop.last %} p-right-half {% endif %}">
            	<a class="pill-link" href="{{ category.url }}" title="{{ category.name }}">{{ category.name }}</a>
            </li>
		{% endfor %}
	</ul>
</section>
