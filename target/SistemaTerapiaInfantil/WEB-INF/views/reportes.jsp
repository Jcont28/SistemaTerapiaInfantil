<%@ include file="layout_header.jsp" %>

<div class="print-only-header border-bottom pb-2 mb-3">
    <h4 class="fw-bold mb-0">Centro Terapeutico Infantil - Reporte Clinico y Pedagogico</h4>
    <small class="text-muted">Documento generado oficialmente desde el Sistema de Gestion Terapeutica</small>
</div>

<div class="d-flex flex-wrap justify-content-between align-items-center mb-3 gap-2 no-print">
    <h3 class="fw-bold mb-0">Reportes Semanales, Mensuales y Semestrales</h3>
    <div class="d-flex gap-2">
        <button onclick="imprimirSeccion('seccionSemanal')" class="btn btn-info text-white btn-sm">
            <i class="bi bi-file-earmark-pdf me-1"></i> Imprimir / PDF Semanal
        </button>
        <button onclick="imprimirSeccion('seccionSemestral')" class="btn btn-success btn-sm">
            <i class="bi bi-file-earmark-pdf me-1"></i> Imprimir / PDF Semestral
        </button>
        <button onclick="imprimirTodo()" class="btn btn-outline-primary btn-sm">
            <i class="bi bi-printer me-1"></i> Imprimir Todo
        </button>
    </div>
</div>

<c:if test="${not empty error}"><div class="alert alert-danger no-print"><i class="bi bi-x-circle-fill me-2"></i>${error}</div></c:if>

