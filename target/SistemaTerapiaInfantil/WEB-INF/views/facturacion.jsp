<%@ include file="layout_header.jsp" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<div class="d-flex justify-content-between align-items-center mb-3 no-print">
    <h3 class="fw-bold mb-0">Facturacion y Recepcion de Pagos</h3>
    <button onclick="window.print()" class="btn btn-outline-primary btn-sm"><i class="bi bi-printer"></i> Imprimir Comprobante / Listado</button>
</div>

<c:if test="${not empty mensaje}"><div class="alert alert-success no-print"><i class="bi bi-check-circle-fill me-2"></i>${mensaje}</div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger no-print"><i class="bi bi-x-circle-fill me-2"></i>${error}</div></c:if>

<!-- COMPROBANTE DE FACTURA SELECCIONADA PARA IMPRESION -->
<c:if test="${not empty facturaDetalle}">
    <div class="card card-modern border-primary p-4 mb-4">
        <div class="d-flex justify-content-between align-items-start border-bottom pb-3 mb-3">
            <div>
                <h5 class="fw-bold text-primary mb-0">COMPROBANTE DE FACTURA - ${facturaDetalle.numeroFactura}</h5>
                <small class="text-muted">Centro Terapeutico Infantil | Fecha de Emision: ${facturaDetalle.fechaEmision}</small>
            </div>
            <div class="text-end">
                <span class="badge ${facturaDetalle.estado == 'PAGADA' ? 'bg-success' : (facturaDetalle.estado == 'PARCIAL' ? 'bg-warning text-dark' : 'bg-danger')} fs-6">
                    ${facturaDetalle.estado}
                </span>
                <div class="mt-1 no-print">
                    <button type="button" onclick="window.print()" class="btn btn-sm btn-primary py-0">Imprimir / PDF</button>
                    <a href="${pageContext.request.contextPath}/facturacion" class="btn btn-sm btn-outline-secondary py-0">Cerrar vista</a>
                </div>
            </div>
        </div>
        <div class="row g-2 small mb-3">
            <div class="col-md-4"><strong>Paciente (Niño):</strong> ${facturaDetalle.paciente}</div>
            <div class="col-md-4"><strong>Encargado:</strong> ${facturaDetalle.encargado} (${facturaDetalle.telefono})</div>
            <div class="col-md-4"><strong>Especialista:</strong> ${facturaDetalle.especialista}</div>
            <div class="col-md-4"><strong>Plan Contratado:</strong> ${facturaDetalle.planNombre}</div>
            <div class="col-md-4"><strong>Periodo Facturado:</strong> Mes ${facturaDetalle.periodoMes} / ${facturaDetalle.periodoAnio}</div>
            <div class="col-md-4"><strong>Sesiones Evaluadas / Plan:</strong> ${facturaDetalle.sesionesRealizadas} / ${facturaDetalle.sesionesPlan} sesiones</div>
        </div>

        <c:if test="${not empty evaluacionesFacturaDetalle}">
            <h6 class="fw-bold small text-primary mb-2"><i class="bi bi-clipboard2-check me-1"></i> Evaluaciones del Especialista Importadas en esta Factura</h6>
            <div class="table-responsive mb-3">
                <table class="table table-sm table-bordered small mb-0">
                    <thead class="table-primary">
                        <tr>
                            <th>Fecha</th>
                            <th>Actividad / Evaluacion</th>
                            <th>Categoria</th>
                            <th>Especialista</th>
                            <th>Nivel de Avance</th>
                            <th>Observaciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="ev" items="${evaluacionesFacturaDetalle}">
                            <tr>
                                <td>${ev.fecha}</td>
                                <td class="fw-semibold">${ev.actividad}</td>
                                <td>${ev.categoria}</td>
                                <td>${ev.especialista}</td>
                                <td><span class="badge bg-info-subtle text-dark">${ev.nivelAvance}</span></td>
                                <td>${ev.observaciones}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

        <div class="table-responsive">
            <table class="table table-sm table-bordered mb-0 small">
                <thead class="table-light">
                    <tr>
                        <th>Concepto</th>
                        <th class="text-end">Subtotal</th>
                        <th class="text-end">Descuento</th>
                        <th class="text-end">Total Facturado</th>
                        <th class="text-end">Total Pagado</th>
                        <th class="text-end">Saldo Pendiente</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Servicios terapeuticos (${facturaDetalle.planNombre}) - ${facturaDetalle.sesionesRealizadas} sesion(es) evaluada(s)</td>
                        <td class="text-end">L. ${facturaDetalle.subtotal}</td>
                        <td class="text-end">L. ${facturaDetalle.descuento}</td>
                        <td class="text-end fw-bold">L. ${facturaDetalle.total}</td>
                        <td class="text-end text-success fw-semibold">L. ${facturaDetalle.pagado}</td>
                        <td class="text-end text-danger fw-bold">L. ${facturaDetalle.saldo}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</c:if>

