{# Single snipplet that works as social example #}
<div id="wrapper-social" class="show-help-social">
    <div class="row-fluid">
        <div class="container">
            <a class="soc-foot facebook" href="#">
            	{% include "snipplets/svg/facebook.tpl" with {fa_custom_class: "svg-inline--fa fa-4x"} %}
            </a>
            <a class="soc-foot twitter" href="#">
            	{% include "snipplets/svg/twitter.tpl" with {fa_custom_class: "svg-inline--fa fa-4x"} %}
            </a>
            <a class="soc-foot pinterest" href="#">
            	{% include "snipplets/svg/pinterest.tpl" with {fa_custom_class: "svg-inline--fa fa-4x"} %}
            </a>
            </a>
            <a class="soc-foot instagram" href="#">
            	{% include "snipplets/svg/instagram.tpl" with {fa_custom_class: "svg-inline--fa fa-4x"} %}
            </a>
        </div>
    </div>
</div>