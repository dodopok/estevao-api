#!/bin/bash
# ================================================================================
# Script wrapper para executar export_readings_to_xlsx.rb via Docker
# ================================================================================
#
# Uso:
#   ./script/export_readings.sh
#
# ================================================================================

echo "🐳 Executando exportação via Docker..."
docker-compose exec web rails runner script/export_readings_to_xlsx_alt.rb

if [ $? -eq 0 ]; then
    echo ""
    echo "📥 Copiando arquivo do container..."
    docker cp estevao-api:/rails/tmp/lectionary_readings_export.xlsx ./lectionary_readings_export.xlsx
    
    if [ $? -eq 0 ]; then
        echo "✅ Arquivo copiado com sucesso para: ./lectionary_readings_export.xlsx"
    else
        echo "❌ Erro ao copiar arquivo do container"
        echo "💡 Tente: docker cp estevao-api:/rails/tmp/lectionary_readings_export.xlsx ./lectionary_readings_export.xlsx"
    fi
else
    echo "❌ Erro ao executar script de exportação"
fi
