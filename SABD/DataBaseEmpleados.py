#pip install pyodbc
import pyodbc


def get_puestos_BD():
    """[Ejecutamos el stored procedure para obtener los puestos]

    Returns:
        [touple]: [tuplo con todos los puestos en la BD]
    """    
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.GetPuestos
            @OutResultCode OUTPUT
        """
    )
    puestos = tuple(cursor)
    cursor.close()
    return (puestos)

def get_puestos_by_ID(Id):
    """[obtenemos un puesto especifico con el id]

    Args:
        Id ([int]): [id del puesto a pedir]

    Returns:
        [tuple]: [tuplcon el puesto]
    """    
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.GetPuestosByID
            ?,
            @OutResultCode OUTPUT
        """,(Id)
    )
    puesto = tuple(cursor)
    cursor.close()
    return (puesto)

def insertar_puesto_BD(Id,Nombre,SalarioXHora):
    """[Insertamos un puesto a la base de datos]

    Args:
        Id ([int]): [id (primary key) del puesto a ser insertado]
        Nombre ([string]): [nombre del puesto]
        SalarioXHora ([int]): [Salario que se gana por hora]
    """    
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.InsertarPuesto
            ?,
            ?,
            ?,
            ?,
            @OutResultCode OUTPUT
        """,
        (Id,Nombre,SalarioXHora,True)
    )
    conn.commit()
    cursor.close()

def cambiar_visibilidad_puesto_BD(Id, value):
    """[ocultamos un puesto cambiando el bit de visibilidad]

    Args:
        Id ([int]): [Id del puesto que vamos a ocultar]
        value ([bool]): [True si se va a mostrar, False si se va a ocultar]
    """    
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.OcultarPuesto
            ?,
            ?,
            @OutResultCode OUTPUT
        """,
        (Id,value)
    )
    conn.commit()
    cursor.close()

def editar_puesto_BD(IdPuesto,Nombre,SalarioXHora):
    """[editamos un puesto de la BD]

    Args:
        IdPuesto ([int]): [id del puesto a editar]
        Nombre ([string]): [nombre del puesto]
        SalarioXHora ([int]): [Salario que se gana por hora]
    """    
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.EditarPuesto
            ?,
            ?,
            ?,
            @OutResultCode OUTPUT
        """,
        (IdPuesto,Nombre,SalarioXHora)
    )
    conn.commit()
    cursor.close()

# -------------------------------------------- #

def get_empleados_BD():
    """[obtenemos un tuplo con los empleados]

    Returns:
        [tuple]: [tuplo con los empleados]
    """    
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.GetEmpleados
            @OutResultCode OUTPUT
        """
    )
    empleados = tuple(cursor)
    cursor.close()
    return (empleados)

def get_empleados_by_ID(Id):
    """[obtenemos el empleado con el id especifico]

    Args:
        Id ([int]): [id del empleado a pedir]

    Returns:
        [tuple]: [tuplo con el empleado]
    """    
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.GetEmpleadosByID
            ?,
            @OutResultCode OUTPUT
        """,(Id)
    )
    empleado = tuple(cursor)
    cursor.close()
    return (empleado)

def get_empleados_by_User(Id):
    """[obtenemos el empleado con el id del usuario]

    Args:
        Id ([int]): [id del usuario a pedir]

    Returns:
        [tuple]: [tuplo con el empleado]
    """    
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.GetEmpleadosByUsuario
            ?,
            @OutResultCode OUTPUT
        """,(Id)
    )
    empleado = tuple(cursor)
    cursor.close()
    return (empleado)

def insertar_empleado_BD(Nombre,TipoDI, ValorDI,Departamento,Puesto,FechaNacimiento):
    """[Insertamos un empleado a la BD]

    Args:
        Nombre ([string]): [nombre del empleaso]
        TipoDI ([int]): [id del tipo de documento identificacion]
        ValorDI ([string]): [valor del documento de identidad]
        Departamento ([int]): [id del departamento]
        Puesto ([int]): [id del puesto]
        FechaNacimiento ([string]): [fecha de nacimiento en formato AAAA-MM-DD]
    """    
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.InsertarEmpleado
            ?,
            ?,
            ?,
            ?,
            ?,
            ?,
            ?,
            @OutResultCode OUTPUT
        """,
        (Nombre,TipoDI, ValorDI,Departamento,Puesto,FechaNacimiento,True)
    )
    conn.commit()
    cursor.close()

def cambiar_visibilidad_empleado_BD(Id, value):
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.OcultarEmpleado
            ?,
            ?,
            @OutResultCode OUTPUT
        """,
        (Id,value)
    )
    conn.commit()
    cursor.close()

