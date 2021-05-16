/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Puestos
	(
	ID int NOT NULL,
	Nombre varchar(128) NOT NULL,
	SalarioXHora money NOT NULL,
	Visible bit NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Puestos ADD CONSTRAINT
	[DF_dbo.Puestos_Visible] DEFAULT ((1)) FOR Visible
GO
ALTER TABLE dbo.Puestos ADD CONSTRAINT
	[PK_dbo.Puestos] PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Puestos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Departamentos
	(
	ID int NOT NULL,
	Nombre varchar(128) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Departamentos ADD CONSTRAINT
	[PK_dbo.Departamentos] PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Departamentos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.tipoDocIdent
	(
	ID int NOT NULL,
	Nombre varchar(128) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.tipoDocIdent ADD CONSTRAINT
	[PK_dbo.tipoDocIdent] PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.tipoDocIdent SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Empleado
	(
	ID int NOT NULL IDENTITY (1, 1),
	Nombre varchar(128) NOT NULL,
	IdTipoIdentificacion int NOT NULL,
	ValorDocumentoIdentidad varchar(16) NOT NULL,
	IdDepartamento int NOT NULL,
	IdPuesto int NOT NULL,
	IdUsuario int NOT NULL,
	FechaNacimiento date NOT NULL,
	Visible bit NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Empleado ADD CONSTRAINT
	[PK_dbo.Empleados] PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Empleado ADD CONSTRAINT
	[FK_dbo.Empleados_dbo.Puestos] FOREIGN KEY
	(
	IdPuesto
	) REFERENCES dbo.Puestos
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Empleado ADD CONSTRAINT
	[FK_dbo.Empleados_dbo.Departamentos] FOREIGN KEY
	(
	IdDepartamento
	) REFERENCES dbo.Departamentos
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Empleado ADD CONSTRAINT
	[FK_dbo.Empleados_dbo.tipoDocIdent] FOREIGN KEY
	(
	IdTipoIdentificacion
	) REFERENCES dbo.tipoDocIdent
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Empleado SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.TipoJornada
	(
	ID int NOT NULL,
	Nombre varchar(128) NOT NULL,
	HoraEntrada time(7) NOT NULL,
	HoraSalida time(7) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.TipoJornada ADD CONSTRAINT
	[PK_dbo.TipoJornada] PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.TipoJornada SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Jornada
	(
	ID int NOT NULL,
	IdTipoJornada int NOT NULL,
	IdEmpleado int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Jornada ADD CONSTRAINT
	[PK_dbo.Jornada] PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Jornada ADD CONSTRAINT
	[FK_dbo.Jornada_dbo.TipoJornada] FOREIGN KEY
	(
	IdTipoJornada
	) REFERENCES dbo.TipoJornada
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Jornada ADD CONSTRAINT
	[FK_dbo.Jornada_dbo.Empleados] FOREIGN KEY
	(
	IdEmpleado
	) REFERENCES dbo.Empleado
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Jornada SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.MarcasAsistencia
	(
	ID int NOT NULL,
	FechaEntrada datetime NOT NULL,
	FechaSalida datetime NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.MarcasAsistencia ADD CONSTRAINT
	[PK_dbo.MarcasAsistencia] PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.MarcasAsistencia SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.TipoMovimiento
	(
	ID int NOT NULL,
	Nombre varchar(128) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.TipoMovimiento ADD CONSTRAINT
	[PK_dbo.TipoMovimiento] PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.TipoMovimiento SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Feriados
	(
	ID int NOT NULL,
	Fecha date NOT NULL,
	Nombre varchar(128) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Feriados ADD CONSTRAINT
	[PK_dbo.Feriados] PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Feriados SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.TipoDeduccion
	(
	ID int NOT NULL,
	Nombre varchar(50) NOT NULL,
	Obligatorio bit NOT NULL,
	Porcentual bit NOT NULL,
	Valor money NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.TipoDeduccion ADD CONSTRAINT
	[PK_dbo.TipoDeduccion] PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.TipoDeduccion SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Usuarios
	(
	ID int NOT NULL,
	Username varchar(128) NOT NULL,
	Pwd varchar(128) NOT NULL,
	Tipo int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Usuarios ADD CONSTRAINT
	PK_Usuarios PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Usuarios SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.MesPlanilla
	(
	ID int NOT NULL IDENTITY (1, 1),
	Fecha date NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.MesPlanilla ADD CONSTRAINT
	[PK_dbo.MesPlanilla] PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.MesPlanilla SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.SemanaPlanilla
	(
	ID int NOT NULL IDENTITY (1, 1),
	FechaInicio date NOT NULL,
	Fechafin date NOT NULL,
	IdMes int NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.SemanaPlanilla ADD CONSTRAINT
	[PK_dbo.SemanaPlanilla] PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.SemanaPlanilla ADD CONSTRAINT
	[FK_dbo.SemanaPlanilla_dbo.MesPlanilla] FOREIGN KEY
	(
	IdMes
	) REFERENCES dbo.MesPlanilla
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.SemanaPlanilla SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.PlanillaXMesXEmpleado
	(
	ID int NOT NULL IDENTITY (1, 1),
	SalarioNeto money NOT NULL,
	SalarioBruto money NOT NULL,
	TotalDeducciones money NOT NULL,
	IdEmpleado int NOT NULL,
	idMes int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.PlanillaXMesXEmpleado ADD CONSTRAINT
	[PK_dbo.PlanillaXMesXEmpleado] PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.PlanillaXMesXEmpleado ADD CONSTRAINT
	[FK_dbo.PlanillaXMesXEmpleado_dbo.MesPlanilla] FOREIGN KEY
	(
	idMes
	) REFERENCES dbo.MesPlanilla
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.PlanillaXMesXEmpleado ADD CONSTRAINT
	[FK_dbo.PlanillaXMesXEmpleado_dbo.Empleados] FOREIGN KEY
	(
	IdEmpleado
	) REFERENCES dbo.Empleado
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.PlanillaXMesXEmpleado SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.MovimientoPlanilla
	(
	ID int NOT NULL IDENTITY (1, 1),
	Fecha date NOT NULL,
	Monto money NOT NULL,
	IdTipoMov int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.MovimientoPlanilla ADD CONSTRAINT
	[PK_dbo.MovimientoPlanilla] PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.MovimientoPlanilla ADD CONSTRAINT
	FK_MovimientoPlanilla_TipoMovimiento FOREIGN KEY
	(
	IdTipoMov
	) REFERENCES dbo.TipoMovimiento
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.MovimientoPlanilla SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.MovimientoDeduccion
	(
	ID int NOT NULL,
	IdTipoDeduccion int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.MovimientoDeduccion ADD CONSTRAINT
	[PK_dbo.MovimientoDeduccion] PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.MovimientoDeduccion ADD CONSTRAINT
	[FK_dbo.MovimientoDeduccion_dbo.TipoDeduccion] FOREIGN KEY
	(
	IdTipoDeduccion
	) REFERENCES dbo.TipoDeduccion
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.MovimientoDeduccion ADD CONSTRAINT
	FK_MovimientoDeduccion_MovimientoPlanilla FOREIGN KEY
	(
	ID
	) REFERENCES dbo.MovimientoPlanilla
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.MovimientoDeduccion SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.MovimientoHoras
	(
	ID int NOT NULL,
	IdMarcaAsistencia int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.MovimientoHoras ADD CONSTRAINT
	[PK_dbo.MovimientoHoras] PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.MovimientoHoras ADD CONSTRAINT
	[FK_dbo.MovimientoHoras_dbo.MarcasAsistencia] FOREIGN KEY
	(
	IdMarcaAsistencia
	) REFERENCES dbo.MarcasAsistencia
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.MovimientoHoras ADD CONSTRAINT
	FK_MovimientoHoras_MovimientoPlanilla FOREIGN KEY
	(
	ID
	) REFERENCES dbo.MovimientoPlanilla
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.MovimientoHoras SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.PlanillaXSemanaXEmpleado
	(
	ID int NOT NULL IDENTITY (1, 1),
	SalarioBruto money NOT NULL,
	TotalDeducciones money NOT NULL,
	SalarioNeto money NOT NULL,
	IdEmpleado int NOT NULL,
	IdSemana int NOT NULL,
	IdMovimientoPlanilla int NOT NULL,
	IdPlanillaXMesXEmpleado int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.PlanillaXSemanaXEmpleado ADD CONSTRAINT
	[PK_dbo.PlanillaXSemanaXEmpleado] PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.PlanillaXSemanaXEmpleado ADD CONSTRAINT
	[FK_dbo.PlanillaXSemanaXEmpleado_dbo.Empleados] FOREIGN KEY
	(
	IdEmpleado
	) REFERENCES dbo.Empleado
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.PlanillaXSemanaXEmpleado ADD CONSTRAINT
	[FK_dbo.PlanillaXSemanaXEmpleado_dbo.MovimientoPlanilla] FOREIGN KEY
	(
	IdMovimientoPlanilla
	) REFERENCES dbo.MovimientoPlanilla
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.PlanillaXSemanaXEmpleado ADD CONSTRAINT
	[FK_dbo.PlanillaXSemanaXEmpleado_dbo.PlanillaXMesXEmpleado] FOREIGN KEY
	(
	IdPlanillaXMesXEmpleado
	) REFERENCES dbo.PlanillaXMesXEmpleado
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.PlanillaXSemanaXEmpleado ADD CONSTRAINT
	[FK_dbo.PlanillaXSemanaXEmpleado_dbo.SemanaPlanilla] FOREIGN KEY
	(
	IdSemana
	) REFERENCES dbo.SemanaPlanilla
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.PlanillaXSemanaXEmpleado SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.DeduccionesXMesXEmpleado
	(
	ID int NOT NULL IDENTITY (1, 1),
	Monto money NOT NULL,
	IdPlanillaXMesXEmpleado int NOT NULL,
	IdMovimiento int NOT NULL,
	IdEmpleado int NOT NULL,
	IdMes int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.DeduccionesXMesXEmpleado ADD CONSTRAINT
	[FK_dbo.DeduccionesXMesXEmpleado_dbo.PlanillaXMesXEmpleado] FOREIGN KEY
	(
	IdPlanillaXMesXEmpleado
	) REFERENCES dbo.PlanillaXMesXEmpleado
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.DeduccionesXMesXEmpleado ADD CONSTRAINT
	[FK_dbo.DeduccionesXMesXEmpleado_dbo.MovimientoPlanilla] FOREIGN KEY
	(
	IdMovimiento
	) REFERENCES dbo.MovimientoPlanilla
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.DeduccionesXMesXEmpleado ADD CONSTRAINT
	[FK_dbo.DeduccionesXMesXEmpleado_dbo.MesPlanilla] FOREIGN KEY
	(
	IdMes
	) REFERENCES dbo.MesPlanilla
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.DeduccionesXMesXEmpleado ADD CONSTRAINT
	[FK_dbo.DeduccionesXMesXEmpleado_dbo.Empleados] FOREIGN KEY
	(
	IdEmpleado
	) REFERENCES dbo.Empleado
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.DeduccionesXMesXEmpleado SET (LOCK_ESCALATION = TABLE)
GO
COMMIT



BEGIN TRANSACTION
GO
ALTER TABLE dbo.Empleado SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.TipoDeduccion SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.DeduccionesXEmpleado
	(
	ID int NOT NULL,
	IdEmpleado int NOT NULL,
	IdTipoDeduccion int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.DeduccionesXEmpleado ADD CONSTRAINT
	PK_DeduccionesXEmpleado PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.DeduccionesXEmpleado ADD CONSTRAINT
	FK_DeduccionesXEmpleado_TipoDeduccion FOREIGN KEY
	(
	IdTipoDeduccion
	) REFERENCES dbo.TipoDeduccion
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.DeduccionesXEmpleado ADD CONSTRAINT
	FK_DeduccionesXEmpleado_Empleado FOREIGN KEY
	(
	IdEmpleado
	) REFERENCES dbo.Empleado
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.DeduccionesXEmpleado SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

BEGIN TRANSACTION
GO
ALTER TABLE dbo.DeduccionesXEmpleado
	DROP CONSTRAINT FK_DeduccionesXEmpleado_Empleado
GO
ALTER TABLE dbo.Empleado SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.DeduccionesXEmpleado
	DROP CONSTRAINT FK_DeduccionesXEmpleado_TipoDeduccion
GO
ALTER TABLE dbo.TipoDeduccion SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_DeduccionesXEmpleado
	(
	ID int NOT NULL IDENTITY (1, 1),
	IdEmpleado int NOT NULL,
	IdTipoDeduccion int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_DeduccionesXEmpleado SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_DeduccionesXEmpleado ON
GO
IF EXISTS(SELECT * FROM dbo.DeduccionesXEmpleado)
	 EXEC('INSERT INTO dbo.Tmp_DeduccionesXEmpleado (ID, IdEmpleado, IdTipoDeduccion)
		SELECT ID, IdEmpleado, IdTipoDeduccion FROM dbo.DeduccionesXEmpleado WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_DeduccionesXEmpleado OFF
GO
DROP TABLE dbo.DeduccionesXEmpleado
GO
EXECUTE sp_rename N'dbo.Tmp_DeduccionesXEmpleado', N'DeduccionesXEmpleado', 'OBJECT' 
GO
ALTER TABLE dbo.DeduccionesXEmpleado ADD CONSTRAINT
	PK_DeduccionesXEmpleado PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.DeduccionesXEmpleado ADD CONSTRAINT
	FK_DeduccionesXEmpleado_TipoDeduccion FOREIGN KEY
	(
	IdTipoDeduccion
	) REFERENCES dbo.TipoDeduccion
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.DeduccionesXEmpleado ADD CONSTRAINT
	FK_DeduccionesXEmpleado_Empleado FOREIGN KEY
	(
	IdEmpleado
	) REFERENCES dbo.Empleado
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_Feriados
	(
	ID int NOT NULL IDENTITY (1, 1),
	Fecha date NOT NULL,
	Nombre varchar(128) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_Feriados SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_Feriados ON
GO
IF EXISTS(SELECT * FROM dbo.Feriados)
	 EXEC('INSERT INTO dbo.Tmp_Feriados (ID, Fecha, Nombre)
		SELECT ID, Fecha, Nombre FROM dbo.Feriados WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_Feriados OFF
GO
DROP TABLE dbo.Feriados
GO
EXECUTE sp_rename N'dbo.Tmp_Feriados', N'Feriados', 'OBJECT' 
GO
ALTER TABLE dbo.Feriados ADD CONSTRAINT
	[PK_dbo.Feriados] PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_Usuarios
	(
	ID int NOT NULL IDENTITY (1, 1),
	Username varchar(128) NOT NULL,
	Pwd varchar(128) NOT NULL,
	Tipo int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_Usuarios SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_Usuarios ON
GO
IF EXISTS(SELECT * FROM dbo.Usuarios)
	 EXEC('INSERT INTO dbo.Tmp_Usuarios (ID, Username, Pwd, Tipo)
		SELECT ID, Username, Pwd, Tipo FROM dbo.Usuarios WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_Usuarios OFF
GO
DROP TABLE dbo.Usuarios
GO
EXECUTE sp_rename N'dbo.Tmp_Usuarios', N'Usuarios', 'OBJECT' 
GO
ALTER TABLE dbo.Usuarios ADD CONSTRAINT
	PK_Usuarios PRIMARY KEY CLUSTERED 
	(
	ID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Empleado ADD CONSTRAINT
	FK_Empleado_Usuarios FOREIGN KEY
	(
	IdUsuario
	) REFERENCES dbo.Usuarios
	(
	ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.Empleado SET (LOCK_ESCALATION = TABLE)
GO
COMMIT





