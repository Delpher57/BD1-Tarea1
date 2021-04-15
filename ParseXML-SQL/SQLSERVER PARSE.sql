DECLARE @TipoID xml
 
SELECT @TipoID = T
FROM OPENROWSET (BULK 'C:\Users\jenar\OneDrive\Documentos\Bases Datos\TipoIdentidad.xml', SINGLE_BLOB) AS TipoID(T)
    
DECLARE @hdoc int
    
EXEC sp_xml_preparedocument @hdoc OUTPUT, @TipoID
INSERT INTO dbo.TipoDocIdent
SELECT *
FROM OPENXML (@hdoc, '/Tipos_de_Documento_de_Identidad/TipoDocuIdentidad' , 1)
WITH(
	Id int,
    Nombre VARCHAR(20)
    )
    
EXEC sp_xml_removedocument @hdoc

DECLARE @Puestos xml
 
SELECT @Puestos = P
FROM OPENROWSET (BULK 'C:\Users\jenar\OneDrive\Documentos\Bases Datos\Puestos.xml', SINGLE_BLOB) AS Puestos(P)
    
  
EXEC sp_xml_preparedocument @hdoc OUTPUT, @Puestos

INSERT INTO dbo.Puestos
SELECT *
FROM OPENXML (@hdoc, '/Puestos/Puesto' , 1)
WITH(
	Id int,
    Nombre VARCHAR(50),
	SalarioXHora money
    )
    
    
EXEC sp_xml_removedocument @hdoc

DECLARE @Departamentos xml
 
SELECT @Departamentos = D
FROM OPENROWSET (BULK 'C:\Users\jenar\OneDrive\Documentos\Bases Datos\Departamentos.xml', SINGLE_BLOB) AS Depa(D)
    
    
EXEC sp_xml_preparedocument @hdoc OUTPUT, @Departamentos

INSERT INTO dbo.Departamentos
SELECT *
FROM OPENXML (@hdoc, '/Departamentos/Departamento' , 1)
WITH(
	Id int,
	IdJefe int,
    Nombre VARCHAR(50)
    )
    
    
EXEC sp_xml_removedocument @hdoc

DECLARE @Empleados xml
 
SELECT @Empleados = E
FROM OPENROWSET (BULK 'C:\Users\jenar\OneDrive\Documentos\Bases Datos\Empleados.xml', SINGLE_BLOB) AS Emp(E)
     
   
EXEC sp_xml_preparedocument @hdoc OUTPUT, @Empleados

DELETE FROM dbo.Empleados
DBCC CHECKIDENT ('Empleados', RESEED, 0)
INSERT INTO dbo.Empleados(Nombre,IdTipoIdentificacion,ValorDocumentoIdentificacion,IdDepartamento,IdPuesto,FechaNacimiento)
SELECT *
FROM OPENXML (@hdoc, '/Empleados/Empleado' , 1)
WITH(
    Nombre VARCHAR(100),
	IdTipoIdentificacion int,
	ValorDocumentoIdentificacion VARCHAR(10),
	IdDepartamento int,
	IdPuesto int,
	FechaNacimiento date
    )
    
    
EXEC sp_xml_removedocument @hdoc