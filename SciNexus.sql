--create database SciNexus_01

--use SciNexus_01

------------------------------------------------------------

create table Roles(
id int identity primary key,
Nombre nvarchar(200),
Descripcion nvarchar(300),
--AUDITORIA--
FechaCreacion datetime default getdate(),
UsuarioCreacion nvarchar(50) default SYSTEM_USER,
FechaModificacion datetime null,
UsuarioModificacion nvarchar(50) null,
);

create table Paises(
id int identity primary key,
Nombre nvarchar(100) not null,
--AUDITORIA--
FechaCreacion datetime default getdate(),
UsuarioCreacion nvarchar(50) default SYSTEM_USER,
FechaModificacion datetime null,
UsuarioModificacion nvarchar(50) null
);

create table Provincias(
id int identity primary key,
id_pais int not null,
Nombre nvarchar(100) not null,
constraint FK_Provincia_Pais foreign key (id_pais) references Paises(id),
constraint UQ_ProvinciaNombre_Pais  unique (id_pais, Nombre), --constraint para evitar que la provincia no se repita en el mismo pais
--AUDITORIA--
FechaCreacion datetime default getdate(),
UsuarioCreacion nvarchar(50) default SYSTEM_USER,
FechaModificacion datetime null,
UsuarioModificacion nvarchar(50) null
);

create table Ciudad(
id int identity primary key,
id_provincia int not null,
Nombre nvarchar(100) not null,
constraint FK_Ciudad_Provincia foreign key (id_provincia) references Provincias(id),
--AUDITORIA--
FechaCreacion datetime default getdate(),
UsuarioCreacion nvarchar(50) default SYSTEM_USER,
FechaModificacion datetime null,
UsuarioModificacion nvarchar(50) null
);

create table Usuarios(
id int identity primary key,
id_rol int not null,
id_ciudad int not null,
Nombre nvarchar(100) not null,
Apellido nvarchar(100) not null,
Telefono numeric(13) check (Telefono >= 10),
Edad tinyint check (Edad >= 16) not null,
Email nvarchar(256) not null unique check (Email like '%_@_%._%'),
constraint FK_usuario_rol foreign key (id_rol) references Rol(id),
constraint FK_usuario_pais foreign key (id_pais) references Pais(id),
constraint FK_usuario_provincia foreign key (id_provincia) references Provincia(id),
constraint FK_usuario_ciudad foreign key (id_ciudad) references Ciudad(id),
--AUDITORIA--
FechaCreacion datetime default getdate(),
UsuarioCreacion nvarchar(50) default SYSTEM_USER,
FechaModificacion datetime null,
UsuarioModificacion nvarchar(50) null,
);

create table Materias(
id int identity primary key,
Nombre nvarchar(100),
--AUDITORIA--
FechaCreacion datetime default getdate(),
UsuarioCreacion nvarchar(50) default SYSTEM_USER,
FechaModificacion datetime null,
UsuarioModificacion nvarchar(50) null,
);
--Como guarda el usuario que modifico? Como sabe que guardar??

create table Investigaciones(
id int identity primary key,
Titulo nvarchar(50) not null,
id_usuario int not null,
id_materia int not null,
Resumen nvarchar(500) not null,
constraint FK_Investigaciones_Materia foreign key (id_materia) references Materias (id),
constraint FK_Investigaciones_Usuarios foreign key (id_usuario) references Usuarios(id),
constraint CHK_Investigaciones_Resumen check (len(ltrim(resumen)) > 50),
--AUDITORIA--
FechaCreacion datetime default getdate(),
UsuarioCreacion nvarchar(50) default SYSTEM_USER,
FechaModificacion datetime null,
UsuarioModificacion nvarchar(50) null,
);

-- ====INGRESO DE DATOS====
-- ====TABLA DE ROLES====
insert into Roles (Nombre, Descripcion) values
('Investigador Principal (Director)', 'Es el dueño del proyecto. Tiene control total sobre la configuración de la investigación, puede invitar a otros miembros y es el responsable legal de los datos.'),
('Investigador (Colaborador)', 'Es el perfil técnico que analiza y procesa la información. Suele tener acceso a la mayoría de las herramientas de la base de datos pero sin poder borrar el proyecto.'),
('Recolector de Datos (Encuestador / Técnico de Campo)', 'Un rol operativo pensado para quienes están en la calle o en el laboratorio cargando información nueva. No debe ver el panorama completo para evitar sesgos.'),
('Analizador de Datos', 'Un rol de "solo lectura" avanzada. Su función es extraer conclusiones sin riesgo de alterar la base original'),
('Auditor / Revisor Ético', 'Un perfil externo que supervisa que la investigación cumpla con las normas (especialmente si hay datos sensibles de personas).');

