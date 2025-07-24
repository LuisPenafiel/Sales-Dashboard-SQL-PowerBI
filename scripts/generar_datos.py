import sqlite3
import random
from datetime import datetime, timedelta

# Conectar a la base de datos
conn = sqlite3.connect('data/ventas.db')
cursor = conn.cursor()

# Listas para datos aleatorios
productos = ['Laptop', 'Smartphone', 'Tablet', 'Auriculares', 'Monitor', 'Teclado']
regiones = ['Norte', 'Sur', 'Este', 'Oeste', 'Centro']
nombres = ['TechNova', 'Gadgets SA', 'ElectroMart', 'Juan García', 'Ana Ruiz', 'Gobierno Regional']
segmentos = ['Consumidor', 'Empresa', 'Gobierno']
ciudades = ['Madrid', 'Barcelona', 'Valencia', 'Sevilla', 'Bilbao', 'Porto']
# Coordenadas aproximadas para ciudades ibéricas
coordenadas = {
    'Madrid': (40.4168, -3.7038),
    'Barcelona': (41.3851, 2.1734),
    'Valencia': (39.4699, -0.3763),
    'Sevilla': (37.3891, -5.9845),
    'Bilbao': (43.2630, -2.9349),
    'Porto': (41.1579, -8.6291)
}

# Generar 50 clientes adicionales con coordenadas
for i in range(50):
    nombre = random.choice(nombres) + f" {i+1}"
    segmento = random.choice(segmentos)
    ciudad = random.choice(ciudades)
    lat, lon = coordenadas[ciudad]
    cursor.execute('''
    INSERT INTO Clientes (Nombre, Segmento, Ciudad, Latitud, Longitude)
    VALUES (?, ?, ?, ?, ?)
    ''', (nombre, segmento, ciudad, lat, lon))

# Generar 1000 registros de ventas (sin cambiar esto por ahora)
for i in range(1000):
    cliente_id = random.randint(1, 55)  # 5 iniciales + 50 generados
    producto = random.choice(productos)
    cantidad = random.randint(1, 20)
    precio = round(random.uniform(100, 2000), 2)
    fecha = (datetime.now() - timedelta(days=random.randint(1, 730))).strftime('%Y-%m-%d')
    region = random.choice(regiones)
    cursor.execute('''
    INSERT INTO Ventas (ClienteID, Producto, Cantidad, Precio, Fecha, Region)
    VALUES (?, ?, ?, ?, ?, ?)
    ''', (cliente_id, producto, cantidad, precio, fecha, region))

conn.commit()
conn.close()
print("Datos generados exitosamente.")