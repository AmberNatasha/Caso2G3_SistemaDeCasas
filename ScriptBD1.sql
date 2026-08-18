
-- Script para crear la base de datos CasoEstudioJN y la tabla dbo.Casas

IF DB_ID(N'CasoEstudioJN') IS NULL
BEGIN
    CREATE DATABASE [CasoEstudioJN];
END
GO

-- Cambiar contexto a la nueva base de datos
USE [CasoEstudioJN];
GO

-- Crear la tabla si no existe
IF OBJECT_ID(N'dbo.CasasSistema', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.CasasSistema
    (
        IdCasa BIGINT NOT NULL IDENTITY(1,1) CONSTRAINT PK_Casas_IdCasa PRIMARY KEY,
        DescripcionCasa NVARCHAR(500) NOT NULL,
        PrecioCasa DECIMAL(10,2) NOT NULL,
        UsuarioAlquiler NVARCHAR(30) NULL,
        FechaAlquiler DATETIME NULL
    );
END
GO

IF COL_LENGTH(N'dbo.CasasSistema', N'UsuarioAlquiler') IS NULL
BEGIN
    ALTER TABLE dbo.CasasSistema ADD UsuarioAlquiler NVARCHAR(30) NULL;
END
GO

ALTER TABLE dbo.CasasSistema ALTER COLUMN DescripcionCasa NVARCHAR(500) NOT NULL;
GO

ALTER TABLE dbo.CasasSistema ALTER COLUMN UsuarioAlquiler NVARCHAR(30) NULL;
GO

IF COL_LENGTH(N'dbo.CasasSistema', N'FechaAlquiler') IS NULL
BEGIN
    ALTER TABLE dbo.CasasSistema ADD FechaAlquiler DATETIME NULL;
END
GO