--drop table Roles
--select * from Roles;


-- =====TABLA PAISES=====
insert into Paises (Nombre) values
('Afganistán'), ('Albania'), ('Alemania'), ('Andorra'), ('Angola'), ('Antigua y Barbuda'), 
('Arabia Saudita'), ('Argelia'), ('Argentina'), ('Armenia'), ('Australia'), ('Austria'), 
('Azerbaiyán'), ('Bahamas'), ('Bangladés'), ('Barbados'), ('Baréin'), ('Bélgica'), ('Belice'), 
('Benín'), ('Bielorrusia'), ('Birmania'), ('Bolivia'), ('Bosnia y Herzegovina'), ('Botsuana'), ('Brasil'), 
('Brunéi'), ('Bulgaria'), ('Burkina Faso'), ('Burundi'), ('Bután'), ('Cabo Verde'), ('Camboya'), ('Camerún'), 
('Canadá'), ('Catar'), ('Chad'), ('Chile'), ('China'), ('Chipre'), ('Ciudad del Vaticano'), ('Colombia'), 
('Comoras'), ('Corea del Norte'), ('Corea del Sur'), ('Costa de Marfil'), ('Costa Rica'), ('Croacia'), ('Cuba'),
('Dinamarca'), ('Dominica'), ('Ecuador'), ('Egipto'), ('El Salvador'), ('Emiratos Árabes Unidos'), ('Eritrea'), 
('Eslovaquia'), ('Eslovenia'), ('España'), ('Estados Unidos'), ('Estonia'), ('Etiopía'), ('Filipinas'), 
('Finlandia'), ('Fiyi'), ('Francia'), ('Gabón'), ('Gambia'), ('Georgia'), ('Ghana'), ('Granada'), ('Grecia'), 
('Guatemala'), ('Guyana'), ('Guinea'), ('Guinea ecuatorial'), ('Guinea-Bisáu'), ('Haití'), ('Honduras'), 
('Hungría'), ('India'), ('Indonesia'), ('Irak'), ('Irán'), ('Irlanda'), ('Islandia'), ('Islas Marshall'), 
('Islas Salomón'), ('Israel'), ('Italia'), ('Jamaica'), ('Japón'), ('Jordania'), ('Kazajistán'), ('Kenia'), 
('Kirguistán'), ('Kiribati'), ('Kuwait'), ('Laos'), ('Lesoto'), ('Letonia'), ('Líbano'), ('Liberia'), ('Libia'), 
('Liechtenstein'), ('Lituania'), ('Luxemburgo'), ('Macedonia del Norte'), ('Madagascar'), ('Malasia'), ('Malaui'), 
('Maldivas'), ('Malí'), ('Malta'), ('Marruecos'), ('Mauricio'), ('Mauritania'), ('México'), ('Micronesia'), 
('Moldavia'), ('Mónaco'), ('Mongolia'), ('Montenegro'), ('Mozambique'), ('Namibia'), ('Nauru'), ('Nepal'), 
('Nicaragua'), ('Níger'), ('Nigeria'), ('Noruega'), ('Nueva Zelanda'), ('Omán'), ('Países Bajos'), ('Pakistán'), 
('Palaos'), ('Panamá'), ('Papúa Nueva Guinea'), ('Paraguay'), ('Perú'), ('Polonia'), ('Portugal'), ('Reino Unido'),
('República Centroafricana'), ('República Checa'), ('República del Congo'), ('República Democrática del Congo'), 
('República Dominicana'), ('Ruanda'), ('Rumanía'), ('Rusia'), ('Samoa'), ('San Cristóbal y Nieves'), 
('San Marino'), ('San Vicente y las Granadinas'), ('Santa Lucía'), ('Santo Tomé y Príncipe'), ('Senegal'), 
('Serbia'), ('Seychelles'), ('Sierra Leona'), ('Singapur'), ('Siria'), ('Somalia'), ('Sri Lanka'), 
('Suazilandia'), ('Sudáfrica'), ('Sudán'), ('Sudán del Sur'), ('Suecia'), ('Suiza'), ('Surinam'), ('Tailandia'), 
('Tanzania'), ('Tayikistán'), ('Timor Oriental'), ('Togo'), ('Tonga'), ('Trinidad y Tobago'), ('Túnez'), 
('Turkmenistán'), ('Turquía'), ('Tuvalu'), ('Ucrania'), ('Uganda'), ('Uruguay'), ('Uzbekistán'), ('Vanuatu'), 
('Venezuela'), ('Vietnam'), ('Yemen'), ('Yibuti'), ('Zambia'), ('Zimbabue');

