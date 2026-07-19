# 🏆 Tornevia — Sistema Integrado de Gestión de Competiciones Deportivas

<p align="center">
  <img src="https://img.shields.io/badge/.NET-8.0-512BD4?logo=dotnet&logoColor=white" alt=".NET 8">
  <img src="https://img.shields.io/badge/Blazor-Server-512BD4?logo=blazor&logoColor=white" alt="Blazor Server">
  <img src="https://img.shields.io/badge/C%23-239120?logo=csharp&logoColor=white" alt="C#">
  <img src="https://img.shields.io/badge/SQL_Server-Azure_SQL-CC2927?logo=microsoftsqlserver&logoColor=white" alt="SQL Server">
  <img src="https://img.shields.io/badge/Entity_Framework_Core-8.0-512BD4" alt="EF Core 8">
  <img src="https://img.shields.io/badge/Hosted_on-Azure_App_Service-0078D4?logo=microsoftazure&logoColor=white" alt="Azure App Service">
  <img src="https://img.shields.io/badge/license-MIT-green" alt="MIT License">
</p>

<p align="center">
  Plataforma web para la organización de ligas, copas y torneos de fútbol amateur: registro de equipos y jugadores, programación de partidos, estadísticas en tiempo real, tablas de posiciones automáticas y noticias.
</p>

<p align="center">
  <a href="https://tornevia-web-aldoquiroz-awbxhaaddqcdcufv.mexicocentral-01.azurewebsites.net"><strong>🔗 Ver demo en vivo</strong></a>
</p>

---

## 📑 Tabla de contenidos

