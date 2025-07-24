-- Crear tabla Clientes
CREATE TABLE IF NOT EXISTS Clientes (
    ClienteID INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre TEXT NOT NULL,
    Segmento TEXT NOT NULL,
    Ciudad TEXT NOT NULL,
    Latitud REAL,
    Longitude REAL
);

-- Crear tabla Ventas
CREATE TABLE IF NOT EXISTS Ventas (
    VentaID INTEGER PRIMARY KEY AUTOINCREMENT,
    ClienteID INTEGER,
    Producto TEXT NOT NULL,
    Cantidad INTEGER NOT NULL,
    Precio REAL NOT NULL,
    Fecha DATE NOT NULL,
    Region TEXT NOT NULL,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Insertar datos iniciales en Clientes
INSERT INTO Clientes (Nombre, Segmento, Ciudad, Latitud, Longitude) VALUES
('TechCorp', 'Empresa', 'Madrid', 40.4168, -3.7038),
('Juan Pérez', 'Consumidor', 'Barcelona', 41.3851, 2.1734),
('Gobierno Local', 'Gobierno', 'Valencia', 39.4699, -0.3763),
('María López', 'Consumidor', 'Sevilla', 37.3891, -5.9845),
('Innovatech', 'Empresa', 'Bilbao', 43.2630, -2.9349),
('PortoCo', 'Empresa', 'Porto', 41.1579, -8.6291);

-- Insertar datos iniciales en Ventas
INSERT INTO Ventas (ClienteID, Producto, Cantidad, Precio, Fecha, Region) VALUES
(1, 'Laptop', 5, 1200.50, '2023-01-15', 'Norte'),
(2, 'Smartphone', 10, 800.00, '2023-02-20', 'Sur'),
(3, 'Tablet', 3, 500.75, '2023-03-10', 'Este'),
(4, 'Laptop', 2, 1200.50, '2023-04-05', 'Oeste'),
(5, 'Smartphone', 7, 800.00, '2023-05-12', 'Norte');

-- Consultas de ejemplo
-- 1. Ingresos totales por región
SELECT Region, SUM(Cantidad * Precio) AS Ingresos
FROM Ventas
GROUP BY Region
ORDER BY Ingresos DESC;

-- 2. Ventas por segmento de cliente
SELECT c.Segmento, COUNT(v.VentaID) AS Total_Ventas, SUM(v.Cantidad * v.Precio) AS Ingresos
FROM Ventas v
JOIN Clientes c ON v.ClienteID = c.ClienteID
GROUP BY c.Segmento;

-- 3. Top 5 productos por ingresos
SELECT Producto, SUM(Cantidad * Precio) AS Ingresos
FROM Ventas
GROUP BY Producto
ORDER BY Ingresos DESC
LIMIT 5;