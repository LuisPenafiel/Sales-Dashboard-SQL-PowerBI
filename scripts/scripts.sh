#!/bin/bash

# Script para configurar y exportar datos del proyecto Sales-Dashboard

# 1. Crear o actualizar la base de datos
echo "Creando base de datos..."
if ! sqlite3 data/ventas.db < scripts/database.sql; then
    echo "Error al crear la base de datos. Verifica scripts/database.sql"
    exit 1
fi

# 2. Generar datos adicionales
echo "Generando datos..."
if ! python3 scripts/generar_datos.py; then
    echo "Error al generar datos. Verifica scripts/generar_datos.py"
    exit 1
fi

# 3. Exportar tabla Ventas a CSV con encabezados
echo "Exportando Ventas a CSV..."
echo "VentaID,ClienteID,Producto,Cantidad,Precio,Fecha,Region" > data/ventas.csv
if ! sqlite3 data/ventas.db ".mode csv" ".output data/ventas.csv" "SELECT * FROM Ventas;" >> data/ventas.csv; then
    echo "Error al exportar Ventas a CSV"
    exit 1
fi

# 4. Exportar tabla Clientes a CSV con encabezados
echo "ClienteID,Nombre,Segmento,Ciudad,Latitud,Longitude" > data/clientes.csv
if ! sqlite3 data/ventas.db ".mode csv" ".output data/clientes.csv" "SELECT * FROM Clientes;" >> data/clientes.csv; then
    echo "Error al exportar Clientes a CSV"
    exit 1
fi

echo "Proceso completado exitosamente!"