<div class="row g-4">
    <!-- REPORTE SEMANAL -->
    <div class="col-12" id="seccionSemanal">
        <div class="card card-modern p-4">
            <div class="d-flex flex-wrap justify-content-between align-items-center mb-3 gap-2">
                <div>
                    <h5 class="fw-bold text-info mb-1"><i class="bi bi-calendar-week me-1"></i> Reporte Semanal de Actividades y Evaluaciones</h5>
                    <p class="small text-muted mb-0">Periodo semanal: <strong>${semanaInicio}</strong> al <strong>${semanaFin}</strong></p>
                </div>
                <div class="d-flex align-items-center gap-2">
                    <span class="badge bg-info text-dark fs-6">${reporteSemanal.size()} sesion(es)</span>
                    <button type="button" onclick="imprimirSeccion('seccionSemanal')" class="btn btn-outline-info btn-sm no-print">
                        <i class="bi bi-printer"></i> Exportar PDF Semanal
                    </button>
                </div>
            </div>

            <form method="get" action="${pageContext.request.contextPath}/reportes" class="row g-2 align-items-end mb-3 no-print">
                <input type="hidden" name="mes" value="${mesSeleccionado}">
                <input type="hidden" name="anio" value="${anioSeleccionado}">
                <input type="hidden" name="idEspecialista" value="${idEspecialistaFiltro}">
                <input type="hidden" name="idPaciente" value="${idPacienteSemestral}">
                <div class="col-md-2">
                    <label class="form-label small fw-semibold">Desde (Lunes)</label>
                    <input type="date" name="semanaInicio" class="form-control form-control-sm" value="${semanaInicio}">
                </div>
                <div class="col-md-2">
                    <label class="form-label small fw-semibold">Hasta (Domingo)</label>
                    <input type="date" name="semanaFin" class="form-control form-control-sm" value="${semanaFin}">
                </div>
                <div class="col-md-3">
                    <label class="form-label small fw-semibold">Especialista (Opcional)</label>
                    <select name="idEspecialistaSemanal" class="form-select form-select-sm">
                        <option value="0">-- Todos --</option>
                        <c:forEach var="esp" items="${especialistas}">
                            <option value="${esp.idUsuario}" ${idEspecialistaSemanal == esp.idUsuario ? 'selected' : ''}>${esp.nombreCompleto}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label small fw-semibold">Paciente (Opcional)</label>
                    <select name="idPacienteSemanal" class="form-select form-select-sm">
                        <option value="0">-- Todos --</option>
                        <c:forEach var="p" items="${pacientes}">
                            <option value="${p.idPaciente}" ${idPacienteSemanal == p.idPaciente ? 'selected' : ''}>${p.nombreCompleto}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-info text-white btn-sm w-100"><i class="bi bi-search me-1"></i> Filtrar Semana</button>
                </div>
            </form>

            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle small mb-0">
                    <thead class="table-info">
                        <tr>
                            <th>Fecha</th>
                            <th>Paciente</th>
                            <th>Especialista</th>
                            <th>Actividad / Evaluacion</th>
                            <th>Categoria</th>
                            <th>Nivel de Avance</th>
                            <th>Observaciones</th>
                            <th class="text-end no-print">Accion</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="w" items="${reporteSemanal}">
                            <tr>
                                <td>${w.fecha}</td>
                                <td class="fw-semibold">${w.paciente}</td>
                                <td>${w.especialista}</td>
                                <td>${w.actividad}</td>
                                <td>${w.categoria}</td>
                                <td><span class="badge bg-primary-subtle text-primary">${w.nivelAvance}</span></td>
                                <td>${w.observaciones}</td>
                                <td class="text-end no-print">
                                    <c:if test="${esAdmin || u.tienePermiso('GESTIONAR_FACTURACION') || u.nombreRol == 'RECEPCION'}"><a href="${pageContext.request.contextPath}/facturacion?idPaciente=${w.idPaciente}&mes=${mesSeleccionado}&anio=${anioSeleccionado}" class="btn btn-outline-success btn-sm py-0 px-2"><i class="bi bi-receipt"></i> Facturar</a></c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty reporteSemanal}">
                            <tr><td colspan="8" class="text-center text-muted py-3">No hay evaluaciones ni actividades registradas en el rango semanal seleccionado.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- REPORTE MENSUAL -->
    <div class="col-12" id="seccionMensual">
        <div class="card card-modern p-4">
            <div class="d-flex flex-wrap justify-content-between align-items-center mb-3 gap-2">
                <div>
                    <h5 class="fw-bold text-primary mb-1"><i class="bi bi-calendar-month me-1"></i> Reporte Mensual de Actividades</h5>
                    <p class="small text-muted mb-0">Consolidado de todas las sesiones realizadas en el mes seleccionado.</p>
                </div>
                <span class="badge bg-primary fs-6">${reporteMensual.size()} actividad(es)</span>
            </div>

            <form method="get" action="${pageContext.request.contextPath}/reportes" class="row g-2 align-items-end mb-3 no-print">
                <input type="hidden" name="semanaInicio" value="${semanaInicio}">
                <input type="hidden" name="semanaFin" value="${semanaFin}">
                <input type="hidden" name="idEspecialistaSemanal" value="${idEspecialistaSemanal}">
                <input type="hidden" name="idPacienteSemanal" value="${idPacienteSemanal}">
                <input type="hidden" name="idPaciente" value="${idPacienteSemestral}">
                <div class="col-md-3">
                    <label class="form-label small fw-semibold">Mes</label>
                    <select name="mes" class="form-select form-select-sm">
                        <option value="1" ${mesSeleccionado == 1 ? 'selected' : ''}>Enero</option>
                        <option value="2" ${mesSeleccionado == 2 ? 'selected' : ''}>Febrero</option>
                        <option value="3" ${mesSeleccionado == 3 ? 'selected' : ''}>Marzo</option>
                        <option value="4" ${mesSeleccionado == 4 ? 'selected' : ''}>Abril</option>
                        <option value="5" ${mesSeleccionado == 5 ? 'selected' : ''}>Mayo</option>
                        <option value="6" ${mesSeleccionado == 6 ? 'selected' : ''}>Junio</option>
                        <option value="7" ${mesSeleccionado == 7 ? 'selected' : ''}>Julio</option>
                        <option value="8" ${mesSeleccionado == 8 ? 'selected' : ''}>Agosto</option>
                        <option value="9" ${mesSeleccionado == 9 ? 'selected' : ''}>Septiembre</option>
                        <option value="10" ${mesSeleccionado == 10 ? 'selected' : ''}>Octubre</option>
                        <option value="11" ${mesSeleccionado == 11 ? 'selected' : ''}>Noviembre</option>
                        <option value="12" ${mesSeleccionado == 12 ? 'selected' : ''}>Diciembre</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <label class="form-label small fw-semibold">Año</label>
                    <input type="number" name="anio" class="form-control form-control-sm" value="${anioSeleccionado}" min="2020" max="2100">
                </div>
                <div class="col-md-4">
                    <label class="form-label small fw-semibold">Especialista (Opcional)</label>
                    <select name="idEspecialista" class="form-select form-select-sm">
                        <option value="0">-- Todos los especialistas --</option>
                        <c:forEach var="esp" items="${especialistas}">
                            <option value="${esp.idUsuario}" ${idEspecialistaFiltro == esp.idUsuario ? 'selected' : ''}>${esp.nombreCompleto}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3">
                    <button type="submit" class="btn btn-primary btn-sm w-100"><i class="bi bi-search me-1"></i> Consultar Mes</button>
                </div>
            </form>

            <div class="table-responsive">
                <table class="table table-hover align-middle small mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>Fecha</th>
                            <th>Paciente</th>
                            <th>Especialista</th>
                            <th>Actividad</th>
                            <th>Categoria</th>
                            <th>Avance</th>
                            <th>Observaciones</th>
                            <th class="text-end no-print">Facturacion</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="r" items="${reporteMensual}">
                            <tr>
                                <td>${r.fecha}</td>
                                <td class="fw-semibold">${r.paciente}</td>
                                <td>${r.especialista}</td>
                                <td>${r.actividad}</td>
                                <td><span class="badge bg-secondary-subtle text-secondary">${r.categoria}</span></td>
                                <td><span class="badge bg-info-subtle text-dark">${r.nivelAvance}</span></td>
                                <td>${r.observaciones}</td>
                                <td class="text-end no-print">
                                    <c:if test="${esAdmin || u.tienePermiso('GESTIONAR_FACTURACION') || u.nombreRol == 'RECEPCION'}"><a href="${pageContext.request.contextPath}/facturacion?idPaciente=${r.idPaciente}&mes=${mesSeleccionado}&anio=${anioSeleccionado}" class="btn btn-outline-success btn-sm py-0 px-2"><i class="bi bi-receipt"></i> Facturar</a></c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty reporteMensual}">
                            <tr><td colspan="8" class="text-center text-muted py-3">No hay actividades registradas en el mes y año seleccionados.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- REPORTE SEMESTRAL (6 MESES) -->
    <div class="col-12" id="seccionSemestral">
        <div class="card card-modern p-4">
            <div class="d-flex flex-wrap justify-content-between align-items-center mb-2 gap-2">
                <div>
                    <h5 class="fw-bold text-success mb-1"><i class="bi bi-graph-up me-1"></i> Reporte Semestral de Avances por Paciente (Ultimos 6 Meses)</h5>
                    <p class="small text-muted mb-0">Evolucion detallada por paciente lista para imprimir o guardar en PDF para los padres de familia.</p>
                </div>
                <c:if test="${not empty infoPacienteSemestral}">
                    <button type="button" onclick="imprimirSeccion('seccionSemestral')" class="btn btn-outline-success btn-sm no-print">
                        <i class="bi bi-file-earmark-pdf me-1"></i> Exportar PDF Semestral
                    </button>
                </c:if>
            </div>

            <form method="get" action="${pageContext.request.contextPath}/reportes" class="row g-2 align-items-end mb-3 no-print">
                <input type="hidden" name="semanaInicio" value="${semanaInicio}">
                <input type="hidden" name="semanaFin" value="${semanaFin}">
                <input type="hidden" name="idEspecialistaSemanal" value="${idEspecialistaSemanal}">
                <input type="hidden" name="idPacienteSemanal" value="${idPacienteSemanal}">
                <input type="hidden" name="mes" value="${mesSeleccionado}">
                <input type="hidden" name="anio" value="${anioSeleccionado}">
                <input type="hidden" name="idEspecialista" value="${idEspecialistaFiltro}">
                <div class="col-md-8">
                    <label class="form-label small fw-semibold">Seleccione el Niño (Paciente)</label>
                    <select name="idPaciente" class="form-select form-select-sm" required>
                        <option value="">-- Seleccione un Paciente --</option>
                        <c:forEach var="p" items="${pacientes}">
                            <option value="${p.idPaciente}" ${idPacienteSemestral == p.idPaciente ? 'selected' : ''}>${p.nombreCompleto}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <button type="submit" class="btn btn-success btn-sm w-100"><i class="bi bi-file-earmark-medical me-1"></i> Generar Reporte Semestral</button>
                </div>
            </form>

            <c:if test="${not empty infoPacienteSemestral}">
                <div class="border rounded p-3 bg-light mb-3">
                    <div class="row g-2 small">
                        <div class="col-md-4"><strong>Paciente:</strong> ${infoPacienteSemestral.nombre}</div>
                        <div class="col-md-4"><strong>Encargado:</strong> ${infoPacienteSemestral.encargado} (${infoPacienteSemestral.telefono})</div>
                        <div class="col-md-4"><strong>Especialista Asignado:</strong> ${not empty infoPacienteSemestral.especialista ? infoPacienteSemestral.especialista : 'Sin asignar'}</div>
                        <div class="col-md-4"><strong>Plan Activo:</strong> ${not empty infoPacienteSemestral.planNombre ? infoPacienteSemestral.planNombre : 'Sin plan activo'}</div>
                        <div class="col-md-4"><strong>Tarifa Mensual:</strong> L. ${not empty infoPacienteSemestral.precioLempiras ? infoPacienteSemestral.precioLempiras : '0.00'}</div>
                        <div class="col-md-4 text-md-end no-print">
                            <c:if test="${esAdmin || u.tienePermiso('GESTIONAR_FACTURACION') || u.nombreRol == 'RECEPCION'}"><a href="${pageContext.request.contextPath}/facturacion?idPaciente=${idPacienteSemestral}&mes=${mesSeleccionado}&anio=${anioSeleccionado}" class="btn btn-success btn-sm"><i class="bi bi-receipt-cutoff me-1"></i> Generar Factura de este Paciente</a></c:if>
                        </div>
                        <div class="col-12"><strong>Diagnostico Inicial:</strong> ${not empty infoPacienteSemestral.diagnostico ? infoPacienteSemestral.diagnostico : 'N/A'}</div>
                    </div>
                    <hr class="my-2">
                    <div class="d-flex flex-wrap gap-2 small">
                        <span class="fw-semibold">Resumen de Avances (6 meses):</span>
                        <c:forEach var="entry" items="${resumenNiveles}">
                            <span class="badge bg-white text-dark border">${entry.key}: <strong>${entry.value}</strong></span>
                        </c:forEach>
                        <span class="badge bg-success ms-auto">Total Sesiones Evaluadas: ${reporteSemestral.size()}</span>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-bordered align-middle small mb-0">
                        <thead class="table-success">
                            <tr>
                                <th>Fecha</th>
                                <th>Actividad Realizada</th>
                                <th>Categoria</th>
                                <th>Especialista</th>
                                <th>Nivel de Avance</th>
                                <th>Observaciones Clinicas / Pedagogicas</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="s" items="${reporteSemestral}">
                                <tr>
                                    <td>${s.fecha}</td>
                                    <td class="fw-semibold">${s.actividad}</td>
                                    <td>${s.categoria}</td>
                                    <td>${s.especialista}</td>
                                    <td><span class="badge bg-primary-subtle text-primary">${s.nivelAvance}</span></td>
                                    <td>${s.observaciones}</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty reporteSemestral}">
                                <tr><td colspan="6" class="text-center text-muted py-3">Este paciente aun no tiene actividades registradas en los ultimos 6 meses.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>
</div>

<script>
function imprimirSeccion(idSeccion) {
    const secciones = ['seccionSemanal', 'seccionMensual', 'seccionSemestral'];
    secciones.forEach(id => {
        const el = document.getElementById(id);
        if (el) {
            if (id === idSeccion) {
                el.classList.remove('print-section-hidden');
            } else {
                el.classList.add('print-section-hidden');
            }
        }
    });
    window.print();
    setTimeout(() => {
        secciones.forEach(id => {
            const el = document.getElementById(id);
            if (el) el.classList.remove('print-section-hidden');
        });
    }, 500);
}

function imprimirTodo() {
    ['seccionSemanal', 'seccionMensual', 'seccionSemestral'].forEach(id => {
        const el = document.getElementById(id);
        if (el) el.classList.remove('print-section-hidden');
    });
    window.print();
}
</script>
<%@ include file="layout_footer.jsp" %>
