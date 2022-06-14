{# Only remove this if you want to take away the theme onboarding advices #}
{# Products that work as examples #}
<div class="container">
    <div class="title-container row m-top">
        <h2 class="title h1 h5-xs">{{"Productos de ejemplo" | translate}}</h2>
    </div>
	<div class="row">
		<section id="grid" class="grid clearfix"> 
			<div class="js-masonry-grid"> 
				<div class="row">
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
                                <div class="item-image-container">
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
                                <div class="item-image-container">
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
                                <div class="label label-circle label-secondary">{{ "Sin stock" | translate }}</div> 
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
                                            <div class="price item-price" id="price_display">{{"80000" | money }}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </a>
				</div>
		</section>
	</div>
</div>
