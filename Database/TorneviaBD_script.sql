/* ============================================================
   TORNEVIA - Script de creación de base de datos
   Proyecto: Tornevia - Gestión de ligas de fútbol amateur
   Autor: Aldo Quiroz
   Generado a partir de SQL Server
   ============================================================ */

CREATE DATABASE TorneviaBD;
GO

USE TorneviaBD;
GO

/* ============================================================
   1. CREACIÓN DE TABLAS
   ============================================================ */

-- Tabla Usuarios
CREATE TABLE [dbo].[Usuarios](
	[ID_Usuario] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Email] [varchar](150) NOT NULL,
	[Contrasena] [varchar](255) NOT NULL,
	[Rol] [varchar](20) NOT NULL,
	[Fecha_Registro] [datetime] NOT NULL,
	PRIMARY KEY CLUSTERED ([ID_Usuario] ASC)
);
GO

ALTER TABLE [dbo].[Usuarios] ADD DEFAULT (getdate()) FOR [Fecha_Registro];
GO

ALTER TABLE [dbo].[Usuarios] ADD CONSTRAINT [UQ_Usuarios_Email] UNIQUE NONCLUSTERED ([Email] ASC);
GO

-- Tabla Equipos
CREATE TABLE [dbo].[Equipos](
	[ID_Equipo] [int] IDENTITY(1,1) NOT NULL,
	[Nombre_Equipo] [varchar](100) NOT NULL,
	[Logo] [varchar](255) NULL,
	[Categoria] [varchar](50) NULL,
	[ID_Usuario] [int] NOT NULL,
	PRIMARY KEY CLUSTERED ([ID_Equipo] ASC)
);
GO

-- Tabla Torneos
CREATE TABLE [dbo].[Torneos](
	[ID_Torneo] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Tipo] [varchar](50) NOT NULL,
	[Fecha_Inicio] [datetime] NOT NULL,
	[Fecha_Fin] [datetime] NULL,
	[Estado] [varchar](20) NOT NULL,
	[ID_Administrador] [int] NOT NULL,
	PRIMARY KEY CLUSTERED ([ID_Torneo] ASC)
);
GO

-- Tabla Torneo_Equipo (relación N:M)
CREATE TABLE [dbo].[Torneo_Equipo](
	[ID_Torneo] [int] NOT NULL,
	[ID_Equipo] [int] NOT NULL,
	[Fecha_Inscripcion] [datetime] NOT NULL,
	CONSTRAINT [PK_Torneo_Equipo] PRIMARY KEY CLUSTERED ([ID_Torneo] ASC, [ID_Equipo] ASC)
);
GO

ALTER TABLE [dbo].[Torneo_Equipo] ADD DEFAULT (getdate()) FOR [Fecha_Inscripcion];
GO

-- Tabla Jugadores
CREATE TABLE [dbo].[Jugadores](
	[ID_Jugador] [int] IDENTITY(1,1) NOT NULL,
	[Nombre_Jugador] [varchar](100) NOT NULL,
	[Posicion] [varchar](50) NULL,
	[Numero_Camiseta] [int] NULL,
	[ID_Equipo] [int] NOT NULL,
	[ID_Usuario] [int] NULL,
	PRIMARY KEY CLUSTERED ([ID_Jugador] ASC)
);
GO

-- Tabla Partidos
CREATE TABLE [dbo].[Partidos](
	[ID_Partido] [int] IDENTITY(1,1) NOT NULL,
	[ID_Torneo] [int] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Equipo_Local] [int] NOT NULL,
	[Equipo_Visitante] [int] NOT NULL,
	[Goles_Local] [int] NOT NULL,
	[Goles_Visitante] [int] NOT NULL,
	[Lugar] [varchar](150) NULL,
	[Estado] [varchar](20) NOT NULL,
	PRIMARY KEY CLUSTERED ([ID_Partido] ASC)
);
GO

ALTER TABLE [dbo].[Partidos] ADD DEFAULT ((0)) FOR [Goles_Local];
GO
ALTER TABLE [dbo].[Partidos] ADD DEFAULT ((0)) FOR [Goles_Visitante];
GO

-- Tabla Estadisticas
CREATE TABLE [dbo].[Estadisticas](
	[ID_Estadistica] [int] IDENTITY(1,1) NOT NULL,
	[ID_Partido] [int] NOT NULL,
	[ID_Jugador] [int] NOT NULL,
	[Goles] [int] NOT NULL,
	[Asistencias] [int] NOT NULL,
	[Tarjetas_Amarillas] [int] NOT NULL,
	[Tarjetas_Rojas] [int] NOT NULL,
	[Minutos_Jugados] [int] NOT NULL,
	PRIMARY KEY CLUSTERED ([ID_Estadistica] ASC)
);
GO