- [Descripción](#-descripción)
- [Demo en vivo](#-demo-en-vivo)
- [Características principales](#-características-principales)
- [Stack tecnológico](#-stack-tecnológico)
- [Arquitectura](#-arquitectura)
- [Modelo de datos](#-modelo-de-datos)
- [Estructura del proyecto](#-estructura-del-proyecto)
- [Requisitos previos](#-requisitos-previos)
- [Instalación y ejecución local](#-instalación-y-ejecución-local)
- [Roles y permisos](#-roles-y-permisos)
- [Requerimientos funcionales y no funcionales](#-requerimientos-funcionales-y-no-funcionales)
- [Seguridad](#-seguridad)
- [Limitaciones conocidas](#-limitaciones-conocidas)
- [Licencia](#-licencia)
- [Autor](#-autor)

---

## 📖 Descripción

El fútbol amateur en Chile suele organizarse mediante herramientas informales (grupos de WhatsApp, planillas Excel, páginas de Facebook), lo que genera desorden, pérdida de información y poca transparencia en los resultados.

**Tornevia** resuelve este problema centralizando toda la gestión de una liga, copa o torneo en una única plataforma web, responsive y con dos perfiles de usuario claramente diferenciados: **Administrador de Liga** y **Jugador/Equipo**.

## 🚀 Demo en vivo

| | |
|---|---|
| **URL del sistema** | [tornevia-web-aldoquiroz-awbxhaaddqcdcufv.mexicocentral-01.azurewebsites.net](https://tornevia-web-aldoquiroz-awbxhaaddqcdcufv.mexicocentral-01.azurewebsites.net) |
| **Acceso directo al login** | [/login](https://tornevia-web-aldoquiroz-awbxhaaddqcdcufv.mexicocentral-01.azurewebsites.net/login) |

**Credenciales de prueba** (cargadas con datos reales de demostración):

| Rol | Correo | Contraseña |
|---|---|---|
| Administrador de Liga | `admin@tornevia.cl` | `88888888` |
| Jugador | `carlos.perez@correo.com` | `88888888` |

> ⚠️ **Nota:** el sistema está alojado en el plan gratuito de Azure App Service (**F1**), que no cuenta con la función *Always On*. Si la aplicación lleva ~20 minutos sin tráfico, "duerme" y el primer ingreso puede demorar unos segundos mientras se reactiva. Se recomienda cargar la URL, esperar un par de minutos y luego iniciar sesión.

## ✨ Características principales

- 🔐 **Autenticación y perfiles diferenciados** por rol (Administrador / Jugador), con contraseñas cifradas mediante `PasswordHasher` de ASP.NET Identity.
- 👥 **Gestión de equipos y jugadores**: alta, edición y eliminación, con validación de nombres duplicados.
- 🏆 **Gestión de torneos, ligas y copas**: creación, inscripción de equipos y control del ciclo de vida.
- 📅 **Programación de partidos** con validación de conflictos de horario y de equipos duplicados.
- 📊 **Estadísticas en tiempo real**: goles, asistencias, tarjetas y minutos jugados, con actualización automática del marcador y de la tabla de posiciones.
- 🗓️ **Calendario** de partidos programados, en juego y finalizados.
- 📰 **Módulo de noticias** para comunicados de la liga.
- 📱 **Diseño responsive** construido con HTML y CSS puro (sin frameworks de estilos).
- ☁️ **Desplegado en producción** en Azure App Service con base de datos Azure SQL.

## 🛠 Stack tecnológico

| Capa | Tecnología |
|---|---|
| Frontend / UI | Blazor Server (.NET 8), componentes `.razor`, CSS puro |
| Backend / lógica de negocio | C#, arquitectura orientada a objetos |
| Acceso a datos | Entity Framework Core 8 (`TorneviaDbContext`) |
| Base de datos | SQL Server / Azure SQL Database (3FN, 8 tablas relacionadas) |
| Autenticación | `PasswordHasher` de ASP.NET Identity |
| Hosting | Azure App Service (Windows, plan Free F1) + Azure SQL Database |
| Control de versiones | Git / GitHub |

## 🏗 Arquitectura

El sistema sigue una arquitectura por capas orientada a objetos:

```
┌─────────────────────────────────────────────────────────────────────────┐
│  Presentación   → Blazor Server (.razor + CSS responsive)
├─────────────────────────────────────────────────────────────────────────┤
│  Lógica de negocio → C# (SesionUsuario, PasswordHasherService)
├─────────────────────────────────────────────────────────────────────────┤
│  Acceso a datos → Entity Framework Core (TorneviaDbContext)
├─────────────────────────────────────────────────────────────────────────┤
│  Base de datos → SQL Server / Azure SQL Database
└─────────────────────────────────────────────────────────────────────────┘
```

## 🗂 Modelo de datos

Base de datos relacional normalizada hasta **Tercera Forma Normal (3FN)**, compuesta por 8 entidades:

`Usuarios` · `Torneos` · `Equipos` · `Torneo_Equipo` · `Jugadores` · `Partidos` · `Estadisticas` · `Noticias`

El script de creación de la base de datos se encuentra en [`Database/TorneviaBD_script.sql`](Database/TorneviaBD_script.sql).

## 📁 Estructura del proyecto

```
TorneviaWeb/
├── Components/
│   ├── Layout/          # MainLayout y estilos globales
│   ├── Pages/            # Páginas Blazor (Login, Registro, GestionEquipos,
│   │                     #  GestionTorneos, GestionPartidos, GestionEstadisticas,
│   │                     #  GestionNoticias, Calendario, MiPerfil, MisEstadisticas...)
│   └── Shared/            # Componentes reutilizables (p. ej. LogoTornevia)
├── Models/                # Entidades, DbContext y servicios (Password, Sesión)
├── Database/               # Script SQL de creación de la base de datos
├── wwwroot/                # CSS estático (tornevia.css) y recursos públicos
├── Program.cs              # Configuración y punto de entrada de la app
└── TorneviaWeb.csproj
```

## ✅ Requisitos previos

- [.NET 8 SDK](https://dotnet.microsoft.com/download/dotnet/8.0)
- SQL Server Express / LocalDB o Azure SQL Database
- Visual Studio 2022 o superior (recomendado) o VS Code

## ⚙️ Instalación y ejecución local

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/AldoQuiroz/TorneviaWeb.git
   cd TorneviaWeb
   ```

2. **Crear la base de datos** ejecutando el script [`Database/TorneviaBD_script.sql`](Database/TorneviaBD_script.sql) en tu instancia de SQL Server.

3. **Configurar la cadena de conexión** en `appsettings.json` (o mediante `appsettings.Development.json` / *user secrets* para no versionar credenciales):
   ```json
   {
     "ConnectionStrings": {
       "TorneviaConnection": "Server=localhost;Database=TorneviaBD;Trusted_Connection=True;TrustServerCertificate=True;"
     }
   }
   ```

4. **Restaurar dependencias y ejecutar**
   ```bash
   dotnet restore
   dotnet run
   ```

5. Abrir el navegador en la URL indicada en la consola (por defecto `https://localhost:5001` o similar).

## 👤 Roles y permisos

| Acción | Administrador de Liga | Jugador |
|---|:---:|:---:|
| Crear/editar torneos, ligas y copas | ✅ | ❌ |
| Registrar y editar equipos/jugadores | ✅ | ❌ |
| Programar partidos | ✅ | ❌ |
| Ingresar estadísticas | ✅ | ❌ |
| Publicar noticias | ✅ | ❌ |
| Consultar resultados, calendario y estadísticas | ✅ | ✅ |
| Ver estadísticas personales acumuladas | ➖ | ✅ |

El control de acceso se implementa mediante **RBAC** (Role-Based Access Control) a través del servicio `SesionUsuario`.

## 📋 Requerimientos funcionales y no funcionales

<details>
<summary><strong>Ver Requerimientos Funcionales (RF)</strong></summary>

| ID | Descripción |
|---|---|
| RF-01 | Registro de equipos con datos básicos (nombre, logo, categoría) |
| RF-02 | Registro de jugadores asociados a cada equipo |
| RF-03 | Creación y programación de copas, ligas y torneos |
| RF-04 | Ingreso de estadísticas de partidos (goles, asistencias, tarjetas) |
| RF-05 | Generación automática de tablas de posiciones |
| RF-06 | Publicación de noticias y comunicados |
| RF-07 | Perfiles diferenciados: Administrador de Liga y Jugador/Equipo |
| RF-08 | Visualización pública de resultados y estadísticas a usuarios logeados |
| RF-09 | Gestión de usuarios (login, recuperación de contraseña, ver perfil) |
| RF-10 | Gestión del estado del partido (programado, en juego, finalizado) |

</details>

<details>
<summary><strong>Ver Requerimientos No Funcionales (RNF)</strong></summary>

| ID | Descripción |
|---|---|
| RNF-01 | Sistema responsive y adaptable a dispositivos móviles |
| RNF-02 | Seguridad en el acceso: autenticación y cifrado de contraseñas |
| RNF-03 | Escalabilidad para soportar múltiples ligas y usuarios |
| RNF-04 | Disponibilidad en hosting confiable con uptime superior al 99% |
| RNF-05 | Usabilidad intuitiva con navegación clara y diseño accesible |
| RNF-06 | Rendimiento óptimo: carga de páginas en menos de 7 segundos |
| RNF-07 | Mantenibilidad: código organizado y respaldado en GitHub |

</details>

## 🔒 Seguridad

- Contraseñas cifradas con hash seguro (`PasswordHasher` de ASP.NET Identity), nunca almacenadas en texto plano.
- HTTPS forzado en producción (`UseHttpsRedirection` + `UseHsts`).
- Autorización por rol (RBAC) para restringir el acceso a los módulos administrativos.
- Cumplimiento de la Ley N° 19.628 sobre Protección de la Vida Privada y su actualización mediante la Ley N° 21.719.

## ⚠️ Limitaciones conocidas

- El hosting corresponde al plan gratuito de Azure App Service (**F1**), sin *Always On*, por lo que la aplicación puede "dormir" tras ~20 minutos de inactividad. Se prioriza el cumplimiento del requisito de hosting gratuito por sobre la eliminación de esta limitación.
- No se incluye gestión de pagos ni comercio electrónico en esta versión.


## 👨‍💻 Autor

**Aldo Quiroz**
Proyecto de Título — Analista Programador
