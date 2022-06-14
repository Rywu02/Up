{# Mobile services banners slider placeholder: to be hidden after content loaded #}
{% if loop.first %}
    <div class="js-services-placeholder mobile-placeholder p-relative">
        <div class="services full-width">
            <div class="service-item-container col-xs-12">
                <div class="service-item">
                    <span class="placeholder-circle-small placeholder-color d-inline-block opacity-50">
                        <div class="placeholder-shine"></div>
                    </span>
                    <h5 class="service-title">{{ banner_services_title }}</h5>
                    <p class="service-text">{{ banner_services_description }}</p>
                </div>
            </div>
        </div>
    </div>
{% endif %}