ALTER TABLE [dbo].[Estadisticas] ADD DEFAULT ((0)) FOR [Goles];
GO
ALTER TABLE [dbo].[Estadisticas] ADD DEFAULT ((0)) FOR [Asistencias];
GO
ALTER TABLE [dbo].[Estadisticas] ADD DEFAULT ((0)) FOR [Tarjetas_Amarillas];
GO
ALTER TABLE [dbo].[Estadisticas] ADD DEFAULT ((0)) FOR [Tarjetas_Rojas];
GO
ALTER TABLE [dbo].[Estadisticas] ADD DEFAULT ((0)) FOR [Minutos_Jugados];
GO

-- Tabla Noticias
CREATE TABLE [dbo].[Noticias](
	[ID_Noticia] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [varchar](200) NOT NULL,
	[Contenido] [text] NULL,
	[Fecha_Publicacion] [datetime] NOT NULL,
	[ID_Usuario] [int] NOT NULL,
	[ID_Torneo] [int] NULL,
	PRIMARY KEY CLUSTERED ([ID_Noticia] ASC)
);
GO

ALTER TABLE [dbo].[Noticias] ADD DEFAULT (getdate()) FOR [Fecha_Publicacion];
GO

/* ============================================================
   2. LLAVES FORÁNEAS
   ============================================================ */

ALTER TABLE [dbo].[Equipos] WITH CHECK ADD CONSTRAINT [FK_Equipos_Usuarios]
	FOREIGN KEY([ID_Usuario]) REFERENCES [dbo].[Usuarios] ([ID_Usuario]);
GO

ALTER TABLE [dbo].[Torneos] WITH CHECK ADD CONSTRAINT [FK_Torneos_Usuarios]
	FOREIGN KEY([ID_Administrador]) REFERENCES [dbo].[Usuarios] ([ID_Usuario]);
GO

ALTER TABLE [dbo].[Torneo_Equipo] WITH CHECK ADD CONSTRAINT [FK_TorneoEquipo_Torneos]
	FOREIGN KEY([ID_Torneo]) REFERENCES [dbo].[Torneos] ([ID_Torneo]) ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[Torneo_Equipo] WITH CHECK ADD CONSTRAINT [FK_TorneoEquipo_Equipos]
	FOREIGN KEY([ID_Equipo]) REFERENCES [dbo].[Equipos] ([ID_Equipo]);
GO

ALTER TABLE [dbo].[Jugadores] WITH CHECK ADD CONSTRAINT [FK_Jugadores_Equipos]
	FOREIGN KEY([ID_Equipo]) REFERENCES [dbo].[Equipos] ([ID_Equipo]);
GO

ALTER TABLE [dbo].[Jugadores] WITH CHECK ADD CONSTRAINT [FK_Jugadores_Usuarios]
	FOREIGN KEY([ID_Usuario]) REFERENCES [dbo].[Usuarios] ([ID_Usuario]);
GO

ALTER TABLE [dbo].[Partidos] WITH CHECK ADD CONSTRAINT [FK_Partidos_Torneos]
	FOREIGN KEY([ID_Torneo]) REFERENCES [dbo].[Torneos] ([ID_Torneo]) ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[Partidos] WITH CHECK ADD CONSTRAINT [FK_Partidos_EquipoLocal]
	FOREIGN KEY([Equipo_Local]) REFERENCES [dbo].[Equipos] ([ID_Equipo]);
GO

ALTER TABLE [dbo].[Partidos] WITH CHECK ADD CONSTRAINT [FK_Partidos_EquipoVisitante]
	FOREIGN KEY([Equipo_Visitante]) REFERENCES [dbo].[Equipos] ([ID_Equipo]);
GO

ALTER TABLE [dbo].[Estadisticas] WITH CHECK ADD CONSTRAINT [FK_Estadisticas_Partidos]
	FOREIGN KEY([ID_Partido]) REFERENCES [dbo].[Partidos] ([ID_Partido]) ON DELETE CASCADE;
GO

ALTER TABLE [dbo].[Estadisticas] WITH CHECK ADD CONSTRAINT [FK_Estadisticas_Jugadores]
	FOREIGN KEY([ID_Jugador]) REFERENCES [dbo].[Jugadores] ([ID_Jugador]);
GO

ALTER TABLE [dbo].[Noticias] WITH CHECK ADD CONSTRAINT [FK_Noticias_Usuarios]
	FOREIGN KEY([ID_Usuario]) REFERENCES [dbo].[Usuarios] ([ID_Usuario]);
GO