<div class="row g-4 mb-4 no-print">
    <!-- FORMULARIO 1: GENERAR FACTURA DESDE PLAN E IMPORTAR EVALUACIONES DEL ESPECIALISTA -->
    <div class="col-lg-6">
        <div class="card card-modern p-4 h-100">
            <h5 class="fw-bold text-primary mb-3"><i class="bi bi-file-earmark-plus me-1"></i> Generar Factura por Paciente</h5>

            <form method="get" action="${pageContext.request.contextPath}/facturacion" class="row g-2 align-items-end bg-light p-2 rounded mb-3">
                <div class="col-4">
                    <label class="form-label small mb-1">Mes a evaluar</label>
                    <select name="mes" class="form-select form-select-sm">
                        <option value="1" ${mesActual == 1 ? 'selected' : ''}>Enero</option>
                        <option value="2" ${mesActual == 2 ? 'selected' : ''}>Febrero</option>
                        <option value="3" ${mesActual == 3 ? 'selected' : ''}>Marzo</option>
                        <option value="4" ${mesActual == 4 ? 'selected' : ''}>Abril</option>
                        <option value="5" ${mesActual == 5 ? 'selected' : ''}>Mayo</option>
                        <option value="6" ${mesActual == 6 ? 'selected' : ''}>Junio</option>
                        <option value="7" ${mesActual == 7 ? 'selected' : ''}>Julio</option>
                        <option value="8" ${mesActual == 8 ? 'selected' : ''}>Agosto</option>
                        <option value="9" ${mesActual == 9 ? 'selected' : ''}>Septiembre</option>
                        <option value="10" ${mesActual == 10 ? 'selected' : ''}>Octubre</option>
                        <option value="11" ${mesActual == 11 ? 'selected' : ''}>Noviembre</option>
                        <option value="12" ${mesActual == 12 ? 'selected' : ''}>Diciembre</option>
                    </select>
                </div>
                <div class="col-4">
                    <label class="form-label small mb-1">Año</label>
                    <input type="number" name="anio" class="form-control form-control-sm" value="${anioActual}">
                </div>
                <div class="col-4">
                    <button type="submit" class="btn btn-outline-secondary btn-sm w-100">Actualizar Periodo</button>
                </div>
            </form>

            <form method="post" action="${pageContext.request.contextPath}/facturacion">
                <input type="hidden" name="accion" value="generarFactura">
                <input type="hidden" name="periodoMes" value="${mesActual}">
                <input type="hidden" name="periodoAnio" value="${anioActual}">

                <div class="row g-3">
                    <div class="col-12">
                        <label class="form-label small fw-semibold">Paciente / Matricula Activa</label>
                        <select name="idMatricula" id="selectMatriculaFact" class="form-select" required onchange="actualizarResumenYEvaluaciones()">
                            <option value="">-- Seleccione Paciente --</option>
                            <c:forEach var="m" items="${matriculasFacturables}">
                                <option value="${m.idMatricula}"
                                        ${idPacientePre == m.idPaciente ? 'selected' : ''}
                                        data-id-paciente="${m.idPaciente}"
                                        data-plan="${m.plan}"
                                        data-monto="${m.montoMensual}"
                                        data-sesiones-plan="${m.sesionesPlan}"
                                        data-sesiones-rep="${m.sesionesReportadas}"
                                        data-encargado="${m.encargado}">
                                    ${m.paciente} | ${m.plan} (L. ${m.montoMensual}) | Reporte mes: ${m.sesionesReportadas}/${m.sesionesPlan}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-12">
                        <div id="resumenSeleccionFact" class="alert alert-light border small mb-0 d-none"></div>
                    </div>

                    <!-- BLOQUE PARA CARGAR / IMPORTAR EVALUACIONES DEL ESPECIALISTA -->
                    <div class="col-12">
                        <div class="border rounded p-2 bg-light">
                            <div class="d-flex flex-wrap justify-content-between align-items-center mb-2 gap-1">
                                <span class="small fw-bold text-primary"><i class="bi bi-cloud-download me-1"></i> Evaluaciones del Especialista a Importar</span>
                                <div class="btn-group btn-group-sm">
                                    <button type="button" class="btn btn-outline-primary py-0 px-2" onclick="cargarEvaluacionesPaciente('MES')">Cargar del Mes</button>
                                    <button type="button" class="btn btn-outline-secondary py-0 px-2" onclick="cargarEvaluacionesPaciente('TODAS')">Cargar Todas</button>
                                </div>
                            </div>
                            <div id="contenedorEvaluacionesImportadas" class="small text-muted">
                                Seleccione un paciente para cargar las evaluaciones realizadas por su especialista.
                            </div>
                        </div>
                    </div>

                    <div class="col-md-7">
                        <label class="form-label small fw-semibold">Base de Calculo</label>
                        <select name="modalidadCobro" class="form-select">
                            <option value="PLAN_COMPLETO">Tarifa Mensual Completa del Plan</option>
                            <option value="PROPORCIONAL_SESIONES">Proporcional a Evaluaciones Importadas</option>
                        </select>
                    </div>
                    <div class="col-md-5">
                        <label class="form-label small fw-semibold">Descuento (L.)</label>
                        <input type="number" step="0.01" min="0" name="descuento" value="0.00" class="form-control">
                    </div>
                    <div class="col-12">
                        <label class="form-label small fw-semibold">Observaciones de Factura</label>
                        <input type="text" name="observaciones" class="form-control" placeholder="Ej. Mensualidad y evaluaciones terapeuticas del periodo">
                    </div>
                </div>
                <button type="submit" class="btn btn-primary mt-3 w-100"><i class="bi bi-receipt me-1"></i> Emitir y Guardar Factura</button>
            </form>
        </div>
    </div>

    <!-- FORMULARIO 2: RECEPCION DE PAGO POR FACTURA -->
    <div class="col-lg-6">
        <div class="card card-modern p-4 h-100">
            <h5 class="fw-bold text-success mb-3"><i class="bi bi-cash-coin me-1"></i> Recepcion de Pago por Factura</h5>
            <form method="post" action="${pageContext.request.contextPath}/facturacion">
                <input type="hidden" name="accion" value="registrarPago">
                <div class="row g-3">
                    <div class="col-12">
                        <label class="form-label small fw-semibold">Factura Pendiente o Parcial</label>
                        <select name="idFactura" id="selectFacturaPago" class="form-select" required onchange="autocompletarSaldo()">
                            <option value="">-- Seleccione Factura a Cobrar --</option>
                            <c:forEach var="f" items="${facturas}">
                                <c:if test="${f.estado != 'PAGADA' && f.estado != 'ANULADA'}">
                                    <option value="${f.idFactura}" data-saldo="${f.saldo}">
                                        ${f.numeroFactura} - ${f.paciente} (${f.planNombre}) | Saldo: L. ${f.saldo}
                                    </option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small fw-semibold">Monto Recibido (Lempiras)</label>
                        <input type="number" step="0.01" min="0.01" name="montoPago" id="inputMontoPago" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small fw-semibold">Metodo de Pago</label>
                        <select name="metodoPago" class="form-select" required>
                            <option value="Efectivo">Efectivo</option>
                            <option value="Transferencia Bancaria">Transferencia Bancaria</option>
                            <option value="Tarjeta POS">Tarjeta POS</option>
                            <option value="Deposito Bancario">Deposito Bancario</option>
                        </select>
                    </div>
                    <div class="col-12">
                        <label class="form-label small fw-semibold">Numero de Referencia / Comprobante</label>
                        <input type="text" name="referenciaPago" class="form-control" placeholder="Ej. Recibo #1045 / Transf. BAC 89231">
                    </div>
                </div>
                <button type="submit" class="btn btn-success mt-3 w-100"><i class="bi bi-check2-circle me-1"></i> Registrar Pago Recibido</button>
            </form>

            <hr class="my-3">
            <h6 class="fw-bold small text-muted mb-2">Ultimos Pagos Recibidos</h6>
            <div class="table-responsive">
                <table class="table table-sm align-middle small mb-0">
                    <thead class="table-light">
                        <tr><th>Fecha</th><th>Factura</th><th>Paciente</th><th>Metodo</th><th class="text-end">Monto</th></tr>
                    </thead>
                    <tbody>
                        <c:forEach var="pg" items="${pagosRecientes}" begin="0" end="4">
                            <tr>
                                <td>${pg.fechaPago}</td>
                                <td class="fw-semibold">${pg.numeroFactura}</td>
                                <td>${pg.paciente}</td>
                                <td>${pg.metodo}</td>
                                <td class="text-end text-success fw-bold">L. ${pg.monto}</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty pagosRecientes}">
                            <tr><td colspan="5" class="text-center text-muted py-2">Aun no se han registrado pagos.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- LISTADO GENERAL DE FACTURAS EMITIDAS -->
