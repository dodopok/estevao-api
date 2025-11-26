#!/bin/bash
# ================================================================================
# Script para exportar leituras em formato CSV
# ================================================================================

echo "🐳 Executando exportação CSV via Docker..."
docker-compose exec web rails runner script/export_readings_to_csv.rb

if [ $? -eq 0 ]; then
    echo ""
    echo "📥 Copiando arquivo do container..."
    docker cp estevao-api:/rails/tmp/lectionary_readings_export.csv ./lectionary_readings_export.csv
    
    if [ $? -eq 0 ]; then
        echo "✅ Arquivo CSV copiado com sucesso para: ./lectionary_readings_export.csv"
    else
        echo "❌ Erro ao copiar arquivo do container"
    fi
else
    echo "❌ Erro ao executar script de exportação"
fi