def editar_empleado_BD(EmpleadoId,Nombre, IdTipoIdentificacion ,ValorDocumentoIdentificacion, IdDepartamento, Puesto, FechaNacimiento):
    """[editamos un empleado de la base de datos]

    Args:
        EmpleadoId ([int]): [id del empleado que vamos a editar]
        Nombre ([string]): [nombre del empleaso]
        TipoDI ([int]): [id del tipo de documento identificacion]
        ValorDI ([string]): [valor del documento de identidad]
        Departamento ([int]): [id del departamento]
        Puesto ([int]): [id del puesto]
        FechaNacimiento ([string]): [fecha de nacimiento en formato AAAA-MM-DD]
    """    
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.EditarEmpleado
            ?,
            ?,
            ?,
            ?,
            ?,
            ?,
            ?,
            @OutResultCode OUTPUT
        """,
        (EmpleadoId, Nombre, IdTipoIdentificacion, ValorDocumentoIdentificacion, IdDepartamento, Puesto, FechaNacimiento)
    )
    conn.commit()
    cursor.close()

# -------------------------------------------- #

def get_departamentos_BD():
    """[obtenemos los departamentos de la base de datos]

    Returns:
        [touple]: [tuplo con todos los departamentos en la bd]
    """    
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.GetDepartamentos
            @OutResultCode OUTPUT
        """
    )
    departamentos = tuple(cursor)
    cursor.close()
    return (departamentos)

def get_tipos_di_BD():
    """[obtenemos de la BD los tipos de DI]

    Returns:
        [tuple]: [tuplo con los tipos de DI]
    """    
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.GetTiposDocIdent
            @OutResultCode OUTPUT
        """
    )
    tipos_di = tuple(cursor)
    cursor.close()
    return (tipos_di)

def get_administradores_BD():
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.GetAdministradores
            @OutResultCode OUTPUT
        """
    )
    administradores = tuple(cursor)
    cursor.close()
    return (administradores)

# -------------------------------------------- #
import time
def cargar_xml_BD(ruta):
    cursor = conn.cursor()
    cursor.execute(
        """
        EXEC dbo.CargarXML
            ?
        """,
        (ruta)
    )

    conn.commit()
    cursor.close()
    time.sleep(120)
 
def limpiar_tablas():
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.ReiniciarBD
            @OutResultCode OUTPUT
        """
    )
    
    conn.commit()
    cursor.close()
    

def get_planillas_semana(Id):
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.GetPlanillaSemana
            ?,
            @OutResultCode OUTPUT
        """,(Id)
    )
    planillas = tuple(cursor)
    cursor.close()
    return (planillas)


def get_marcas_semana(id_empleado,id_semana):
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT

        EXEC dbo.GetMarcasSemana
            ?,
            ?,
            @OutResultCode OUTPUT
        """,(id_empleado,id_semana)
    )
    marcas = tuple(cursor)
    cursor.close()
    return (marcas)


def get_planillas_mes(Id):
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.GetPlanillaMes 
            ?,
            @OutResultCode OUTPUT
        """,(Id)
    )
    planillas = tuple(cursor)
    cursor.close()
    return (planillas)


def get_feriados():
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.GetFeriados
            @OutResultCode OUTPUT
        """
    )
    feriados = tuple(cursor)
    cursor.close()
    return (feriados)

def get_deducciones_mes(id_empleado,id_mes):
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.GetDeduccionesMes 
            ?,
            ?,
            @OutResultCode OUTPUT
        """,(id_empleado,id_mes)
    )
    deducciones = list(cursor)
    cursor.close()
    return (deducciones)

def get_deducciones_semana(id_empleado,id_semana):
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.GetDeduccionesSemana 
            ?,
            ?,
            @OutResultCode OUTPUT
        """,(id_empleado,id_semana)
    )
    deducciones = list(cursor)
    cursor.close()
    return (deducciones)

def get_deducciones_empleado(id_empleado):
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.GetDeduccionesEmpleado 
            ?,
            @OutResultCode OUTPUT
        """,(id_empleado)
    )
    deducciones = list(cursor)
    cursor.close()
    return (deducciones)

def get_tipos_deduccion():
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.GetTiposDeduccion
            @OutResultCode OUTPUT
        """
    )
    deducciones = list(cursor)
    cursor.close()
    return (deducciones)

def asociar_deduccion(id,tipo,monto):
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.AsociarDeduccionEmpleado
            ?,
            ?,
            ?,
            @OutResultCode OUTPUT
        """,
        (id,tipo,monto)
    )
    conn.commit()
    cursor.close()

def desasociar_deduccion(id):
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.DesasociarDeduccion
            ?,

            @OutResultCode OUTPUT
        """,
        (id)
    )
    conn.commit()
    cursor.close()

def editar_deduccion(id,monto):
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.EditarDeduccionEmpleado
            ?,
            ?,

            @OutResultCode OUTPUT
        """,
        (id,monto)
    )
    conn.commit()
    cursor.close()


def get_historial_empleado(id_empleado):
    cursor = conn.cursor()
    cursor.execute(
        """
        DECLARE
            @OutResultCode INT
        
        EXEC dbo.GetHistorialEmpleado 
            ?,
            @OutResultCode OUTPUT
        """,(id_empleado)
    )
    historial = []
    try:
        historial = list(cursor)
    except:
        historial = []
    
    cursor.close()
    return (historial)
# -------------------------------------------- #

#hacemos una coneccion on la base de datos
conn = pyodbc.connect(
    "Driver={SQL Server};"
    "Server=OSWALDO\SQLEXPRESS;"
    "Database=PlanillaObrera_BD;"
    "Trusted_Connection=yes;"
)

