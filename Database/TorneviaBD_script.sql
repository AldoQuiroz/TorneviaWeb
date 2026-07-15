/* ============================================================
   TORNEVIA - Script de creación de base de datos
   Proyecto: Tornevia - Gestión de ligas de fútbol amateur
   Autor: Aldo Quiroz
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

-- Tabla Torneo_Equipo
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
(5, 'Messi Quiroz', 'messi.quiroz@correo.com', 'AQAAAAIAAYagAAAAEBYMmU7gK5nA1hYfxTCwn/+iZyUHOQ0pk0CgztPEGL/9xYFBPp6hNyYF9TDQJKDwvA==', 'Jugador', '2026-07-12T17:54:13.053'),
(6, 'Aldo Quiroz', 'aldoquirozandrade@gmail.com', 'AQAAAAIAAYagAAAAEFUJcPcRj1W8k8UQIzK/q9ahdg5/ByNBFLeEwiCZ8mVvuyRFjgWWac/SNa6V/M+tmA==', 'Jugador', '2026-07-14T19:53:21.820'),
(7, 'Federico Valdes', 'fvaldes@tornevia.cl', 'AQAAAAIAAYagAAAAEDKpZrlp1+eBf6X5XD3oh3+2W6oRXe+cKbHPd20WlcOQtVq5TxywEE1WT9eagR9RrQ==', 'Jugador', '2026-07-14T20:40:17.337');
SET IDENTITY_INSERT [dbo].[Usuarios] OFF;
GO

-- Equipos
SET IDENTITY_INSERT [dbo].[Equipos] ON;
INSERT INTO [dbo].[Equipos] ([ID_Equipo], [Nombre_Equipo], [Logo], [Categoria], [ID_Usuario]) VALUES
(1, 'Los Cóndores', 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Nocerina_1910_ASD.png/120px-Nocerina_1910_ASD.png', 'Senior', 1),
(2, 'Fénix FC', 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/64/Pro_Gorizia_Logo.png/120px-Pro_Gorizia_Logo.png', 'Senior', 1),
(3, 'Villa Norte', 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/A.C._Cordenonese_3S_logo.png/120px-A.C._Cordenonese_3S_logo.png', 'Adulto', 1),
(4, 'Deportivo Sur', 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0c/Atalanta_BC.png/120px-Atalanta_BC.png', 'Adulto', 1),
(5, 'Los Codificadores', 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/Ac_lecco_historic_crest_2.png/120px-Ac_lecco_historic_crest_2.png', 'Sub-20', 1),
(6, 'Cornicello FC', 'https://www.curniciellonapolitano.es/wp-content/uploads/2023/08/cropped-logo-curniciello-1.png', 'Adulto', 1),
(7, 'Los Campeones', 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Pro_piacenza_1919.png/120px-Pro_piacenza_1919.png', 'Sub-20', 1);
SET IDENTITY_INSERT [dbo].[Equipos] OFF;
GO

-- Torneos
SET IDENTITY_INSERT [dbo].[Torneos] ON;
INSERT INTO [dbo].[Torneos] ([ID_Torneo], [Nombre], [Tipo], [Fecha_Inicio], [Fecha_Fin], [Estado], [ID_Administrador]) VALUES
(1, 'Liga Tornevia 2026', 'Liga', '2026-06-01', '2026-08-30', 'Activo', 1),
(2, 'Torneo de campeones', 'Copa', '2026-07-24', '2026-08-23', 'Programado', 1),
(3, 'Copa Estrellas', 'Copa', '2026-07-17', '2026-08-30', 'Programado', 1);
SET IDENTITY_INSERT [dbo].[Torneos] OFF;
GO

-- Torneo_Equipo
INSERT INTO [dbo].[Torneo_Equipo] ([ID_Torneo], [ID_Equipo], [Fecha_Inscripcion]) VALUES
(1, 1, '2026-07-08T20:35:50.347'),
(1, 2, '2026-07-08T20:35:50.347'),
(1, 3, '2026-07-08T20:35:50.347'),
(1, 4, '2026-07-08T20:35:50.347'),
(1, 5, '2026-07-14T21:04:30.213'),
(1, 7, '2026-07-14T21:04:36.210'),
(2, 1, '2026-07-14T19:25:03.143'),
(2, 2, '2026-07-14T19:24:55.930'),
(2, 3, '2026-07-14T19:40:48.340'),
(2, 4, '2026-07-14T19:24:42.370'),
(2, 5, '2026-07-14T19:24:46.103'),
(2, 6, '2026-07-14T19:40:43.847'),
(3, 1, '2026-07-14T20:10:59.270'),
(3, 2, '2026-07-14T20:10:56.543'),
(3, 3, '2026-07-14T20:11:04.867'),
(3, 4, '2026-07-14T20:10:53.717'),
(3, 5, '2026-07-14T20:11:01.667'),
(3, 6, '2026-07-14T20:10:50.137');
GO

-- Jugadores
SET IDENTITY_INSERT [dbo].[Jugadores] ON;
INSERT INTO [dbo].[Jugadores] ([ID_Jugador], [Nombre_Jugador], [Posicion], [Numero_Camiseta], [ID_Equipo], [ID_Usuario]) VALUES
(1, 'Carlos Pérez', 'Delantero', 9, 1, 2),
(2, 'Juan Soto', 'Mediocampista', 8, 1, 3),
(3, 'Pedro Díaz', 'Defensa', 4, 1, NULL),
(4, 'Mario López', 'Delantero', 11, 3, 4),
(5, 'Diego Ruiz', 'Portero', 1, 4, NULL),
(6, 'Messi Quiroz', 'Delantero', 10, 3, 5),
(7, 'Aldo Quiroz', 'Delantero', 10, 6, 6),
(8, 'Diego Rodriguez', 'Defensa', 4, 6, NULL),
(9, 'Federico Valdes', 'Mediocampista', 7, 6, 7),
(10, 'Victor Retamales', 'Mediocampista', 6, 7, NULL);
SET IDENTITY_INSERT [dbo].[Jugadores] OFF;
GO

-- Partidos
SET IDENTITY_INSERT [dbo].[Partidos] ON;
INSERT INTO [dbo].[Partidos] ([ID_Partido], [ID_Torneo], [Fecha], [Equipo_Local], [Equipo_Visitante], [Goles_Local], [Goles_Visitante], [Lugar], [Estado]) VALUES
(1, 1, '2026-06-14T15:00:00', 1, 2, 6, 3, 'Cancha Municipal N°1', 'Finalizado'),
(2, 1, '2026-06-15T11:00:00', 3, 4, 1, 0, 'Cancha Municipal N°2', 'Finalizado'),
(4, 1, '2026-06-21T15:00:00', 2, 1, 1, 3, 'Cancha Municipal N°1', 'Finalizado'),
(5, 1, '2026-06-28T11:00:00', 1, 4, 0, 0, 'Cancha Municipal N°2', 'Finalizado'),
(7, 1, '2026-07-12T15:00:00', 1, 2, 2, 2, 'Cancha Municipal N°1', 'Finalizado'),
(8, 1, '2026-07-19T11:00:00', 4, 1, 0, 3, 'Cancha Municipal N°2', 'Finalizado'),
(9, 1, '2026-07-26T15:00:00', 1, 3, 4, 1, 'Cancha Municipal N°1', 'Finalizado'),
(10, 1, '2026-08-02T11:00:00', 2, 1, 1, 1, 'Cancha Municipal N°2', 'Finalizado'),
(11, 1, '2026-08-09T15:00:00', 1, 4, 3, 0, 'Cancha Municipal N°1', 'Finalizado'),
(12, 2, '2026-07-24T21:00:00', 5, 4, 0, 0, 'Cancha Estacion Central', 'Programado'),
(13, 3, '2026-07-14T20:00:00', 6, 5, 4, 0, 'Junta de vecinos Avenida Grecia', 'Finalizado'),
(14, 2, '2026-07-14T21:05:43.040', 3, 4, 3, 3, 'Cancha municipal', 'Finalizado');
SET IDENTITY_INSERT [dbo].[Partidos] OFF;
GO

-- Estadisticas
SET IDENTITY_INSERT [dbo].[Estadisticas] ON;
INSERT INTO [dbo].[Estadisticas] ([ID_Estadistica], [ID_Partido], [ID_Jugador], [Goles], [Asistencias], [Tarjetas_Amarillas], [Tarjetas_Rojas], [Minutos_Jugados]) VALUES
(2, 1, 2, 1, 0, 0, 0, 90),
(3, 1, 3, 1, 0, 0, 0, 85),
(4, 2, 4, 1, 0, 1, 0, 90),
(5, 2, 5, 0, 0, 0, 0, 90),
(43, 1, 1, 2, 1, 0, 0, 90),
(44, 4, 1, 1, 1, 0, 0, 90),
(45, 5, 1, 0, 2, 1, 0, 90),
(47, 7, 1, 1, 1, 0, 0, 90),
(48, 8, 1, 2, 1, 0, 0, 90),
(49, 9, 1, 2, 2, 1, 0, 90),
(50, 10, 1, 0, 1, 0, 0, 60),
(51, 11, 1, 3, 0, 0, 0, 90),
(52, 9, 6, 2, 0, 0, 0, 0),
(53, 4, 3, 1, 0, 0, 0, 0),
(54, 13, 7, 3, 2, 0, 0, 0),
(55, 13, 8, 1, 0, 1, 0, 0),
(56, 14, 5, 3, 0, 0, 0, 85),
(57, 14, 4, 2, 0, 0, 1, 75),
(58, 14, 6, 1, 0, 0, 0, 90);
SET IDENTITY_INSERT [dbo].[Estadisticas] OFF;
GO

-- Noticias
SET IDENTITY_INSERT [dbo].[Noticias] ON;
INSERT INTO [dbo].[Noticias] ([ID_Noticia], [Titulo], [Contenido], [Fecha_Publicacion], [ID_Usuario], [ID_Torneo]) VALUES
(1, 'Inicio de la Liga Tornevia 2026', 'Damos inicio a la temporada 2026 con 4 equipos inscritos. ¡Mucho éxito a todos!', '2026-07-08T20:35:50.420', 1, 1),
(2, 'Resultados de la primera fecha', 'Los Cóndores venció a Fénix FC 3-1 y Villa Norte superó a Deportivo Sur 1-0.', '2026-07-08T20:35:50.420', 1, 1),
(3, 'Segunda fecha: sorpresas en la tabla', 'Los Cóndores se afianza en la punta tras vencer a Villa Norte, mientras Fénix FC busca reponerse en las próximas jornadas.', '2026-07-05T00:00:00', 1, 1),
(4, 'Se acerca el receso de mitad de temporada', 'La liga Tornevia 2026 llega a la mitad del calendario. Recordamos a los equipos regularizar la ficha de sus jugadores antes de la próxima fecha.', '2026-07-20T00:00:00', 1, 1),
(5, 'Inicia próximamente el gran Torneo de campeones', 'el próximo 24 de julio da comienzo al gran torneo de campeones!', '2026-07-14T00:00:00', 1, 2);
SET IDENTITY_INSERT [dbo].[Noticias] OFF;
GO

/* ============================================================
   FIN DEL SCRIPT
   Nota: todas las contraseñas de prueba corresponden a "88888888"
   ============================================================ */