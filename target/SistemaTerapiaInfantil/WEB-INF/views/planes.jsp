<%@ include file="layout_header.jsp" %>
<h3 class="fw-bold mb-3">Planes y Precios Mensuales</h3>
<c:if test="${not empty mensaje}"><div class="alert alert-success">${mensaje}</div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

<div class="row g-4">
    <div class="col-md-4">
        <div class="card card-modern p-4">
            <h5 class="fw-bold mb-3">Nuevo Plan</h5>
            <form method="post" action="${pageContext.request.contextPath}/planes">
                <input type="hidden" name="accion" value="crear">
                <div class="mb-2"><label class="form-label small">Nombre del Plan</label><input type="text" name="nombre" class="form-control" placeholder="Ej. Plan Intensivo 12 Sesiones" required></div>
                <div class="mb-2"><label class="form-label small">Sesiones por Mes</label><input type="number" name="sesionesMes" class="form-control" min="1" required></div>
                <div class="mb-2"><label class="form-label small">Precio (Lempiras L.)</label><input type="number" step="0.01" name="precioLempiras" class="form-control" min="0" required></div>
                <div class="mb-3"><label class="form-label small">Descripcion</label><textarea name="descripcion" class="form-control" rows="2"></textarea></div>
                <button class="btn btn-primary w-100">Crear Plan</button>
            </form>
        </div>
    </div>
    <div class="col-md-8">
        <div class="card card-modern p-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="fw-bold mb-0">Planes Registrados</h5>
                <small class="text-muted"><i class="bi bi-info-circle"></i> Los planes no se eliminan para conservar el historial.</small>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle small">
                    <thead class="table-light">
                        <tr><th>Plan</th><th>Sesiones/Mes</th><th>Precio</th><th>Estado</th><th>Accion</th></tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${planes}">
                            <tr class="${p.activo ? '' : 'table-secondary text-muted'}">
                                <td>
                                    <div class="fw-semibold">${p.nombre}</div>
                                    <small class="text-muted">${p.descripcion}</small>
                                </td>
                                <td><span class="badge bg-info text-dark">${p.sesionesMes} sesiones</span></td>
                                <td class="fw-bold text-success">L. ${p.precioLempiras}</td>
                                <td>
                                    <span class="badge ${p.activo ? 'bg-success' : 'bg-secondary'}">
                                        ${p.activo ? 'Activo' : 'Inactivo'}
                                    </span>
                                </td>
                                <td>
                                    <form method="post" action="${pageContext.request.contextPath}/planes" class="d-inline">
                                        <input type="hidden" name="accion" value="toggleEstado">
                                        <input type="hidden" name="idPlan" value="${p.idPlan}">
                                        <input type="hidden" name="nuevoEstado" value="${!p.activo}">
                                        <button type="submit" class="btn btn-sm ${p.activo ? 'btn-outline-warning' : 'btn-outline-success'}">
                                            <i class="bi ${p.activo ? 'bi-pause-circle' : 'bi-check-circle'}"></i>
                                            ${p.activo ? 'Desactivar' : 'Activar'}
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@ include file="layout_footer.jsp" %>
