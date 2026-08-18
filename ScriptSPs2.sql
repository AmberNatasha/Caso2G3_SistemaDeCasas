-- Script para crear Stored Procedures de consulta en la tabla dbo.CasasSistema

USE [CasoEstudioJN];
GO

-- SP 1: Obtener todas las casas
CREATE OR ALTER PROCEDURE sp_ObtenerTodasLasCasas
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        IdCasa,
        DescripcionCasa,
        PrecioCasa,
        UsuarioAlquiler,
        FechaAlquiler
    FROM dbo.CasasSistema
    ORDER BY IdCasa;
END
GO

CREATE OR ALTER PROCEDURE sp_AlquilarCasa
    @IdCasa BIGINT,
    @UsuarioAlquiler NVARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.CasasSistema
    SET UsuarioAlquiler = @UsuarioAlquiler,
        FechaAlquiler = GETDATE()
    WHERE IdCasa = @IdCasa
      AND UsuarioAlquiler IS NULL;

    IF @@ROWCOUNT = 0
        THROW 50001, 'La casa seleccionada no está disponible.', 1;
END
GO

-- SP 2: Obtener casa por ID
CREATE OR ALTER PROCEDURE sp_ObtenerCasaPorId
    @IdCasa BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        IdCasa,
        DescripcionCasa,
        PrecioCasa,
        UsuarioAlquiler,
        FechaAlquiler
    FROM dbo.CasasSistema
    WHERE IdCasa = @IdCasa;
END
GO

-- SP 3: Obtener casas disponibles (sin alquiler)
CREATE OR ALTER PROCEDURE sp_ObtenerCasasDisponibles
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        IdCasa,
        DescripcionCasa,
        PrecioCasa,
        UsuarioAlquiler,
        FechaAlquiler
    FROM dbo.CasasSistema
    WHERE UsuarioAlquiler IS NULL
    ORDER BY PrecioCasa;
END
GO

-- SP 4: Obtener casas alquiladas
CREATE OR ALTER PROCEDURE sp_ObtenerCasasAlquiladas
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        IdCasa,
        DescripcionCasa,
        PrecioCasa,
        UsuarioAlquiler,
        FechaAlquiler
    FROM dbo.CasasSistema
    WHERE UsuarioAlquiler IS NOT NULL
    ORDER BY FechaAlquiler DESC;
END
GO

-- SP 5: Buscar casas por descripción
CREATE OR ALTER PROCEDURE sp_BuscarCasasPorDescripcion
    @Descripcion NVARCHAR(500)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        IdCasa,
        DescripcionCasa,
        PrecioCasa,
        UsuarioAlquiler,
        FechaAlquiler
    FROM dbo.CasasSistema
    WHERE DescripcionCasa LIKE '%' + @Descripcion + '%'
    ORDER BY IdCasa;
END
GO

-- SP 6: Obtener casas por rango de precio
CREATE OR ALTER PROCEDURE sp_ObtenerCasasPorRangoPrecio
    @PrecioMinimo DECIMAL(10,2),
    @PrecioMaximo DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        IdCasa,
        DescripcionCasa,
        PrecioCasa,
        ISNULL(UsuarioAlquiler, '') AS UsuarioAlquiler,
        FechaAlquiler
    FROM dbo.CasasSistema
    WHERE PrecioCasa BETWEEN @PrecioMinimo AND @PrecioMaximo
    ORDER BY PrecioCasa;
END
GO

-- SP 7: Obtener casas alquiladas por usuario
CREATE OR ALTER PROCEDURE sp_ObtenerCasasPorUsuario
    @UsuarioAlquiler NVARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        IdCasa,
        DescripcionCasa,
        PrecioCasa,
        UsuarioAlquiler,
        FechaAlquiler
    FROM dbo.CasasSistema
    WHERE UsuarioAlquiler = @UsuarioAlquiler
    ORDER BY FechaAlquiler DESC;
END
GO

-- SP 8: Obtener estadísticas de casas
CREATE OR ALTER PROCEDURE sp_ObtenerEstadisticasCasas
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        COUNT(*) AS TotalCasas,
        SUM(CASE WHEN UsuarioAlquiler IS NULL THEN 1 ELSE 0 END) AS CasasDisponibles,
        SUM(CASE WHEN UsuarioAlquiler IS NOT NULL THEN 1 ELSE 0 END) AS CasasAlquiladas,
        AVG(PrecioCasa) AS PrecioPromedio,
        MIN(PrecioCasa) AS PrecioMinimo,
        MAX(PrecioCasa) AS PrecioMaximo
    FROM dbo.CasasSistema;
END
GO
