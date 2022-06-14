{# Products that work as examples #}
<div class="banner-container">
    <div class="top-shadow"></div>
    {{ "img/banner-category.svg" | static_url | img_tag('', {class: 'banner-image'}) }}
    </div>
</div>
<div class="container">
    <div class="title-container row m-top">
        <h2 class="title h1 h5-xs">{{"Productos de ejemplo" | translate}}</h2>
    </div>
    <div class="row text-center-xs">
        <section id="grid" class="js-masonry-grid product-grid m-bottom">  
            <div class="js-masonry-grid"> 
                <div class="row">
                    <!-- Product 01 -->
                    <a href="/product/example" title="{{ product.name }}" data-path-hover="M 180,400 0,400 0,140 180,160 z" class="js-masonry-grid-item item-container"> 
                        <div class="item">
                            <div class="labels-floating">
                                <div class="label label-circle label-secondary">{{ "Oferta" | translate }}</div>
                            </div>
                            <div class="p-relative overflow-none">
                                <div class="item-image-container">
                                    {% include "snipplets/svg/help-product-2.tpl" %}
                                    <div class="item-overlay"></div>
                                </div>
                            	<div class="item-info-container">
                            		<div class="item-info">
                                        <h2 class="item-name">{{ "Producto de ejemplo" | translate }}</h2>
                                        <div class="item-price-container">
                            			    <div class="item-price-compare price-compare">{{"20000" | money }}</div>
                                            <div class="price item-price" id="price_display">{{"30000" | money }}</div>
                                        </div>
                            		</div>
                            	</div>
                            </div>
                        </div>
                    </a>
                    <!-- Product 02 --> 
                    <a href="/product/example" title="{{ product.name }}" data-path-hover="M 180,400 0,400 0,140 180,160 z" class="js-masonry-grid-item item-container"> 
                        <div class="item">
                            <div class="p-relative overflow-none">
                                <div class="item-image-container p-relative">
                                    {% include "snipplets/svg/help-product-4.tpl" %}
                                    <div class="item-overlay"></div>
                                </div>
                                <div class="item-info-container">
                                    <div class="item-info">
                                        <h2 class="item-name">{{ "Producto de ejemplo" | translate }}</h2>
                                        <div class="item-price-container">
                                            <div class="price item-price" id="price_display">{{"80000" | money }}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>
                    <!-- Product 03 --> 
                    <a href="/product/example" title="{{ product.name }}" data-path-hover="M 180,400 0,400 0,140 180,160 z" class="js-masonry-grid-item item-container"> 
                        <div class="item">
                            <div class="labels-floating">
                                <div class="label label-circle label-secondary">{{ "Oferta" | translate }}</div>
                                <div class="label label-circle label-primary label-overlap">{{ "Sin stock" | translate }}</div> 
                            </div>
                            <div class="p-relative overflow-none">
                                <div class="item-image-container p-relative">
                                    {% include "snipplets/svg/help-product-1.tpl" %}
                                    <div class="item-overlay"></div>
                                </div>
                                <div class="item-info-container">
                                    <div class="item-info">
                                        <h2 class="item-name">{{ "Producto de ejemplo" | translate }}</h2>
                                        <div class="item-price-container">
                                            <div class="item-price-compare price-compare">{{"84000" | money }}</div>
                                            <div class="price item-price" id="price_display">{{"67000" | money }}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>
                    <!-- Product 04 --> 
                    <a href="/product/example" title="{{ product.name }}" data-path-hover="M 180,400 0,400 0,140 180,160 z" class="js-masonry-grid-item item-container"> 
                        <div class="item">
                            <div class="labels-floating">
                                <div class="label label-circle label-secondary">{{ "Oferta" | translate }}</div>
                                <div class="label label-circle label-primary label-overlap">{{ "Sin stock" | translate }}</div> 
                            </div>
                            <div class="p-relative overflow-none">
                                <div class="item-image-container">
                                    {% include "snipplets/svg/help-product-2.tpl" %}
                                    <div class="item-overlay"></div>
                                </div>
                                <div class="item-info-container">
                                    <div class="item-info">
                                        <h2 class="item-name">{{ "Producto de ejemplo" | translate }}</h2>
                                        <div class="item-price-container">
                                            <div class="item-price-compare price-compare">{{"90000" | money }}</div>
                                            <div class="price item-price" id="price_display">{{"80000" | money }}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>
                    <!-- Product 05 --> 
                    <a href="/product/example" title="{{ product.name }}" data-path-hover="M 180,400 0,400 0,140 180,160 z" class="js-masonry-grid-item item-container"> 
                        <div class="item">
                            <div class="p-relative overflow-none">
                                <div class="item-image-container">
                                    {% include "snipplets/svg/help-product-8.tpl" %}
                                    <div class="item-overlay"></div>
                                </div>
                                <div class="item-info-container">
                                    <div class="item-info">
                                        <h2 class="item-name">{{ "Producto de ejemplo" | translate }}</h2>
                                        <div class="item-price-container">
                                            <div class="price item-price" id="price_display">{{"80000" | money }}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>
                    <!-- Product 06 --> 
                    <a href="/product/example" title="{{ product.name }}" data-path-hover="M 180,400 0,400 0,140 180,160 z" class="js-masonry-grid-item item-container"> 
                        <div class="item">
                            <div class="p-relative overflow-none">
                                <div class="item-image-container">
                                    {% include "snipplets/svg/help-product-6.tpl" %}
                                    <div class="item-overlay"></div>
                                </div>
                                <div class="item-info-container">
                                    <div class="item-info">
                                        <h2 class="item-name">{{ "Producto de ejemplo" | translate }}</h2>
                                        <div class="item-price-container">
                                            <div class="price item-price" id="price_display">{{"80000" | money }}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>
                    <!-- Product 07 --> 
                    <a href="/product/example" title="{{ product.name }}" data-path-hover="M 180,400 0,400 0,140 180,160 z" class="js-masonry-grid-item item-container"> 
                        <div class="item">
                            <div class="p-relative overflow-none">
                                <div class="item-image-container">
                                    {% include "snipplets/svg/help-product-5.tpl" %}
                                    <div class="item-overlay"></div>
                                </div>
                                <div class="item-info-container">
                                    <div class="item-info">
                                        <h2 class="item-name">{{ "Producto de ejemplo" | translate }}</h2>
                                        <div class="item-price-container">
                                            <div class="price item-price" id="price_display">{{"70000" | money }}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>
                    <!-- Product 08 --> 
                    <a href="/product/example" title="{{ product.name }}" data-path-hover="M 180,400 0,400 0,140 180,160 z" class="js-masonry-grid-item item-container"> 
                        <div class="item">
                            <div class="labels-floating">
                                <div class="label label-circle label-secondary">{{ "Oferta" | translate }}</div> 
                            </div>
                            <div class="p-relative overflow-none">
                                <div class="item-image-container">
                                    {% include "snipplets/svg/help-product-9.tpl" %}
                                    <div class="item-overlay"></div>
                                </div>
                                <div class="item-info-container">
                                    <div class="item-info">
                                        <h2 class="item-name">{{ "Producto de ejemplo" | translate }}</h2>
                                        <div class="item-price-container">
                                            <div class="item-price-compare price-compare">{{"2400" | money }}</div>
                                            <div class="price item-price" id="price_display">{{"3000" | money }}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </section>
    </div>
</div>