ALTER TABLE [dbo].[Noticias] WITH CHECK ADD CONSTRAINT [FK_Noticias_Torneos]
	FOREIGN KEY([ID_Torneo]) REFERENCES [dbo].[Torneos] ([ID_Torneo]);
GO

/* ============================================================
   3. DATOS DE PRUEBA (INSERTS)
   ============================================================ */

-- Usuarios
SET IDENTITY_INSERT [dbo].[Usuarios] ON;
INSERT INTO [dbo].[Usuarios] ([ID_Usuario], [Nombre], [Email], [Contrasena], [Rol], [Fecha_Registro]) VALUES
(1, 'Admin Liga', 'admin@tornevia.cl', 'AQAAAAIAAYagAAAAEBkxXFoHJHiVRi0Fjjo2c+Y+2VQOsXXR+ym0DqLneJlfAbSJMqsRutDkcvyHOt44PA==', 'Administrador', '2026-07-08T20:35:50.283'),
(2, 'Carlos Pérez', 'carlos.perez@correo.com', 'AQAAAAIAAYagAAAAEBkxXFoHJHiVRi0Fjjo2c+Y+2VQOsXXR+ym0DqLneJlfAbSJMqsRutDkcvyHOt44PA==', 'Jugador', '2026-07-08T20:35:50.283'),
(3, 'Juan Soto', 'juan.soto@correo.com', 'AQAAAAIAAYagAAAAEBkxXFoHJHiVRi0Fjjo2c+Y+2VQOsXXR+ym0DqLneJlfAbSJMqsRutDkcvyHOt44PA==', 'Jugador', '2026-07-08T20:35:50.283'),
(4, 'Mario López', 'mario.lopez@correo.com', 'AQAAAAIAAYagAAAAEBkxXFoHJHiVRi0Fjjo2c+Y+2VQOsXXR+ym0DqLneJlfAbSJMqsRutDkcvyHOt44PA==', 'Jugador', '2026-07-08T20:35:50.283'),
(5, 'Messi Quiroz', 'messi.quiroz@correo.com', 'AQAAAAIAAYagAAAAEBYMmU7gK5nA1hYfxTCwn/+iZyUHOQ0pk0CgztPEGL/9xYFBPp6hNyYF9TDQJKDwvA==', 'Jugador', '2026-07-12T17:54:13.053');
SET IDENTITY_INSERT [dbo].[Usuarios] OFF;
GO

-- Equipos
SET IDENTITY_INSERT [dbo].[Equipos] ON;
INSERT INTO [dbo].[Equipos] ([ID_Equipo], [Nombre_Equipo], [Logo], [Categoria], [ID_Usuario]) VALUES
(1, 'Los Cóndores', NULL, 'Senior', 1),
(2, 'Fénix FC', NULL, 'Senior', 1),
(3, 'Villa Norte', NULL, 'Senior', 1),
(4, 'Deportivo Sur', NULL, 'Senior', 1);
SET IDENTITY_INSERT [dbo].[Equipos] OFF;
GO

-- Torneos
SET IDENTITY_INSERT [dbo].[Torneos] ON;
INSERT INTO [dbo].[Torneos] ([ID_Torneo], [Nombre], [Tipo], [Fecha_Inicio], [Fecha_Fin], [Estado], [ID_Administrador]) VALUES
(1, 'Liga Tornevia 2026', 'Liga', '2026-06-01', '2026-08-30', 'Activo', 1);
SET IDENTITY_INSERT [dbo].[Torneos] OFF;
GO

-- Torneo_Equipo
INSERT INTO [dbo].[Torneo_Equipo] ([ID_Torneo], [ID_Equipo], [Fecha_Inscripcion]) VALUES
(1, 1, '2026-07-08T20:35:50.347'),
(1, 2, '2026-07-08T20:35:50.347'),
(1, 3, '2026-07-08T20:35:50.347'),
(1, 4, '2026-07-08T20:35:50.347');
GO

-- Jugadores
SET IDENTITY_INSERT [dbo].[Jugadores] ON;
INSERT INTO [dbo].[Jugadores] ([ID_Jugador], [Nombre_Jugador], [Posicion], [Numero_Camiseta], [ID_Equipo], [ID_Usuario]) VALUES
(1, 'Carlos Pérez', 'Delantero', 9, 1, 2),
(2, 'Juan Soto', 'Mediocampista', 8, 1, 3),
(3, 'Pedro Díaz', 'Defensa', 4, 1, NULL),
(4, 'Mario López', 'Delantero', 11, 3, 4),
(5, 'Diego Ruiz', 'Portero', 1, 3, NULL),
(6, 'Messi Quiroz', 'Delantero', 10, 3, 5);
SET IDENTITY_INSERT [dbo].[Jugadores] OFF;
GO

