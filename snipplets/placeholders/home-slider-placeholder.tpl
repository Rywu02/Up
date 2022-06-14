{# Mobile home slider placeholder: to be hidden after content loaded #}
{% if settings.slider and settings.slider is not empty %}
    <div class="js-home-slider-placeholder mobile-placeholder placeholder-container">
        <div class="placeholder-figures-container">
            <div class="placeholder-left-col pull-left">
                <div class="placeholder-circle placeholder-color">
                </div>
            </div>
            <div class="placeholder-right-col pull-left">
                <div class="row">
                    <div class="placeholder-line col-xs-12 placeholder-color">
                    </div>
                    <div class="placeholder-line col-xs-8 placeholder-color m-top-half">
                    </div>
                    <div class="placeholder-line col-xs-10 placeholder-color m-top-half">
                    </div>
                </div>
            </div>
            <div class="placeholder-shine">
            </div>
        </div>
    </div>
    <div class="js-home-slider-placeholder">
        <div class="bx-pager visible-phone">
            {% for slide in settings.slider %}
                <span class="bx-pager-item"><a href="#" {% if loop.first %}class="active" {% endif %}></a></span>
            {% endfor %}
        </div>
    </div>
    <div class="js-slider-desktop-placeholder slider-desktop-placeholder">
    </div>
{% endif %}