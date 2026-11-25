# Sistema de Gestion Terapeutica Infantil (Java Web + Azure SQL + Render)

Proyecto Maven Java Web (Jakarta EE 10 / Tomcat 10.1 / Java 17) listo para abrir en **Apache NetBeans** y desplegar en **Render**.

## 1. Configurar Base de Datos en Azure SQL Server
1. Crea una base de datos en **Azure SQL Database** (ej. `TerapiaInfantilDB`).
2. En el Firewall de Azure SQL, habilita tu IP local y marca **"Permitir que los servicios y recursos de Azure accedan a este servidor"**.
3. Ejecuta el script `database/schema_azure_sql.sql` desde Azure Data Studio o SSMS.
4. Credenciales iniciales de prueba:
   - **Usuario:** `admin`
   - **Contraseña:** `Admin@2026!Secure`

## 2. Ejecutar localmente en Apache NetBeans
1. Abre Apache NetBeans -> `File` -> `Open Project` -> selecciona la carpeta `SistemaTerapiaInfantil`.
2. Edita `src/main/java/hn/terapia/config/DBConnection.java` con tu cadena JDBC, usuario y contraseña de Azure SQL (o configuralos como variables de entorno `DB_URL`, `DB_USER`, `DB_PASSWORD`).
3. Asigna **Apache Tomcat 10.1+** en `Properties -> Run -> Server`.
4. Haz clic en **Run** (F6).

## 3. Desplegar en Render
1. Sube este proyecto a un repositorio de GitHub.
2. En [Render](https://render.com), crea un nuevo **Web Service** conectado a tu repositorio (detectara automaticamente el `Dockerfile`).
3. En la pestaña **Environment**, agrega las variables:
   - `DB_URL`: tu cadena JDBC de Azure SQL Server
   - `DB_USER`: tu usuario de Azure SQL
   - `DB_PASSWORD`: tu contraseña de Azure SQL
4. Haz clic en **Deploy**.
