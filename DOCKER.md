# Guia Docker - Estêvão API

Instruções para rodar a aplicação completa (Rails + PostgreSQL) usando Docker.

## Pré-requisitos

- Docker instalado (versão 20.10 ou superior)
- Docker Compose instalado (versão 2.0 ou superior)

## Iniciar a aplicação

### 1. Build e iniciar os containers

```bash
docker-compose up --build
```

Ou em modo detached (background):

```bash
docker-compose up -d --build
```

Isso irá:
- Criar um container PostgreSQL 16
- Criar um container com a aplicação Rails
- Configurar o banco de dados automaticamente
- Iniciar o servidor Rails na porta 3000

### 2. Acessar a aplicação

A API estará disponível em:
```
http://localhost:3000
```

Teste acessando:
```
http://localhost:3000/api/v1/celebrations
```

## Comandos úteis

### Ver logs dos containers

```bash
# Todos os containers
docker-compose logs -f

# Apenas a aplicação Rails
docker-compose logs -f web

# Apenas o PostgreSQL
docker-compose logs -f db
```

### Executar comandos Rails

```bash
# Rodar migrations
docker-compose exec web bin/rails db:migrate

# Rodar seeds
docker-compose exec web bin/rails db:seed

# Resetar o banco de dados
docker-compose exec web bin/rails db:reset

# Abrir console Rails
docker-compose exec web bin/rails console

# Rodar testes
docker-compose exec web bin/rails test
```

### Acessar o container

```bash
# Bash no container da aplicação
docker-compose exec web bash

# Bash no container do PostgreSQL
docker-compose exec db bash
```

### Acessar o PostgreSQL diretamente

```bash
docker-compose exec db psql -U postgres -d estevao_api_development
```

### Parar os containers

```bash
# Parar e manter os volumes (dados persistem)
docker-compose down

# Parar e remover volumes (apaga o banco de dados)
docker-compose down -v
```

### Rebuild da aplicação

Se você modificar o Gemfile ou arquivos de sistema:

```bash
docker-compose down
docker-compose up --build
```

### Ver status dos containers

```bash
docker-compose ps
```

## Estrutura do Docker Compose

A configuração cria dois serviços:

### 1. **db** (PostgreSQL)
- Imagem: `postgres:16-alpine`
- Porta: `5432` (mapeada para host)
- Volume: `postgres_data` (dados persistentes)
- Credenciais:
  - User: `postgres`
  - Password: `postgres`
  - Database: `estevao_api_development`

### 2. **web** (Rails)
- Build: `Dockerfile.dev`
- Porta: `3000` (mapeada para host)
- Volumes:
  - Código fonte montado (hot-reload habilitado)
  - Cache de gems (`bundle_cache`)
- Depende do serviço `db`

## Desenvolvimento

O código fonte é montado como volume, então qualquer alteração nos arquivos Ruby será refletida automaticamente (você pode precisar reiniciar o servidor Rails dependendo do tipo de mudança).

Para reiniciar apenas o Rails:

```bash
docker-compose restart web
```

## Troubleshooting

### Porta 3000 já em uso

Se você tiver um Rails rodando localmente, pare-o primeiro ou mude a porta no `docker-compose.yml`:

```yaml
ports:
  - "3001:3000"  # Muda para porta 3001 no host
```

### Porta 5432 já em uso

Se você tiver um PostgreSQL rodando localmente, pare-o ou mude a porta:

```yaml
ports:
  - "5433:5432"  # Muda para porta 5433 no host
```

### Problemas com permissões

```bash
# Dar permissão de execução aos scripts
chmod +x bin/*
```

### Problemas com gems

```bash
# Remover cache e rebuildar
docker-compose down -v
docker-compose up --build
```

### Ver variáveis de ambiente

```bash
docker-compose exec web env
```

## Produção

Para produção, use o `Dockerfile` principal (não o `Dockerfile.dev`):

```bash
docker build -t estevao-api .
docker run -d -p 3000:80 \
  -e SECRET_KEY_BASE=<sua_secret_key> \
  -e DATABASE_URL=<postgresql_url> \
  -e RAILS_ENV=production \
  --name estevao-api estevao-api
```

Veja o README.md principal para mais detalhes sobre deploy em produção.
