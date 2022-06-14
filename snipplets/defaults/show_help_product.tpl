{# Single product that works as an example #}
<div class="container m-top">
    <div class="row">
        <div class="col-xs-12 col-md-6 product-img-col visible-when-content-ready">
            <div class="row">
                <div class="desktop-featured-product">
                    <div class="p-relative">
                        <div class="current-photo-container">
                            <div class="labels-floating">
                                <div class="label label-circle label-secondary">{{ settings.offer_text }}</div>
                            </div> 
                            <a href="{{ "img/help-product-2.svg" | static_url }}" id="zoom" class="cloud-zoom pull-left full-width" rel="position: 'inside', showTitle: false, loading: '{{ 'Cargando...' | translate }}'">
                                {% include "snipplets/svg/help-product-2.tpl" %}
                            </a> 
                        </div>
                    </div>
                </div>
            </div>
            <div class="row hidden-xs m-top"> 
                <div class="thumbs visible-when-content-ready">   
                    <a id="red" href="{{ "img/help-product-44.svg" | static_url }}" class="cloud-zoom-gallery thumb-link col-md-4 p-none" rel="useZoom: 'zoom', smallImage: '{{ "images/help-product-44.svg" | static_url }}' ">
                        <span>
                        {% include "snipplets/svg/help-product-2-green.tpl" %}
                        </span>
                    </a> 
                    <a id="red" href="{{ "img/help-product-45.svg" | static_url }}" class="cloud-zoom-gallery thumb-link col-md-4 p-none" rel="useZoom: 'zoom', smallImage: '{{ "images/help-product-45.svg" | static_url }}' ">
                        <span>
                        {% include "snipplets/svg/help-product-2-red.tpl" %}
                        </span>
                    </a> 
                </div> 
            </div>
        </div>
        <div class="col-xs-12 col-md-6 product-form-container">
            <h1 class="product-name">{{ "Producto de ejemplo" | translate }}</h1>
            <div class="product-price-container">
                <h4 id="compare_price_display" class="product-price-compare price-compare m-bottom-quarter-xs">{{ "1200.50" | money }}</h4>
                <h2 class="h1 product-price js-price-display d-inline" id="price_display">{{ "1890.00" | money }}</h2>
            </div>
            <div class="row-fluid m-bottom">
                <h5>{{ "En hasta 12 cuotas con tarjeta de crédito" | translate }}</h5>
            </div>
            <form id="product_form" method="post" action="">
                <div class="product-variants">
                    <input type="hidden" name="add_to_cart" value="2243561">
                        <div class="desktop-product-variation variant-container col-md-4 col-sm-4 col-xs-12">
                            <label class="variant-label" for="variation_1">{{ "Talle" | translate }}</label>
                            <div class="select-container">
                                <select id="variation_1" class="form-control select" name="variation[0]">
                                    <option value="s" selected="selected">{{ "S" | translate }}</option>
                                    <option value="m">{{ "M" | translate }}</option>
                                    <option value="l">{{ "L" | translate }}</option>
                                    <option value="xl">{{ "XL" | translate }}</option>
                                </select> 
                            </div>
                        </div>
                        <div class="desktop-product-variation variant-container col-md-4 col-sm-4 col-xs-12"> 
                            <label class="variant-label" for="color_variant">{{ "Color" | translate }}</label>
                            <div class="select-container">
                                <select id="color_variant" class="form-control select" name="color_variant">
                                    <option value="blue" selected="selected">{{ "Azul" | translate }}</option>
                                    <option value="green">{{ "Verde" | translate }}</option>
                                    <option value="red">{{ "Rojo" | translate }}</option>
                                </select> 
                            </div>
                        </div>
                        <div class="desktop-product-variation variant-container col-md-4 col-sm-4 col-xs-12"> 
                            <label class="variant-label" for="variation_3">{{ "Material" | translate }}</label>
                            <div class="select-container">
                                <select id="variation_3" class="form-control select" name="variation[2]">
                                    <option value="Resorte" selected="selected">{{ "Denim" | translate }}</option>
                                    <option value="Ganchito">{{ "Algodón" | translate }}</option>
                                </select> 
                            </div>
                        </div>
                    </div>
                {% if store.country == 'BR' %}
                <div id="shipping-calculator" class="shipping-calculator row text-center m-bottom">
                    <div class="col-md-12"> 
                        <div id="shipping-calculator-form-example" class="shipping-calculator-form cart-detail-shipping"> 
                            <h4 class="shipping-calculator_label {% if template != 'cart' %} full-width m-none p-top-half p-bottom-half{% endif %} p-top-half-xs m-none-xs text-left"> {{ "Calculá el costo de tu envío" | translate }}:</h4>
                            <input type="text" name="zipcode" value="{{ cart.shipping_zipcode }}"  class="form-control m-top-half-xs m-none" >
                            <button class="btn btn-secondary btn-append btn-small calculate-shipping-button m-bottom-half m-top-half-xs">{{ "Calcular costo de envío" | translate }}</button>
                            <p class="loading" style="display:none;">
                                {% include "snipplets/svg/circle-notch.tpl" with {fa_custom_class: "svg-inline--fa fa-spin"} %}
                            </p>
                            <p id="invalid-zipcode" style="display:none;">{{ "El código postal es inválido." | translate }}</p>
                        </div>
                    </div>
                </div>
                {% endif %}
                <input type="submit" href="#" class="btn btn-primary btn-block m-bottom m-top d-inline-block" value="{{ "Agregar al carrito" | translate }}" disabled>
            </form> 
        </div>
        <div class="col-xs-12 user-content">
            <p>{{ "¡Este es un producto de ejemplo! Para poder probar el proceso de compra, debes" | translate }}
                <a href="/admin/products" target="_top">{{ "agregar tus propios productos." | translate }}</a>
            </p>
        </div>  
    </div>
</div>
{% if show_help %}
    <script type="text/javascript">
        LS.ready.then(function(){
            $(document).ready(function(){
                var $shipping_calculator = $("#shipping-calculator");
                var $invalid_zipcode = $("#invalid-zipcode");
                var $shipping_calculator_loading = $shipping_calculator.find(".loading")
                $("#calculate-shipping-button-example").click(function() {
                    $invalid_zipcode.hide(1);
                    $shipping_calculator_loading.show( 1 ).delay( 1800 ).hide(1);
                    event.preventDefault(); // cancel default behavior
                    if( $("#shipping-zipcode").val().length === 8 || $("#shipping-zipcode").val().length === 9 ) {
                        $("#shipping-calculator-form-example, #shipping-calculator-response-example").toggle();
                    } else {
                        $("#invalid-zipcode").delay( 1800 ).show(1);
                    }
                });
                $('#color_variant').change(function(){
                    var $values_color = $( "select#color_variant option:selected" ).val();
                    $('#' + $values_color).click();
                    if ( $values_color == 'green'){
                        $(".price02").show();
                        $(".price01").hide();
                    } else {
                        $(".price02").hide();
                        $(".price01").show();
                    }
                });
            });
        });
    </script>
{% endif %}
