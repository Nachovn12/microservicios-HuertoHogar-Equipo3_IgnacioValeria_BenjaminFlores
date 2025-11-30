#!/bin/bash
BASE_URL="http://localhost:8083/api/carritos"

echo "Creando carrito..."
# Requiere jq instalado
ID=$(curl -s -X POST $BASE_URL -H "Content-Type: application/json" -d '{"usuarioId":1}' | jq -r .id)
echo "Carrito ID: $ID"

echo "Agregando item..."
curl -s -X POST "$BASE_URL/$ID/items" -H "Content-Type: application/json" -d '{"productoId":101,"cantidad":2}' > /dev/null

echo "Confirmando compra..."
curl -s -X POST "$BASE_URL/confirmar/$ID"
echo -e "\nListo."