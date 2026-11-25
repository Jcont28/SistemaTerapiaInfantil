<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="u" value="${sessionScope.usuarioLogueado}" />
<c:set var="esAdmin" value="${u.nombreRol == 'ADMIN'}" />
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Centro Terapeutico Infantil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <nav class="col-md-3 col-lg-2 sidebar p-3">
            <div class="d-flex align-items-center gap-2 mb-3 px-2">
                <i class="bi bi-heart-pulse-fill text-info fs-3"></i>
                <div>
                    <h6 class="mb-0 text-white fw-bold">Terapia Infantil</h6>
                    <small class="text-secondary">Gestion Clinica</small>
                </div>
            </div>
            <div class="px-2 mb-3">
                <span class="badge bg-primary-subtle text-primary w-100 py-1">
                    <i class="bi bi-person-badge me-1"></i> Rol: ${u.nombreRol}
                </span>
            </div>

            <a href="${pageContext.request.contextPath}/dashboard"><i class="bi bi-speedometer2"></i> Dashboard</a>

            <c:if test="${esAdmin || u.tienePermiso('MATRICULAR_PACIENTES')}">
                <a href="${pageContext.request.contextPath}/matriculas"><i class="bi bi-person-plus"></i> Matriculas</a>
            </c:if>

            <c:if test="${esAdmin || u.tienePermiso('GESTIONAR_PLANES')}">
                <a href="${pageContext.request.contextPath}/planes"><i class="bi bi-tags"></i> Planes y Precios</a>
            </c:if>

            <c:if test="${esAdmin || u.tienePermiso('REGISTRAR_ACTIVIDADES')}">
                <a href="${pageContext.request.contextPath}/actividades"><i class="bi bi-puzzle"></i> Actividades</a>
            </c:if>

            <c:if test="${esAdmin || u.tienePermiso('VER_REPORTES')}">
                <a href="${pageContext.request.contextPath}/reportes"><i class="bi bi-file-earmark-bar-graph"></i> Reportes</a>
            </c:if>

            <c:if test="${esAdmin || u.tienePermiso('GESTIONAR_FACTURACION') || u.nombreRol == 'RECEPCION'}">
                <a href="${pageContext.request.contextPath}/facturacion"><i class="bi bi-receipt-cutoff"></i> Facturacion y Pagos</a>
            </c:if>

            <c:if test="${esAdmin || u.tienePermiso('GESTIONAR_CALENDARIO')}">
                <a href="${pageContext.request.contextPath}/calendario"><i class="bi bi-calendar-event"></i> Calendario</a>
            </c:if>

            <c:if test="${esAdmin || u.tienePermiso('GESTIONAR_USUARIOS') || u.tienePermiso('CONFIGURAR_SEGURIDAD')}">
                <hr class="border-secondary">
            </c:if>

            <c:if test="${esAdmin || u.tienePermiso('GESTIONAR_USUARIOS')}">
                <a href="${pageContext.request.contextPath}/usuarios"><i class="bi bi-people"></i> Usuarios y Roles</a>
            </c:if>

            <c:if test="${esAdmin || u.tienePermiso('CONFIGURAR_SEGURIDAD')}">
                <a href="${pageContext.request.contextPath}/seguridad"><i class="bi bi-shield-lock"></i> Seguridad</a>
            </c:if>

            <a href="${pageContext.request.contextPath}/logout" class="text-danger mt-4"><i class="bi bi-box-arrow-left"></i> Cerrar Sesion</a>
        </nav>
        <main class="col-md-9 col-lg-10 p-4">
