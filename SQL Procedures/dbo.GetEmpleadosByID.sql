ALTER PROCEDURE [dbo].[GetEmpleadosByID]
	@InEmpleadoId INT
	-- parametros de salida
	,@OutResultCode INT OUTPUT

AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SELECT
			@OutResultCode=0  -- codigo de ejecucion exitoso

		IF NOT EXISTS(SELECT 1 FROM dbo.Empleado E WHERE E.ID=@InEmpleadoId)
		BEGIN
			Set @OutResultCode=50001; -- el empleado no existe
			RETURN
		END;

		SELECT [ID]
			  ,[Nombre]
			  ,[IdTipoIdentificacion]
			  ,[ValorDocumentoIdentidad]
			  ,[IdDepartamento]
			  ,[IdPuesto]
			  ,[FechaNacimiento]
			  ,[Visible]
		FROM [dbo].[Empleado] WHERE ID=@InEmpleadoId
	END TRY
	BEGIN CATCH
		Set @OutResultCode=50005;
	END CATCH;
	SET NOCOUNT OFF;
END


