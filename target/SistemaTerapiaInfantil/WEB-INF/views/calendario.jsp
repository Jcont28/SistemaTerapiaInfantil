<%@ include file="layout_header.jsp" %>
<h3 class="fw-bold mb-3">Calendario de Reservas y Fechas Conmemorativas</h3>
<c:if test="${not empty mensaje}"><div class="alert alert-success">${mensaje}</div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

<div class="row g-4">
    <div class="col-lg-8">
        <div class="card card-modern p-3">
            <div id="calendar"></div>
        </div>
    </div>
    <div class="col-lg-4">
        <div class="card card-modern p-4">
            <h6 class="fw-bold mb-3">Agregar Reserva / Celebracion</h6>
            <form method="post" action="${pageContext.request.contextPath}/calendario">
                <div class="mb-2"><label class="form-label small">Titulo</label><input type="text" name="titulo" class="form-control" required></div>
                <div class="mb-2">
                    <label class="form-label small">Tipo</label>
                    <select name="tipoEvento" class="form-select">
                        <option value="SESION">Sesion / Reserva</option>
                        <option value="ACTIVIDAD">Actividad Especial</option>
                        <option value="CELEBRACION">Fecha Conmemorativa</option>
                    </select>
                </div>
                <div class="mb-2"><label class="form-label small">Inicio</label><input type="datetime-local" name="fechaInicio" class="form-control" required></div>
                <div class="mb-2"><label class="form-label small">Fin</label><input type="datetime-local" name="fechaFin" class="form-control" required></div>
                <div class="mb-2"><label class="form-label small">Color</label><input type="color" name="colorHex" class="form-control form-control-color" value="#2563eb"></div>
                <div class="mb-3"><label class="form-label small">Descripcion</label><textarea name="descripcion" class="form-control" rows="2"></textarea></div>
                <button class="btn btn-primary w-100">Guardar en Calendario</button>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        locale: 'es',
        events: '${pageContext.request.contextPath}/calendario?format=json'
    });
    calendar.render();
});
</script>
<%@ include file="layout_footer.jsp" %>
