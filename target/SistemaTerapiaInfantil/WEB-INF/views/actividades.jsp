<%@ include file="layout_header.jsp" %>
<h3 class="fw-bold mb-3">Registro de Actividades por Paciente</h3>
<c:if test="${not empty mensaje}"><div class="alert alert-success">${mensaje}</div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

<div class="row g-4">
    <div class="col-lg-5">
        <div class="card card-modern p-4">
            <h5 class="fw-bold mb-3">Registrar Nueva Actividad</h5>
            <form method="post" action="${pageContext.request.contextPath}/actividades">
                <div class="mb-3">
                    <label class="form-label small">Paciente</label>
                    <select name="idPaciente" class="form-select" required>
                        <option value="">-- Seleccione Paciente --</option>
                        <c:forEach var="p" items="${pacientes}">
                            <option value="${p.idPaciente}">${p.nombreCompleto}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label small">Especialista</label>
                    <select name="idEspecialista" class="form-select" required>
                        <c:forEach var="esp" items="${especialistas}">
                            <option value="${esp.idUsuario}">${esp.nombreCompleto} (${not empty esp.especialidad ? esp.especialidad : esp.nombreRol})</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label small">Actividad Realizada</label>
                    <select name="idActividad" class="form-select" required>
                        <c:forEach var="act" items="${catalogoActividades}">
                            <option value="${act.idActividad}">${act.nombre} (${act.categoria})</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="row g-2 mb-3">
                    <div class="col-md-6">
                        <label class="form-label small">Fecha</label>
                        <input type="date" name="fechaActividad" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small">Nivel de Avance</label>
                        <select name="nivelAvance" class="form-select">
                            <option value="Inicial">Inicial</option>
                            <option value="En Progreso">En Progreso</option>
                            <option value="Logrado">Logrado</option>
                            <option value="Sobresaliente">Sobresaliente</option>
                        </select>
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label small">Observaciones para Reporte Semestral</label>
                    <textarea name="observaciones" class="form-control" rows="3"></textarea>
                </div>
                <button class="btn btn-primary w-100">Registrar Actividad</button>
            </form>
        </div>
    </div>

    <div class="col-lg-7">
        <div class="card card-modern p-4">
            <h5 class="fw-bold mb-3">Historial Reciente de Actividades</h5>
            <div class="table-responsive">
                <table class="table table-hover align-middle small">
                    <thead class="table-light">
                        <tr><th>Fecha</th><th>Paciente</th><th>Especialista</th><th>Actividad</th><th>Avance</th></tr>
                    </thead>
                    <tbody>
                        <c:forEach var="r" items="${registrosActividades}">
                            <tr>
                                <td>${r.fecha}</td>
                                <td class="fw-semibold">${r.paciente}</td>
                                <td>${r.especialista}</td>
                                <td>${r.actividad}</td>
                                <td><span class="badge bg-info text-dark">${r.nivelAvance}</span></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty registrosActividades}">
                            <tr><td colspan="5" class="text-center text-muted py-3">Aun no hay actividades registradas.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@ include file="layout_footer.jsp" %>