<div class="card card-modern p-4 no-print">
    <h5 class="fw-bold mb-3">Historial de Facturas Emitidas</h5>
    <div class="table-responsive">
        <table class="table table-hover align-middle small mb-0">
            <thead class="table-light">
                <tr>
                    <th>No. Factura</th>
                    <th>Periodo</th>
                    <th>Paciente</th>
                    <th>Plan</th>
                    <th class="text-center">Evaluaciones</th>
                    <th class="text-end">Total</th>
                    <th class="text-end">Pagado</th>
                    <th class="text-end">Saldo</th>
                    <th>Estado</th>
                    <th class="text-end">Accion</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="f" items="${facturas}">
                    <tr>
                        <td class="fw-bold">${f.numeroFactura}</td>
                        <td>${f.periodoMes}/${f.periodoAnio}</td>
                        <td class="fw-semibold">${f.paciente}</td>
                        <td>${f.planNombre}</td>
                        <td class="text-center">
                            <span class="badge bg-info-subtle text-dark">${f.evalAdjuntas} adjunta(s) (${f.sesionesRealizadas}/${f.sesionesPlan})</span>
                        </td>
                        <td class="text-end fw-semibold">L. ${f.total}</td>
                        <td class="text-end text-success">L. ${f.pagado}</td>
                        <td class="text-end text-danger fw-semibold">L. ${f.saldo}</td>
                        <td>
                            <span class="badge ${f.estado == 'PAGADA' ? 'bg-success' : (f.estado == 'PARCIAL' ? 'bg-warning text-dark' : 'bg-danger')}">
                                ${f.estado}
                            </span>
                        </td>
                        <td class="text-end">
                            <a href="${pageContext.request.contextPath}/facturacion?verFactura=${f.idFactura}" class="btn btn-outline-primary btn-sm py-0 px-2">
                                <i class="bi bi-eye"></i> Ver / Imprimir
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty facturas}">
                    <tr><td colspan="10" class="text-center text-muted py-3">Aun no hay facturas emitidas.</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>

