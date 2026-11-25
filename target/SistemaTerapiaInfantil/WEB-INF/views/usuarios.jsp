<%@ include file="layout_header.jsp" %>
<h3 class="fw-bold mb-3">Gestion de Usuarios, Roles y Permisos</h3>
<c:if test="${not empty mensaje}"><div class="alert alert-success">${mensaje}</div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

<div class="row g-4">
    <div class="col-lg-4">
        <div class="card card-modern p-4">
            <h5 class="fw-bold mb-3">Crear Nuevo Usuario</h5>
            <form method="post" action="${pageContext.request.contextPath}/usuarios">
                <input type="hidden" name="accion" value="crear">
                <div class="mb-2"><label class="form-label small">Nombre Completo</label><input type="text" name="nombreCompleto" class="form-control" required></div>
                <div class="mb-2"><label class="form-label small">Usuario</label><input type="text" name="username" class="form-control" required></div>
                <div class="mb-2"><label class="form-label small">Correo Electronico</label><input type="email" name="email" class="form-control" required></div>
                <div class="mb-2">
                    <label class="form-label small">Rol</label>
                    <select name="idRol" class="form-select">
                        <option value="1">ADMIN</option>
                        <option value="2">PSICOLOGO</option>
                        <option value="3">PEDAGOGO</option>
                        <option value="4">RECEPCION</option>
                    </select>
                </div>
                <div class="mb-2">
                    <label class="form-label small">Especialidad (si aplica)</label>
                    <select name="especialidad" class="form-select">
                        <option value="">Ninguna</option>
                        <option value="Psicologo">Psicologo</option>
                        <option value="Pedagogo">Pedagogo</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label small">Contraseña (Min. ${config.minLongitudPassword} caracteres)</label>
                    <input type="password" name="password" class="form-control" required>
                </div>
                <button class="btn btn-primary w-100">Guardar Usuario</button>
            </form>
        </div>
    </div>

    <div class="col-lg-8">
        <div class="card card-modern p-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="fw-bold mb-0">Usuarios Registrados</h5>
                <small class="text-muted"><i class="bi bi-info-circle"></i> Los usuarios se activan/desactivan sin eliminarse.</small>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle small">
                    <thead class="table-light">
                        <tr><th>Nombre / Correo</th><th>Usuario</th><th>Rol / Esp.</th><th>Estado</th><th>Acciones</th></tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${usuarios}">
                            <tr class="${u.activo ? '' : 'table-secondary text-muted'}">
                                <td>
                                    <div class="fw-semibold">${u.nombreCompleto}</div>
                                    <small class="text-muted">${u.email}</small>
                                </td>
                                <td>${u.username}</td>
                                <td>
                                    <span class="badge bg-primary">${u.nombreRol}</span>
                                    <c:if test="${not empty u.especialidad}">
                                        <div class="small text-muted">${u.especialidad}</div>
                                    </c:if>
                                </td>
                                <td><span class="badge ${u.activo ? 'bg-success' : 'bg-secondary'}">${u.activo ? 'Activo' : 'Inactivo'}</span></td>
                                <td class="text-nowrap">
                                    <button type="button" class="btn btn-sm btn-outline-primary me-1"
                                            data-bs-toggle="modal" data-bs-target="#modalEditarUsuario"
                                            data-id="${u.idUsuario}"
                                            data-nombre="${u.nombreCompleto}"
                                            data-email="${u.email}"
                                            data-rol="${u.idRol}"
                                            data-esp="${u.especialidad}"
                                            onclick="cargarModalEditar(this)">
                                        <i class="bi bi-pencil-square"></i> Editar
                                    </button>
                                    <form method="post" action="${pageContext.request.contextPath}/usuarios" class="d-inline">
                                        <input type="hidden" name="accion" value="toggleEstado">
                                        <input type="hidden" name="idUsuario" value="${u.idUsuario}">
                                        <input type="hidden" name="nuevoEstado" value="${!u.activo}">
                                        <button type="submit" class="btn btn-sm ${u.activo ? 'btn-outline-warning' : 'btn-outline-success'}">
                                            <i class="bi ${u.activo ? 'bi-person-slash' : 'bi-person-check'}"></i>
                                            ${u.activo ? 'Desactivar' : 'Activar'}
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

<!-- Modal Editar Usuario -->
<div class="modal fade" id="modalEditarUsuario" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="post" action="${pageContext.request.contextPath}/usuarios">
                <input type="hidden" name="accion" value="editar">
                <input type="hidden" name="idUsuario" id="editIdUsuario">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold">Editar Usuario</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-2">
                        <label class="form-label small">Nombre Completo</label>
                        <input type="text" name="nombreCompleto" id="editNombre" class="form-control" required>
                    </div>
                    <div class="mb-2">
                        <label class="form-label small">Correo Electronico</label>
                        <input type="email" name="email" id="editEmail" class="form-control" required>
                    </div>
                    <div class="mb-2">
                        <label class="form-label small">Rol</label>
                        <select name="idRol" id="editRol" class="form-select" required>
                            <option value="1">ADMIN</option>
                            <option value="2">PSICOLOGO</option>
                            <option value="3">PEDAGOGO</option>
                            <option value="4">RECEPCION</option>
                        </select>
                    </div>
                    <div class="mb-2">
                        <label class="form-label small">Especialidad</label>
                        <select name="especialidad" id="editEsp" class="form-select">
                            <option value="">Ninguna</option>
                            <option value="Psicologo">Psicologo</option>
                            <option value="Pedagogo">Pedagogo</option>
                        </select>
                    </div>
                    <div class="mb-2">
                        <label class="form-label small">Nueva Contraseña (dejar en blanco para mantener la actual)</label>
                        <input type="password" name="password" id="editPassword" class="form-control" placeholder="Opcional">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
function cargarModalEditar(btn) {
    document.getElementById('editIdUsuario').value = btn.getAttribute('data-id');
    document.getElementById('editNombre').value = btn.getAttribute('data-nombre');
    document.getElementById('editEmail').value = btn.getAttribute('data-email');
    document.getElementById('editRol').value = btn.getAttribute('data-rol');
    document.getElementById('editEsp').value = btn.getAttribute('data-esp') || '';
    document.getElementById('editPassword').value = '';
}
</script>
<%@ include file="layout_footer.jsp" %>