-- Partidos
SET IDENTITY_INSERT [dbo].[Partidos] ON;
INSERT INTO [dbo].[Partidos] ([ID_Partido], [ID_Torneo], [Fecha], [Equipo_Local], [Equipo_Visitante], [Goles_Local], [Goles_Visitante], [Lugar], [Estado]) VALUES
(1, 1, '2026-06-14T15:00:00', 1, 2, 3, 1, 'Cancha Municipal N°1', 'Finalizado'),
(2, 1, '2026-06-15T11:00:00', 3, 4, 1, 0, 'Cancha Municipal N°2', 'Finalizado'),
(3, 1, '2026-07-20T15:00:00', 1, 3, 0, 0, 'Cancha Municipal N°1', 'Programado'),
(4, 1, '2026-06-21T15:00:00', 2, 1, 1, 3, 'Cancha Municipal N°1', 'Finalizado'),
(5, 1, '2026-06-28T11:00:00', 1, 4, 0, 0, 'Cancha Municipal N°2', 'Finalizado'),
(6, 1, '2026-07-05T15:00:00', 3, 1, 2, 1, 'Cancha Municipal N°1', 'Finalizado'),
(7, 1, '2026-07-12T15:00:00', 1, 2, 2, 2, 'Cancha Municipal N°1', 'Finalizado'),
(8, 1, '2026-07-19T11:00:00', 4, 1, 0, 3, 'Cancha Municipal N°2', 'Finalizado'),
(9, 1, '2026-07-26T15:00:00', 1, 3, 4, 1, 'Cancha Municipal N°1', 'Finalizado'),
(10, 1, '2026-08-02T11:00:00', 2, 1, 1, 1, 'Cancha Municipal N°2', 'Finalizado'),
(11, 1, '2026-08-09T15:00:00', 1, 4, 3, 0, 'Cancha Municipal N°1', 'Finalizado');
SET IDENTITY_INSERT [dbo].[Partidos] OFF;
GO

-- Estadisticas
SET IDENTITY_INSERT [dbo].[Estadisticas] ON;
INSERT INTO [dbo].[Estadisticas] ([ID_Estadistica], [ID_Partido], [ID_Jugador], [Goles], [Asistencias], [Tarjetas_Amarillas], [Tarjetas_Rojas], [Minutos_Jugados]) VALUES
(2, 1, 2, 1, 0, 0, 0, 90),
(3, 1, 3, 0, 0, 0, 0, 85),
(4, 2, 4, 1, 0, 1, 0, 90),
(5, 2, 5, 0, 0, 0, 0, 90),
(43, 1, 1, 2, 1, 0, 0, 90),
(44, 4, 1, 1, 1, 0, 0, 90),
(45, 5, 1, 0, 2, 1, 0, 90),
(46, 6, 1, 1, 0, 0, 0, 75),
(47, 7, 1, 1, 1, 0, 0, 90),
(48, 8, 1, 2, 1, 0, 0, 90),
(49, 9, 1, 2, 2, 1, 0, 90),
(50, 10, 1, 0, 1, 0, 0, 60),
(51, 11, 1, 3, 0, 0, 0, 90);
SET IDENTITY_INSERT [dbo].[Estadisticas] OFF;
GO

-- Noticias
SET IDENTITY_INSERT [dbo].[Noticias] ON;
INSERT INTO [dbo].[Noticias] ([ID_Noticia], [Titulo], [Contenido], [Fecha_Publicacion], [ID_Usuario], [ID_Torneo]) VALUES
(1, 'Inicio de la Liga Tornevia 2026', 'Damos inicio a la temporada 2026 con 4 equipos inscritos. ¡Mucho éxito a todos!', '2026-07-08T20:35:50.420', 1, 1),
(2, 'Resultados de la primera fecha', 'Los Cóndores venció a Fénix FC 3-1 y Villa Norte superó a Deportivo Sur 1-0.', '2026-07-08T20:35:50.420', 1, 1),
(3, 'Segunda fecha: sorpresas en la tabla', 'Los Cóndores se afianza en la punta tras vencer a Villa Norte, mientras Fénix FC busca reponerse en las próximas jornadas.', '2026-07-05T00:00:00', 1, 1),
(4, 'Se acerca el receso de mitad de temporada', 'La liga Tornevia 2026 llega a la mitad del calendario. Recordamos a los equipos regularizar la ficha de sus jugadores antes de la próxima fecha.', '2026-07-20T00:00:00', 1, 1);
SET IDENTITY_INSERT [dbo].[Noticias] OFF;
GO

/* ============================================================
   FIN DEL SCRIPT
   Nota: todas las contraseñas de prueba corresponden a "88888888"
   ============================================================ */
