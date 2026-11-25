<%@ include file="layout_header.jsp" %>
<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h3 class="fw-bold mb-0">Panel Principal <span class="badge bg-secondary fs-6 align-middle">v2.0.6</span></h3>
        <p class="text-muted mb-0">Bienvenido, ${sessionScope.usuarioLogueado.nombreCompleto} (${sessionScope.usuarioLogueado.nombreRol})</p>
    </div>
    <span class="badge bg-primary-subtle text-primary px-3 py-2 rounded-pill"><i class="bi bi-database-check me-1"></i> SQL Server Conectado</span>
</div>

<c:if test="${not empty sessionScope.errorAcceso}">
    <div class="alert alert-danger alert-dismissible fade show">
        <i class="bi bi-shield-exclamation me-2"></i>${sessionScope.errorAcceso}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <c:remove var="errorAcceso" scope="session" />
</c:if>

<c:if test="${not empty errorDashboard}">
    <div class="alert alert-warning small">${errorDashboard}</div>
</c:if>

<!-- Tarjetas KPI con acceso directo a cada modulo segun rol -->
<div class="row g-4 mb-4">
    <div class="col-md-6 col-xl-3">
        <div class="card card-modern p-3 h-100 d-flex flex-column justify-content-between">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <small class="text-muted">Pacientes Registrados</small>
                    <h2 class="fw-bold mb-0 text-primary">${totalPacientes}</h2>
                </div>
                <i class="bi bi-people-fill fs-1 text-primary opacity-25"></i>
            </div>
            <div class="mt-3 pt-2 border-top">
                <c:choose>
                    <c:when test="${esAdmin || u.tienePermiso('MATRICULAR_PACIENTES')}">
                        <a href="${pageContext.request.contextPath}/matriculas" class="text-decoration-none small fw-semibold">
                            Ir a Matriculas <i class="bi bi-arrow-right"></i>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <span class="small text-muted">Pacientes activos en clinica</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-xl-3">
        <div class="card card-modern p-3 h-100 d-flex flex-column justify-content-between">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <small class="text-muted">Especialistas Registrados</small>
                    <h2 class="fw-bold mb-0 text-info">${totalEspecialistas}</h2>
                </div>
                <i class="bi bi-person-badge-fill fs-1 text-info opacity-25"></i>
            </div>
            <div class="mt-3 pt-2 border-top">
                <c:choose>
                    <c:when test="${esAdmin || u.tienePermiso('GESTIONAR_USUARIOS')}">
                        <a href="${pageContext.request.contextPath}/usuarios" class="text-decoration-none small fw-semibold text-info">
                            Ver Usuarios y Especialistas <i class="bi bi-arrow-right"></i>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <span class="small text-muted">Psicologos y Pedagogos</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-xl-3">
        <div class="card card-modern p-3 h-100 d-flex flex-column justify-content-between">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <small class="text-muted">Planes Activos</small>
                    <h2 class="fw-bold mb-0 text-success">${planesActivos}</h2>
                </div>
                <i class="bi bi-tags-fill fs-1 text-success opacity-25"></i>
            </div>
            <div class="mt-3 pt-2 border-top">
                <c:choose>
                    <c:when test="${esAdmin || u.tienePermiso('GESTIONAR_PLANES')}">
                        <a href="${pageContext.request.contextPath}/planes" class="text-decoration-none small fw-semibold text-success">
                            Administrar Planes <i class="bi bi-arrow-right"></i>
                        </a>
                    </c:when>
                    <c:otherwise>
                        <span class="small text-muted">Planes terapeuticos vigentes</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-xl-3">
        <div class="card card-modern p-3 h-100 d-flex flex-column justify-content-between">
            <div>
                <small class="text-muted">Proxima Fecha en Calendario</small>
                <c:choose>
                    <c:when test="${not empty proximoEvento}">
                        <h6 class="fw-bold mb-1 mt-1 text-truncate" title="${proximoEvento.titulo}">${proximoEvento.titulo}</h6>
                        <div class="small text-primary fw-semibold"><i class="bi bi-calendar-event me-1"></i>${proximoEvento.fecha}</div>
                        <span class="badge bg-light text-dark border mt-1">${proximoEvento.tipo}</span>
                    </c:when>
                    <c:otherwise>
                        <p class="small text-muted mb-0 mt-1">Sin eventos proximos programados.</p>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="mt-3 pt-2 border-top">
                <c:if test="${esAdmin || u.tienePermiso('GESTIONAR_CALENDARIO')}">
                    <a href="${pageContext.request.contextPath}/calendario" class="text-decoration-none small fw-semibold text-danger">
                        Abrir Calendario Completo <i class="bi bi-arrow-right"></i>
                    </a>
                </c:if>
            </div>
        </div>
    </div>
