# Performance Monitoring Guide

Este guia explica como monitorar a performance do Daily Office após as otimizações implementadas.

## NewRelic Monitoring

O projeto usa `newrelic_rpm` para monitoramento. Após deploy, observe:

### 1. Tempo de Resposta (Response Time)

**Antes das otimizações:**
- Daily Office endpoint: 300-800ms (sem cache)
- Picos de até 1-2s em horários de pico

**Meta após otimizações:**
- Daily Office endpoint: 100-300ms (sem cache)
- Com cache: < 50ms
- Picos controlados mesmo em alta carga

### 2. Database Time

**Métricas a observar:**
- Número de queries por requisição (target: < 50)
- Tempo gasto em queries (target: < 100ms)
- Queries N+1 (devem estar eliminadas)

### 3. Cache Hit Rate

**Rails Cache:**
- PrayerBook lookups: >90% hit rate esperado
- Daily Office responses: >80% hit rate esperado

## Query Performance Analysis

### No Rails Console

```ruby
# Habilitar log de queries
ActiveRecord::Base.logger = Logger.new(STDOUT)

# Testar Daily Office
service = DailyOfficeService.new(
  date: Date.today,
  office_type: :morning,
  preferences: { prayer_book_code: 'loc_2015' }
)

# Contar queries
query_count = 0
ActiveSupport::Notifications.subscribe('sql.active_record') do
  query_count += 1
end

result = service.call
puts "Queries executadas: #{query_count}"
```

### Analisar Queries Lentas

```ruby
# Verificar explain plan de uma query específica
result = LectionaryReading.where(
  cycle: 'A',
  service_type: 'eucharist',
  prayer_book_id: 1,
  date_reference: 'advent_1'
).explain

puts result
```

## Performance Tests

### Rodar Benchmarks Localmente

```bash
# Todos os testes de performance
docker compose exec -T web bundle exec rspec spec/performance/

# Com output detalhado
docker compose exec -T web bundle exec rspec spec/performance/ --format documentation

# Apenas Daily Office
docker compose exec -T web bundle exec rspec spec/performance/daily_office_performance_spec.rb
```

### Interpretar Resultados

Os testes de performance mostram:
- **Tempo médio**: deve estar abaixo dos targets definidos
- **Queries**: número de queries executadas
- **Variação**: consistência dos tempos de resposta

Exemplo de output esperado:
```
Average DailyOfficeService time: 150.23ms ✓
Time for all 4 office types: 580.45ms ✓
Database queries for one daily office: 32 ✓
```

## Cache Monitoring

### Verificar Status do Cache

```ruby
# No Rails console
Rails.cache.stats # Se usando Redis ou Memcached

# Verificar um item específico
Rails.cache.exist?("prayer_book/loc_2015")

# Ler cache sem falhar
Rails.cache.read("prayer_book/loc_2015")

# Invalidar cache manualmente se necessário
Rails.cache.delete("prayer_book/loc_2015")
```

### Cache Keys a Monitorar

1. **PrayerBook Cache:**
   - Key pattern: `prayer_book/{code}`
   - TTL: 1 dia
   - Hit rate esperado: >90%

2. **Daily Office Cache:**
   - Key pattern: `daily_office/{date}/{office_type}/{prefs_hash}`
   - TTL: 1 dia
   - Hit rate esperado: >80%

## Database Index Usage

### Verificar se Índices Estão Sendo Usados

```sql
-- No PostgreSQL, via psql ou Rails dbconsole

-- Verificar uso do índice de LectionaryReading
EXPLAIN ANALYZE 
SELECT * FROM lectionary_readings 
WHERE cycle = 'A' 
  AND service_type = 'eucharist' 
  AND prayer_book_id = 1 
  AND date_reference = 'advent_1';

-- Verificar uso do índice de Celebration
EXPLAIN ANALYZE
SELECT * FROM celebrations
WHERE prayer_book_id = 1
  AND movable = true;
```

O output deve mostrar "Index Scan" ao invés de "Seq Scan".

## Alertas Recomendados

Configure alertas no NewRelic para:

1. **Response Time > 500ms** (sustained for 5 minutes)
   - Pode indicar problema de performance

2. **Database Time > 200ms** (sustained for 5 minutes)
   - Pode indicar queries lentas ou índices não utilizados

3. **Error Rate > 1%** (sustained for 2 minutes)
   - Pode indicar problemas com cache ou queries

4. **Throughput drops > 50%** (sudden decrease)
   - Pode indicar problema de infraestrutura

## Troubleshooting

### Performance Degradada

1. **Verificar cache:**
   ```ruby
   Rails.cache.clear # Limpar cache se corrupto
   ```

2. **Verificar índices:**
   ```sql
   SELECT schemaname, tablename, indexname, idx_scan
   FROM pg_stat_user_indexes
   WHERE tablename IN ('lectionary_readings', 'celebrations')
   ORDER BY idx_scan;
   ```
   
   Se `idx_scan` for 0, o índice não está sendo usado.

3. **Verificar plano de query:**
   - Use EXPLAIN ANALYZE em queries lentas
   - Procure por "Seq Scan" que deveria ser "Index Scan"

4. **Verificar conexões do banco:**
   ```ruby
   ActiveRecord::Base.connection_pool.stat
   ```

### Cache Miss Rate Alto

Se o hit rate estiver baixo (<70%):

1. Verificar TTL do cache (deve ser 1 dia)
2. Verificar se cache está sendo limpo frequentemente
3. Verificar memória disponível no servidor de cache
4. Considerar aumentar o TTL para dados menos voláteis

## Métricas de Sucesso

Após 1 semana em produção, esperamos ver:

- ✅ Tempo médio de resposta reduzido em >30%
- ✅ 95th percentile < 400ms
- ✅ Database time < 100ms na média
- ✅ Cache hit rate > 80%
- ✅ Número de queries por request < 50
- ✅ Zero queries N+1 reportadas
- ✅ Throughput mantido ou aumentado
