<%@ include file="layout_header.jsp" %>
<h3 class="fw-bold mb-3">Configuracion de Seguridad y Autobloqueo</h3>
<c:if test="${not empty mensaje}"><div class="alert alert-success">${mensaje}</div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

<div class="card card-modern p-4" style="max-width: 650px;">
    <form method="post" action="${pageContext.request.contextPath}/seguridad">
        <h6 class="fw-bold text-primary mb-3">Politica de Autobloqueo en Login</h6>
        <div class="row g-3 mb-4">
            <div class="col-md-6">
                <label class="form-label small">Maximo de intentos fallidos</label>
                <input type="number" name="maxIntentos" class="form-control" min="1" max="10" value="${config.maxIntentosFallidos}" required>
            </div>
            <div class="col-md-6">
                <label class="form-label small">Tiempo de bloqueo (minutos)</label>
                <input type="number" name="minutosBloqueo" class="form-control" min="1" max="1440" value="${config.minutosBloqueo}" required>
            </div>
        </div>

        <h6 class="fw-bold text-primary mb-3">Hardening de Contraseñas</h6>
        <div class="mb-3">
            <label class="form-label small">Longitud minima</label>
            <input type="number" name="minLongitud" class="form-control" min="8" max="32" value="${config.minLongitudPassword}" required>
        </div>
        <div class="form-check mb-2"><input class="form-check-input" type="checkbox" name="reqUpper" ${config.requiereMayuscula ? 'checked' : ''}><label class="form-check-label small">Requerir Mayuscula (A-Z)</label></div>
        <div class="form-check mb-2"><input class="form-check-input" type="checkbox" name="reqLower" ${config.requiereMinuscula ? 'checked' : ''}><label class="form-check-label small">Requerir Minuscula (a-z)</label></div>
        <div class="form-check mb-2"><input class="form-check-input" type="checkbox" name="reqDigit" ${config.requiereNumero ? 'checked' : ''}><label class="form-check-label small">Requerir Numero (0-9)</label></div>
        <div class="form-check mb-4"><input class="form-check-input" type="checkbox" name="reqSpecial" ${config.requiereEspecial ? 'checked' : ''}><label class="form-check-label small">Requerir Caracter Especial (!@#$%)</label></div>

        <button class="btn btn-primary px-4">Guardar Politicas</button>
    </form>
</div>
<%@ include file="layout_footer.jsp" %>
