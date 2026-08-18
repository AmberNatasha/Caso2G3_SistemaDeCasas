
-- Script para insertar datos de muestra en dbo.CasasSistema

USE [CasoEstudioJN];
GO

INSERT INTO dbo.CasasSistema (DescripcionCasa, PrecioCasa, UsuarioAlquiler, FechaAlquiler)
VALUES
    (N'Casa Colonial Centro', 125000.00, NULL, NULL),
    (N'Apartamento Moderno', 145000.00, N'Juan Pérez', '2024-01-15'),
    (N'Casa con Jardín', 175000.00, NULL, NULL),
    (N'Loft Urbano', 98000.00, N'María López', '2024-02-20'),
    (N'Casa Campestre', 165000.00, NULL, NULL),
    (N'Apartamento Ejecutivo', 155000.00, N'Carlos Ruiz', '2024-01-10'),
    (N'Casa de Playa', 185000.00, NULL, NULL),
    (N'Estudio Céntrico', 87000.00, N'Ana García', '2024-03-05'),
    (N'Penthouse', 205000.00, N'Roberto Silva', '2023-12-01'),
    (N'Casa Tradicional', 132000.00, NULL, NULL),
    (N'Apartamento Acogedor', 148000.00, NULL, NULL),
    (N'Villa Exclusiva', 250000.00, NULL, NULL),
    (N'Casa de Esquina', 118000.00, N'Patricia Díaz', '2024-02-28'),
    (N'Apartamento Familiar', 165000.00, NULL, NULL),
    (N'Cabaña Rústica', 95000.00, NULL, NULL),
    (N'Casa Moderna', 172000.00, N'Francisco Torres', '2024-01-30'),
    (N'Apartamento Céntrico', 142000.00, NULL, NULL),
    (N'Casa de Inversión', 158000.00, N'Elena Morales', '2024-03-15'),
    (N'Duplex Contemporáneo', 178000.00, NULL, NULL),
    (N'Casa Residencial', 138000.00, NULL, NULL),
    (N'Apartamento Premium', 195000.00, N'David Gómez', '2023-11-20'),
    (N'Casa Clásica', 168000.00, NULL, NULL);
GO