<script>
const mesFiltro = ${mesActual};
const anioFiltro = ${anioActual};
const evaluacionesDisponibles = [
    <c:forEach var="ev" items="${evaluacionesImportables}" varStatus="st">
    {
        idRegistro: "${ev.idRegistro}",
        idPaciente: "${ev.idPaciente}",
        fecha: "${ev.fecha}",
        mesAct: ${ev.mesAct},
        anioAct: ${ev.anioAct},
        actividad: "${fn:escapeXml(ev.actividad)}",
        categoria: "${fn:escapeXml(ev.categoria)}",
        especialista: "${fn:escapeXml(ev.especialista)}",
        nivelAvance: "${fn:escapeXml(ev.nivelAvance)}",
        observaciones: "${fn:escapeXml(ev.observaciones)}"
    }<c:if test="${!st.last}">,</c:if>
    </c:forEach>
];

function cargarEvaluacionesPaciente(modo) {
    const sel = document.getElementById('selectMatriculaFact');
    const cont = document.getElementById('contenedorEvaluacionesImportadas');
    if (!sel.value) {
        cont.innerHTML = '<span class="text-muted">Seleccione un paciente para cargar las evaluaciones realizadas por su especialista.</span>';
        return;
    }
    const idPac = sel.options[sel.selectedIndex].getAttribute('data-id-paciente');
    let filtradas = evaluacionesDisponibles.filter(e => e.idPaciente === idPac);
    if (modo === 'MES') {
        filtradas = filtradas.filter(e => e.mesAct === mesFiltro && e.anioAct === anioFiltro);
    }

    if (filtradas.length === 0) {
        cont.innerHTML = '<span class="text-muted">No se encontraron evaluaciones del especialista para este paciente en el filtro seleccionado. Prueba con "Cargar Todas".</span>';
        return;
    }

    let html = '<div class="table-responsive" style="max-height: 180px; overflow-y: auto;">'
             + '<table class="table table-sm table-bordered bg-white mb-0 small">'
             + '<thead class="table-light"><tr><th style="width:28px;">Inc.</th><th>Fecha</th><th>Actividad</th><th>Especialista</th><th>Avance</th></tr></thead><tbody>';
    filtradas.forEach(ev => {
        html += '<tr>'
              + '<td class="text-center"><input type="checkbox" name="idEvaluacion" value="' + ev.idRegistro + '" checked></td>'
              + '<td>' + ev.fecha + '</td>'
              + '<td class="fw-semibold">' + ev.actividad + '</td>'
              + '<td>' + ev.especialista + '</td>'
              + '<td><span class="badge bg-info-subtle text-dark">' + ev.nivelAvance + '</span></td>'
              + '</tr>';
    });
    html += '</tbody></table></div>';
    cont.innerHTML = html;
}

