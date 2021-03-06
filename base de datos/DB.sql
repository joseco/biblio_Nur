USE [BiblioNur1]
GO
/****** Object:  Table [dbo].[tbl_SEG_Area]    Script Date: 04/28/2017 23:46:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SEG_Area](
	[areaId] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_tbl_SEG_Areas] PRIMARY KEY CLUSTERED 
(
	[areaId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[usp_SEG_DeleteAcceso]    Script Date: 04/28/2017 23:46:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Marcelo Castaño
-- Create date: 27/04/2017
-- Description:	<Eliminar Accesso de la lista permiso>
-- =============================================
CREATE PROCEDURE [dbo].[usp_SEG_DeleteAcceso]
	-- Add the parameters for the stored procedure here
	@intModuloId	INT,
    @intUsuarioId		INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM [BiblioNur1].[dbo].[tbl_SEG_Acceso]
    WHERE [moduloId] = @intModuloId AND [usuarioId] = @intUsuarioId

END
GO
/****** Object:  Table [dbo].[tbl_SEG_Usuario]    Script Date: 04/28/2017 23:46:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SEG_Usuario](
	[usuarioId] [int] IDENTITY(1,1) NOT NULL,
	[nombreUsuario] [nvarchar](250) NOT NULL,
	[contrasena] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_tbl_SEG_Usuario] PRIMARY KEY CLUSTERED 
(
	[usuarioId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_LOG_Bitacora]    Script Date: 04/28/2017 23:46:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_LOG_Bitacora](
	[bitacoraId] [int] IDENTITY(1,1) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[usuarioId] [int] NOT NULL,
	[programa] [nvarchar](250) NOT NULL,
	[operacion] [nvarchar](50) NOT NULL,
	[valorAnterior] [nvarchar](max) NOT NULL,
	[valorNuevo] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_Bitacora] PRIMARY KEY CLUSTERED 
(
	[bitacoraId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[usp_Seguridad_insRegistro]    Script Date: 04/28/2017 23:46:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[usp_Seguridad_insRegistro]
	@correo varchar(80),
	@contrasena varchar(100),
	@nombreCompleto varchar (100),
	@nombreUsuario varchar(20),
	@sexo varchar(12),
	@tipo varchar(15)
	
as
begin
  INSERT INTO tbl_SEG_UsuarioTipo (correo, contrasena, nombreCompleto, nombreUsuario, sexo, tipo ) 
   values(@correo,@contrasena,@nombreCompleto,@nombreUsuario,@sexo,@tipo )
end
GO
/****** Object:  StoredProcedure [dbo].[usp_Seguridad_abmUsuario]    Script Date: 04/28/2017 23:46:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[usp_Seguridad_abmUsuario]
(
@Accion					nvarchar(10),
@usuarioId				int,
@correo					varchar(80),
@contrasena				varchar(100),
@nombreCompleto			varchar (100) ,
@nombreUsuario			varchar(8),
@sexo					varchar(12),
@tipo					varchar(15)
)
AS
if @Accion = 'BORRAR'
BEGIN 
DELETE FROM tbl_Usuario where usuarioId = @usuarioId
end
if @Accion = 'MODIFICAR'
BEGIN 
UPDATE tbl_Usuario SET
correo = @correo, contrasena=@contrasena, nombreCompleto=@nombreCompleto, 
nombreUsuario=@nombreUsuario, sexo=@sexo, tipo=@tipo
WHERE usuarioId = @usuarioId
end

RETURN
GO
/****** Object:  StoredProcedure [dbo].[usp_SEG_InsertArea]    Script Date: 04/28/2017 23:46:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_SEG_InsertArea]
	@varDescripcion		NVARCHAR(250),
	@intAreaId		INT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    INSERT INTO [BiblioNur1].[dbo].[tbl_SEG_Area]
           ([descripcion])
     VALUES
           (@varDescripcion)
	
	SELECT @intAreaId = SCOPE_IDENTITY()

END
GO
/****** Object:  StoredProcedure [dbo].[usp_SEG_UpdateArea]    Script Date: 04/28/2017 23:46:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Marcelo Castaño
-- Create date: 27/04/2017
-- Description:	<Actualiza el Rol>
-- =============================================
CREATE PROCEDURE [dbo].[usp_SEG_UpdateArea]
	@intAreaId			INT,
	@varDescripcion		NVARCHAR(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    UPDATE [BiblioNur1].[dbo].[tbl_SEG_Area]
	SET [descripcion] = @varDescripcion
	WHERE [areaId] = @intAreaId

END
GO
/****** Object:  StoredProcedure [dbo].[usp_SEG_InsertUsuario]    Script Date: 04/28/2017 23:46:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Marcelo Castaño
-- Create date: 27/04/2017
-- Description:	<Inserta el usuario>
-- =============================================
CREATE PROCEDURE [dbo].[usp_SEG_InsertUsuario]
	-- Add the parameters for the stored procedure here
	@varNombreUsuario	NVARCHAR(250),
	@varContrasena		NVARCHAR(250),
	@intUsuarioId		INT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [BiblioNur1].[dbo].[tbl_SEG_Usuario]
           ([nombreUsuario]
           ,[contrasena])
     VALUES
           (@varNombreUsuario
           ,@varContrasena)

	SELECT @intUsuarioId = SCOPE_IDENTITY()
	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_SEG_UpdateUsuario]    Script Date: 04/28/2017 23:46:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Marcelo Castaño
-- Create date: 27/04/2017
-- Description:	<Actualiza Usuario>
-- =============================================
CREATE PROCEDURE [dbo].[usp_SEG_UpdateUsuario]
	-- Add the parameters for the stored procedure here
	@intUsuarioId		INT,
	@varNombreUsuario	NVARCHAR(250),
	@varContrasena		NVARCHAR(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    UPDATE [BiblioNur1].[dbo].[tbl_SEG_Usuario]
	SET [nombreUsuario] = @varNombreUsuario
      ,[contrasena] = @varContrasena
	WHERE [usuarioId] = @intUsuarioId

END
GO
/****** Object:  StoredProcedure [dbo].[usp_SEG_GetAreas]    Script Date: 04/28/2017 23:46:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_SEG_GetAreas]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT [areaId]
      ,[descripcion]
	FROM [BiblioNur1].[dbo].[tbl_SEG_Area]

END
GO
/****** Object:  StoredProcedure [dbo].[usp_SEG_GetUsuarios]    Script Date: 04/28/2017 23:46:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_SEG_GetUsuarios]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [usuarioId]
      ,[nombreUsuario]
      ,[contrasena]
	FROM [BiblioNur1].[dbo].[tbl_SEG_Usuario]

END
GO
/****** Object:  StoredProcedure [dbo].[usp_SEG_DeleteArea]    Script Date: 04/28/2017 23:46:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_SEG_DeleteArea]
	@intAreaId			INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DELETE FROM [BiblioNur1].[dbo].[tbl_SEG_Area]
      WHERE [areaId] = @intAreaId

END
GO
/****** Object:  StoredProcedure [dbo].[usp_SEG_DeleteUsuario]    Script Date: 04/28/2017 23:46:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_SEG_DeleteUsuario]
	-- Add the parameters for the stored procedure here
	@intUsuarioId	INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DELETE FROM [BiblioNur1].[dbo].[tbl_SEG_Usuario]
      WHERE [usuarioId] = @intUsuarioId
    
END
GO
/****** Object:  Table [dbo].[tbl_SEG_Modulo]    Script Date: 04/28/2017 23:46:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SEG_Modulo](
	[moduloId] [int] IDENTITY(1,1) NOT NULL,
	[areaId] [int] NOT NULL,
	[descripcion] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_tbl_SEG_Modulo] PRIMARY KEY CLUSTERED 
(
	[moduloId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_SEG_Acceso]    Script Date: 04/28/2017 23:46:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SEG_Acceso](
	[moduloId] [int] NOT NULL,
	[usuarioId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[usp_SEG_DeleteModulo]    Script Date: 04/28/2017 23:46:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_SEG_DeleteModulo]
	-- Add the parameters for the stored procedure here
	@intModuloId	INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM [BiblioNur1].[dbo].[tbl_SEG_Modulo]
    WHERE [moduloId] = @intModuloId

END
GO
/****** Object:  StoredProcedure [dbo].[usp_SEG_GetModulos]    Script Date: 04/28/2017 23:46:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_SEG_GetModulos]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [moduloId]
      ,[areaId]
      ,[descripcion]
	FROM [BiblioNur1].[dbo].[tbl_SEG_Modulo]
  
END
GO
/****** Object:  StoredProcedure [dbo].[usp_SEG_UpdateModulo]    Script Date: 04/28/2017 23:46:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Marcelo Castaño
-- Create date: 27/04/2017
-- Description:	<Actualiza Permisos>
-- =============================================
CREATE PROCEDURE [dbo].[usp_SEG_UpdateModulo]
	-- Add the parameters for the stored procedure here
	@intModuloId	INT,
	@intAreaId		INT,
	@varDescripcion	NVARCHAR(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [BiblioNur1].[dbo].[tbl_SEG_Modulo]
	SET [areaId] = @intAreaId
      ,[descripcion] = @varDescripcion
	WHERE [moduloId] = @intModuloId

END
GO
/****** Object:  StoredProcedure [dbo].[usp_SEG_InsertModulo]    Script Date: 04/28/2017 23:46:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Marcelo Castaño
-- Create date: 27/04/2017
-- Description:	<Inserta Permisos>
-- =============================================
CREATE PROCEDURE [dbo].[usp_SEG_InsertModulo]
	-- Add the parameters for the stored procedure here
	@intAreaId		INT,
	@varDescripcion	NVARCHAR(250),
	@intModuloId	INT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [BiblioNur1].[dbo].[tbl_SEG_Modulo]
           ([areaId]
           ,[descripcion])
    VALUES
           (@intAreaId
           ,@varDescripcion)

	SELECT @intModuloId = SCOPE_IDENTITY()
	
END
GO
/****** Object:  StoredProcedure [dbo].[usp_SEG_InsertAcceso]    Script Date: 04/28/2017 23:46:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_SEG_InsertAcceso]
	-- Add the parameters for the stored procedure here
	@intModuloId	INT,
    @intUsuarioId		INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [BiblioNur1].[dbo].[tbl_SEG_Acceso]
           ([moduloId]
           ,[usuarioId])
    VALUES
           (@intModuloId
           ,@intUsuarioId)

END
GO
/****** Object:  StoredProcedure [dbo].[usp_SEG_GetAccesos]    Script Date: 04/28/2017 23:46:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_SEG_GetAccesos]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [moduloId]
      ,[usuarioId]
	FROM [BiblioNur1].[dbo].[tbl_SEG_Acceso]

END
GO
/****** Object:  ForeignKey [FK_tbl_SEG_Modulo_tbl_SEG_Area]    Script Date: 04/28/2017 23:46:37 ******/
ALTER TABLE [dbo].[tbl_SEG_Modulo]  WITH CHECK ADD  CONSTRAINT [FK_tbl_SEG_Modulo_tbl_SEG_Area] FOREIGN KEY([areaId])
REFERENCES [dbo].[tbl_SEG_Area] ([areaId])
GO
ALTER TABLE [dbo].[tbl_SEG_Modulo] CHECK CONSTRAINT [FK_tbl_SEG_Modulo_tbl_SEG_Area]
GO
/****** Object:  ForeignKey [FK_tbl_SEG_Acceso_tbl_SEG_Modulo1]    Script Date: 04/28/2017 23:46:37 ******/
ALTER TABLE [dbo].[tbl_SEG_Acceso]  WITH CHECK ADD  CONSTRAINT [FK_tbl_SEG_Acceso_tbl_SEG_Modulo1] FOREIGN KEY([moduloId])
REFERENCES [dbo].[tbl_SEG_Modulo] ([moduloId])
GO
ALTER TABLE [dbo].[tbl_SEG_Acceso] CHECK CONSTRAINT [FK_tbl_SEG_Acceso_tbl_SEG_Modulo1]
GO
/****** Object:  ForeignKey [FK_tbl_SEG_Acceso_tbl_SEG_Usuario]    Script Date: 04/28/2017 23:46:37 ******/
ALTER TABLE [dbo].[tbl_SEG_Acceso]  WITH CHECK ADD  CONSTRAINT [FK_tbl_SEG_Acceso_tbl_SEG_Usuario] FOREIGN KEY([usuarioId])
REFERENCES [dbo].[tbl_SEG_Usuario] ([usuarioId])
GO
ALTER TABLE [dbo].[tbl_SEG_Acceso] CHECK CONSTRAINT [FK_tbl_SEG_Acceso_tbl_SEG_Usuario]
GO

insert into tbl_SEG_Usuario values ('admin','40bd001563085fc35165329ea1ff5c5ecbdbbeef')

