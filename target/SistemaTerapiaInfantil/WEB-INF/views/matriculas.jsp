<%@ include file="layout_header.jsp" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<h3 class="fw-bold mb-3">Matricula de Pacientes (Niños)</h3>
<c:if test="${not empty mensaje}"><div class="alert alert-success"><i class="bi bi-check-circle-fill me-2"></i>${mensaje}</div></c:if>
<c:if test="${not empty advertencia}"><div class="alert alert-warning"><i class="bi bi-exclamation-triangle-fill me-2"></i>${advertencia}</div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger"><i class="bi bi-x-circle-fill me-2"></i>${error}</div></c:if>

<div id="alertaHorarioJS" class="alert alert-warning d-none">
    <i class="bi bi-exclamation-triangle-fill me-2"></i>
    <span id="alertaHorarioTexto"></span>
</div>

<div class="row g-4">
    <div class="col-lg-6">
        <div class="card card-modern p-4">
            <h5 class="fw-bold mb-3">Nueva Matricula</h5>
            <form method="post" action="${pageContext.request.contextPath}/matriculas" id="formMatricula">
                <div class="row g-3">
                    <div class="col-md-6"><label class="form-label small">Nombre del Niño (Paciente)</label><input type="text" name="nombrePaciente" class="form-control" required></div>
                    <div class="col-md-6"><label class="form-label small">Fecha de Nacimiento</label><input type="date" name="fechaNacimiento" class="form-control" required></div>
                    <div class="col-md-6"><label class="form-label small">Nombre del Encargado</label><input type="text" name="nombreEncargado" class="form-control" required></div>
                    <div class="col-md-6"><label class="form-label small">Telefono del Encargado</label><input type="text" name="telefonoEncargado" class="form-control" required></div>
                    <div class="col-12"><label class="form-label small">Diagnostico / Motivo Inicial</label><input type="text" name="diagnostico" class="form-control"></div>

                    <div class="col-md-12">
                        <label class="form-label small">Especialista</label>
                        <select name="idEspecialista" id="selectEspecialista" class="form-select" required onchange="validarCruceHorario()">
                            <option value="">-- Seleccione Especialista --</option>
                            <c:forEach var="esp" items="${especialistas}">
                                <option value="${esp.idUsuario}">${esp.nombreCompleto} (${not empty esp.especialidad ? esp.especialidad : esp.nombreRol})</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label small">Dia</label>
                        <select name="diaSemana" id="selectDia" class="form-select" required onchange="validarCruceHorario()">
                            <option value="">-- Dia --</option>
                            <option value="Lunes">Lunes</option>
                            <option value="Martes">Martes</option>
                            <option value="Miercoles">Miercoles</option>
                            <option value="Jueves">Jueves</option>
                            <option value="Viernes">Viernes</option>
                            <option value="Sabado">Sabado</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small">Hora Inicial</label>
                        <input type="time" name="horaInicio" id="inputHoraInicio" class="form-control" required onchange="validarCruceHorario()">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small">Hora Final</label>
                        <input type="time" name="horaFin" id="inputHoraFin" class="form-control" required onchange="validarCruceHorario()">
                    </div>

                    <div class="col-md-12">
                        <label class="form-label small">Plan Mensual (Solo Planes Activos)</label>
                        <select name="idPlan" class="form-select" required>
                            <c:forEach var="pl" items="${planesActivos}">
                                <option value="${pl.idPlan}">${pl.nombre} - ${pl.sesionesMes} sesiones (L. ${pl.precioLempiras})</option>
                            </c:forEach>
                        </select>
                        <c:if test="${empty planesActivos}">
                            <small class="text-danger">No hay planes activos. Active al menos un plan en el modulo de Planes.</small>
                        </c:if>
                    </div>
                </div>
                <button class="btn btn-primary mt-4 w-100" id="btnGuardarMatricula">Registrar Matricula</button>
            </form>
        </div>
    </div>

    <div class="col-lg-6">
        <div class="card card-modern p-4">
            <h5 class="fw-bold mb-3">Matriculas Recientes</h5>
            <div class="table-responsive">
                <table class="table table-hover align-middle small">
                    <thead class="table-light">
                        <tr><th>Paciente</th><th>Especialista</th><th>Horario</th><th>Plan</th></tr>
                    </thead>
                    <tbody>
                        <c:forEach var="m" items="${matriculasRecientes}">
                            <tr>
                                <td class="fw-semibold">${m.paciente}</td>
                                <td>${m.especialista}</td>
                                <td>${m.horario}</td>
                                <td><span class="badge bg-success-subtle text-success">${m.plan}</span></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty matriculasRecientes}">
                            <tr><td colspan="4" class="text-center text-muted py-3">Aun no hay matriculas registradas.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
const ocupacionesActivas = [
    <c:forEach var="o" items="${ocupacionesActivas}" varStatus="st">
    {
        idEspecialista: "${o.idEspecialista}",
        paciente: "${fn:escapeXml(o.paciente)}",
        dia: "${o.dia}",
        inicio: "${o.inicio}",
        fin: "${o.fin}"
    }<c:if test="${!st.last}">,</c:if>
    </c:forEach>
];

function validarCruceHorario() {
    const idEsp = document.getElementById('selectEspecialista').value;
    const dia = document.getElementById('selectDia').value;
    const inicio = document.getElementById('inputHoraInicio').value;
    const fin = document.getElementById('inputHoraFin').value;
    const alerta = document.getElementById('alertaHorarioJS');
    const texto = document.getElementById('alertaHorarioTexto');

    alerta.classList.add('d-none');
    if (!idEsp || !dia || !inicio || !fin) return;

    if (fin <= inicio) {
        texto.textContent = 'Atencion: La hora final debe ser mayor que la hora inicial.';
        alerta.classList.remove('d-none');
        return;
    }

    const conflictos = ocupacionesActivas.filter(o =>
        o.idEspecialista === idEsp &&
        o.dia.toLowerCase() === dia.toLowerCase() &&
        (inicio < o.fin && fin > o.inicio)
    );

    if (conflictos.length > 0) {
        const detalle = conflictos.map(c => c.paciente + ' (' + c.inicio + ' - ' + c.fin + ')').join(', ');
        texto.textContent = 'Advertencia: El especialista seleccionado ya tiene asignado ese horario con ' + detalle + '. Puedes continuar y guardar si lo deseas.';
        alerta.classList.remove('d-none');
    }
}
</script>
<%@ include file="layout_footer.jsp" %>
