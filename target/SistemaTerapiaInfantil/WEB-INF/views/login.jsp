<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acceso Seguro | Centro Terapeutico Infantil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet">
</head>
<body>
<div class="login-wrapper p-3">
    <div class="login-card">
        <div class="text-center mb-4">
            <div class="bg-primary bg-opacity-10 text-primary rounded-circle d-inline-flex p-3 mb-2">
                <i class="bi bi-shield-check fs-2"></i>
            </div>
            <h4 class="fw-bold mb-1">Centro Terapeutico Infantil</h4>
            <p class="text-muted small">Acceso protegido con Hardening y Autobloqueo</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger d-flex align-items-center small" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                <div>${error}</div>
            </div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/login" autocomplete="off">
            <div class="mb-3">
                <label class="form-label fw-semibold small">Usuario</label>
                <div class="input-group">
                    <span class="input-group-text bg-light"><i class="bi bi-person"></i></span>
                    <input type="text" name="username" class="form-control" placeholder="Ej. admin" required autofocus>
                </div>
            </div>
            <div class="mb-4">
                <label class="form-label fw-semibold small">Contraseña</label>
                <div class="input-group">
                    <span class="input-group-text bg-light"><i class="bi bi-lock"></i></span>
                    <input type="password" name="password" id="passInput" class="form-control" placeholder="••••••••••••" required>
                    <button class="btn btn-outline-secondary" type="button" onclick="const i=document.getElementById('passInput'); i.type=i.type==='password'?'text':'password';">
                        <i class="bi bi-eye"></i>
                    </button>
                </div>
            </div>
            <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold rounded-3">
                <i class="bi bi-box-arrow-in-right me-1"></i> Iniciar Sesion
            </button>
        </form>
        <div class="text-center mt-4 text-muted" style="font-size: 0.78rem;">
            <i class="bi bi-lock-fill text-success"></i> Sesion cifrada &bull; Proteccion contra fuerza bruta activa
        </div>
    </div>
</div>
</body>
</html>