--select * from Paises



-- ====TABLA PROVINCIAS====
insert into Provincias (id_pais, Nombre) values
(9, 'Buenos Aires'), (9, 'Catamarca'), (9, 'Chaco'), (9, 'Chubut'), (9, 'Ciudad Autónoma de Buenos Aires'), 
(9, 'Córdoba'), (9, 'Corrientes'), (9, 'Entre Ríos'), (9, 'Formosa'), (9, 'Jujuy'), (9, 'La Pampa'), 
(9, 'La Rioja'), (9, 'Mendoza'), (9, 'Misiones'), (9, 'Neuquén'), (9, 'Río Negro'), (9, 'Salta'), (9, 'San Juan'), 
(9, 'San Luis'), (9, 'Santa Cruz'), (9, 'Santa Fe'), (9, 'Santiago del Estero'), 
(9, 'Tierra del Fuego, Antártida e Islas del Atlántico Sur'), (9, 'Tucumán');
insert into Provincias (id_pais, Nombre) values 
(26, 'Acre'), (26, 'Alagoas'), (26, 'Amapá'), (26, 'Amazonas'), (26, 'Bahía'), (26, 'Ceará'), 
(26, 'Distrito Federal'), (26, 'Espírito Santo'), (26, 'Goiás'), (26, 'Maranhão'), (26, 'Mato Grosso'),
(26, 'Mato Grosso del Sur'), (26, 'Minas Gerais'), (26, 'Pará'), (26, 'Paraíba'), (26, 'Paraná'), 
(26, 'Pernambuco'), (26, 'Piauí'), (26, 'Río de Janeiro'), (26, 'Río Grande del Norte'), 
(26, 'Río Grande del Sur'), (26, 'Rondônia'), (26, 'Roraima'), (26, 'Santa Catarina'), (26, 'São Paulo'), 
(26, 'Sergipe'), (26, 'Tocantins');
insert into Provincias (id_pais, Nombre) values
(139, 'Alto Paraguay'), (139, 'Alto Paraná'), (139, 'Amambay'), (139, 'Asunción'), (139, 'Boquerón'),
(139, 'Caaguazú'), (139, 'Caazapá'), (139, 'Canindeyú'), (139, 'Central'), (139, 'Concepción'), 
(139, 'Cordillera'), (139, 'Guairá'), (139, 'Itapúa'), (139, 'Misiones'), (139, 'Ñeembucú'), 
(139, 'Paraguarí'), (139, 'Presidente Hayes'), (139, 'San Pedro'), (186, 'Artigas'), (186, 'Canelones'), 
(186, 'Cerro Largo'), (186, 'Colonia'), (186, 'Durazno'), (186, 'Flores'), (186, 'Florida'), (186, 'Lavalleja'), 
(186, 'Maldonado'), (186, 'Montevideo'), (186, 'Paysandú'), (186, 'Río Negro'), (186, 'Rivera'), (186, 'Rocha'), 
(186, 'Salto'), (186, 'San José'), (186, 'Soriano'), (186, 'Tacuarembó'), (186, 'Treinta y Tres'),
(38, 'Arica y Parinacota'), (38, 'Tarapacá'), (38, 'Antofagasta'), (38, 'Atacama'), (38, 'Coquimbo'), 
(38, 'Valparaíso'), (38, 'Metropolitana de Santiago'), (38, 'Libertador General Bernardo O''Higgins'), 
(38, 'Maule'), (38, 'Ñuble'), (38, 'Biobío'), (38, 'La Araucanía'), (38, 'Los Ríos'), (38, 'Los Lagos'), 
(38, 'Aysén del General Carlos Ibáñez del Campo'), (38, 'Magallanes y de la Antártica Chilena');

--select * from Provincias where id_pais = 9
--drop table Provincias

insert into Ciudades (id_provincia, Nombre) values 