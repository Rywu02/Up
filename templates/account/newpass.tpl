<div class="container">
    <div class="title-container" data-store="page-title">
        <h1 class="title">{{ (customer.password ? 'Cambiar Contraseña' : 'Activar cuenta') | translate }}</h1>
    </div>
    <div class="row visible-when-content-ready">
        <form action="" method="post" class="col-sm-6 col-sm-offset-3 m-bottom">
            {% if failure %}
                <div class="alert alert-danger">{{ 'Las contraseñas que escribiste no coinciden. Chequeá que sean iguales entre sí.' | translate }}</div>
            {% endif %}
            <div class="form-group">
                <label for="password">{{ 'Contraseña' | translate }}</label>
                <input class="form-control" type="password" name="password" id="password" autocomplete="off"/>
            </div>
            <div class="form-group">
                <label for="password_confirm">{{ 'Confirmar Contraseña' | translate }}</label>
                <input class="form-control" type="password" name="password_confirm" id="password_confirm" autocomplete="off"/>
            </div>
            <input class="btn btn-secondary full-width-xs m-bottom pull-right" type="submit" value="{{ (customer.password ? 'Cambiar contraseña' : 'Activar cuenta')  | translate }}" />
        </form>
    </div>
</div>