function actualizarResumenYEvaluaciones() {
    const sel = document.getElementById('selectMatriculaFact');
    const box = document.getElementById('resumenSeleccionFact');
    if (!sel.value) {
        box.classList.add('d-none');
        cargarEvaluacionesPaciente('MES');
        return;
    }
    const opt = sel.options[sel.selectedIndex];
    box.innerHTML = '<strong>Encargado:</strong> ' + opt.getAttribute('data-encargado')
        + ' | <strong>Plan:</strong> ' + opt.getAttribute('data-plan')
        + ' (L. ' + opt.getAttribute('data-monto') + ')'
        + ' | <strong>Sesiones en Reporte del Mes:</strong> ' + opt.getAttribute('data-sesiones-rep')
        + ' de ' + opt.getAttribute('data-sesiones-plan') + ' contratadas.';
    box.classList.remove('d-none');
    cargarEvaluacionesPaciente('MES');
}

function autocompletarSaldo() {
    const sel = document.getElementById('selectFacturaPago');
    const input = document.getElementById('inputMontoPago');
    if (!sel.value) return;
    const opt = sel.options[sel.selectedIndex];
    input.value = opt.getAttribute('data-saldo');
}

document.addEventListener('DOMContentLoaded', actualizarResumenYEvaluaciones);
</script>
<%@ include file="layout_footer.jsp" %>
