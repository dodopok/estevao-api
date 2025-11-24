# 📊 Scripts de Exportação/Importação de Leituras

Este diretório contém scripts para facilitar o gerenciamento das leituras do lecionário.

## 📤 Exportação de Leituras

### Script: `export_readings_to_xlsx.rb`

Exporta todas as leituras do banco de dados para um arquivo Excel (XLSX).

**O arquivo gerado contém 2 planilhas:**

1. **"Lectionary Readings"** - Todas as leituras existentes no banco
2. **"Date References Template"** - Template com linhas em branco para date_references que ainda não têm todos os ciclos (A, B, C)

**Colunas:**
- `cycle` - Ciclo litúrgico (A, B, C, ou "all")
- `service_type` - Tipo de serviço (eucharist, morning_prayer, etc)
- `date_reference` - Referência da data (ex: "1st_sunday_of_advent")
- `first_reading` - Primeira leitura
- `psalm` - Salmo responsorial
- `second_reading` - Segunda leitura
- `gospel` - Evangelho

### Como usar:

#### Opção 1: Via Docker (recomendado)
```bash
# Executar script que exporta e copia o arquivo
./script/export_readings.sh
```

O arquivo será copiado para: `./lectionary_readings_export.xlsx`

#### Opção 2: Dentro do container
```bash
# Entrar no container
docker-compose exec web bash

# Executar exportação
rails runner script/export_readings_to_xlsx.rb

# Arquivo será gerado em: tmp/lectionary_readings_export.xlsx
exit

# Copiar do container para o host
docker cp estevao-api:/rails/tmp/lectionary_readings_export.xlsx ./lectionary_readings_export.xlsx
```

#### Opção 3: Localmente (se tiver Ruby instalado)
```bash
rails runner script/export_readings_to_xlsx.rb
```

---

## 📥 Importação de Leituras

### Script: `import_readings_from_xlsx.rb`

Importa leituras de um arquivo Excel para o banco de dados.

**Funcionalidades:**
- Cria novas leituras
- Atualiza leituras existentes (baseado em cycle + service_type + date_reference)
- Pula linhas vazias ou incompletas
- Reporta estatísticas e erros

### Como usar:

#### Opção 1: Via Docker (recomendado)
```bash
# Copiar arquivo para o container
docker cp seu_arquivo.xlsx estevao-api:/app/tmp/readings_import.xlsx

# Executar importação
docker-compose exec web rails runner script/import_readings_from_xlsx.rb tmp/readings_import.xlsx
```

#### Opção 2: Dentro do container
```bash
# Entrar no container
docker-compose exec web bash

# Copiar arquivo para dentro do container (do host)
# Em outro terminal: docker cp arquivo.xlsx estevao-api:/app/tmp/

# Executar importação
rails runner script/import_readings_from_xlsx.rb tmp/arquivo.xlsx
```

#### Opção 3: Localmente (se tiver Ruby instalado)
```bash
rails runner script/import_readings_from_xlsx.rb caminho/para/arquivo.xlsx
```

---

## 🔄 Workflow Recomendado

1. **Exportar leituras atuais:**
   ```bash
   ./script/export_readings.sh
   ```

2. **Editar no Excel:**
   - Abrir `lectionary_readings_export.xlsx`
   - Usar a planilha "Date References Template" para adicionar leituras faltantes
   - Ou editar a planilha "Lectionary Readings" diretamente

3. **Importar de volta:**
   ```bash
   docker cp lectionary_readings_export.xlsx estevao-api:/app/tmp/
   docker-compose exec web rails runner script/import_readings_from_xlsx.rb tmp/lectionary_readings_export.xlsx
   ```

---

## 📋 Requisitos

As seguintes gems são necessárias (já adicionadas ao Gemfile):

```ruby
gem "caxlsx"        # Geração de arquivos Excel
gem "caxlsx_rails"  # Integração com Rails
gem "roo"           # Leitura de arquivos Excel
```

Para instalar:
```bash
docker-compose exec web bundle install
```

---

## 💡 Dicas

- O template na segunda planilha já vem com as date_references que existem no banco
- Apenas os ciclos faltantes são listados no template (se já existe ciclo A, ele não aparece)
- Ao importar, leituras existentes são **atualizadas**, não duplicadas
- Linhas vazias são automaticamente ignoradas
- Use `cycle: "all"` para leituras que valem para todos os ciclos

---

## ⚠️ Notas Importantes

- **Backup:** Sempre faça backup do banco antes de importações grandes
- **Validação:** Revise o arquivo Excel antes de importar
- **Encoding:** Use UTF-8 para caracteres especiais (acentos, etc)
- **date_reference:** Mantenha o formato snake_case (ex: `1st_sunday_of_advent`)