</div>

<!-- Seccion detallada: Horas cubiertas por especialista + Accesos rapidos -->
<div class="row g-4">
    <div class="col-lg-8">
        <div class="card card-modern p-4 h-100">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="fw-bold mb-0"><i class="bi bi-clock-history text-primary me-2"></i>Horas Cubiertas por Especialista</h5>
                <c:if test="${esAdmin || u.tienePermiso('MATRICULAR_PACIENTES')}">
                    <a href="${pageContext.request.contextPath}/matriculas" class="btn btn-sm btn-outline-primary">
                        Ver Matriculas y Horarios <i class="bi bi-box-arrow-up-right ms-1"></i>
                    </a>
                </c:if>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle small mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>Especialista</th>
                            <th>Especialidad</th>
                            <th>Bloques Ocupados</th>
                            <th>Horas Cubiertas</th>
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="e" items="${horasEspecialistas}">
                            <tr>
                                <td class="fw-semibold">${e.nombre}</td>
                                <td>${e.especialidad}</td>
                                <td>${e.bloquesOcupados} / ${e.bloquesTotales}</td>
                                <td><span class="badge bg-primary-subtle text-primary fs-6">${e.horasCubiertas} hrs</span></td>
                                <td><span class="badge ${e.activo ? 'bg-success' : 'bg-secondary'}">${e.activo ? 'Activo' : 'Inactivo'}</span></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty horasEspecialistas}">
                            <tr><td colspan="5" class="text-center text-muted py-3">No hay especialistas registrados.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="col-lg-4">
        <div class="card card-modern p-4 h-100">
            <h5 class="fw-bold mb-3"><i class="bi bi-grid-fill text-info me-2"></i>Accesos Directos (${u.nombreRol})</h5>
            <div class="d-grid gap-2">
                <c:if test="${esAdmin || u.tienePermiso('REGISTRAR_ACTIVIDADES')}">
                    <a href="${pageContext.request.contextPath}/actividades" class="btn btn-outline-primary text-start d-flex justify-content-between align-items-center">
                        <span><i class="bi bi-puzzle me-2"></i>Registro de Actividades</span>
                        <i class="bi bi-chevron-right"></i>
                    </a>
                </c:if>
                <c:if test="${esAdmin || u.tienePermiso('VER_REPORTES')}">
                    <a href="${pageContext.request.contextPath}/reportes" class="btn btn-outline-success text-start d-flex justify-content-between align-items-center">
                        <span><i class="bi bi-file-earmark-bar-graph me-2"></i>Reportes Semanal / Mensual / 6M</span>
                        <i class="bi bi-chevron-right"></i>
                    </a>
                </c:if>
                <c:if test="${esAdmin || u.tienePermiso('GESTIONAR_FACTURACION') || u.nombreRol == 'RECEPCION'}">
                    <a href="${pageContext.request.contextPath}/facturacion" class="btn btn-outline-warning text-dark text-start d-flex justify-content-between align-items-center">
                        <span><i class="bi bi-receipt-cutoff me-2"></i>Facturacion y Pagos</span>
                        <i class="bi bi-chevron-right"></i>
                    </a>
                </c:if>
                <c:if test="${esAdmin || u.tienePermiso('GESTIONAR_CALENDARIO')}">
                    <a href="${pageContext.request.contextPath}/calendario" class="btn btn-outline-danger text-start d-flex justify-content-between align-items-center">
                        <span><i class="bi bi-calendar-event me-2"></i>Reservas y Celebraciones</span>
                        <i class="bi bi-chevron-right"></i>
                    </a>
                </c:if>
                <c:if test="${esAdmin || u.tienePermiso('CONFIGURAR_SEGURIDAD')}">
                    <a href="${pageContext.request.contextPath}/seguridad" class="btn btn-outline-dark text-start d-flex justify-content-between align-items-center">
                        <span><i class="bi bi-shield-lock me-2"></i>Hardening y Autobloqueo</span>
                        <i class="bi bi-chevron-right"></i>
                    </a>
                </c:if>
            </div>
        </div>
    </div>
</div>
<%@ include file="layout_footer.jsp" %>
