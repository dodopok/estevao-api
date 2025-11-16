# Guia para Importar Coletas Completas

## ✅ Status Atual

Foram importadas **15 coletas iniciais** para testar a estrutura:
- 4 domingos do Advento
- Natal, Epifania, Batismo do Senhor
- Quarta-feira de Cinzas
- Páscoa, Pentecostes, Trindade
- Transfiguração, Todos os Santos
- André, Pedro e Paulo (apóstolos)

## 📝 Como Adicionar as Demais Coletas

Você tem 3 opções para adicionar todas as coletas que enviou:

### Opção 1: Editar o Arquivo Rake Task (Recomendado)

Edite o arquivo `/lib/tasks/import_collects.rake` e adicione as coletas seguindo o padrão:

```ruby
# Para domingos (com season_id)
Collect.create!(
  season: quaresma,  # ou advento, tempo_comum, etc
  sunday_reference: "1_domingo_quaresma",
  language: "pt-BR",
  text: "Texto completo da coleta aqui...",
  preface: "Prefácio para Quadra da Quaresma"
)

# Para celebrações específicas (com celebration_id)
Collect.create!(
  celebration: Celebration.find_by(name: "Nome da Celebração"),
  language: "pt-BR",
  text: "Texto completo da coleta aqui...",
  preface: "Prefácio apropriado"
)
```

### Opção 2: Criar um Arquivo CSV

Crie um arquivo `lib/data/collects.csv` com as colunas:

```csv
type,reference,text,preface
sunday,1_domingo_advento,"Texto da coleta...","Prefácio para Quadra do Advento"
celebration,Páscoa,"Texto da coleta...","Prefácio para Festa da Páscoa"
```

Depois crie uma task para importar do CSV.

### Opção 3: Usar o Rails Console

Entre no console Rails e adicione diretamente:

```bash
bin/rails console

# Exemplo:
quaresma = LiturgicalSeason.find_by(name: "Quaresma")

Collect.create!(
  season: quaresma,
  sunday_reference: "1_domingo_quaresma",
  language: "pt-BR",
  text: "Deus que nos livras de todo mal...",
  preface: "Prefácio para Quadra da Quaresma"
)
```

## 📋 Lista de Coletas a Adicionar

Com base no documento que você enviou, ainda faltam importar:

### Domingos e Quadras

**Tempo Comum (após Epifania):**
- 2º ao 9º Domingo depois da Epifania
- Último Domingo depois da Epifania

**Quaresma:**
- 1º ao 5º Domingo da Quaresma
- Domingo de Ramos
- Segunda a Quarta da Semana Santa
- Quinta-Feira Santa
- Sexta-Feira da Paixão
- Sábado Santo

**Páscoa:**
- Segunda a Sábado da Semana da Páscoa
- 2º ao 7º Domingo da Páscoa
- Ascensão

**Tempo Comum (após Pentecostes):**
- Próprios 3 a 29 (domingos de 24/maio a 26/novembro)
- Cristo Rei

### Festivais e Dias Santos

**Janeiro-Março:**
- Santo Nome e Circuncisão (1/jan)
- Confissão de Pedro (18/jan)
- Conversão de Paulo (25/jan)
- Apresentação (2/fev)
- Matias (24/fev)
- José de Nazaré (19/mar)
- Anunciação (25/mar)

**Abril-Junho:**
- Marcos (25/abr)
- Felipe e Tiago Menor (1/mai)
- Visitação (31/mai)
- Barnabé (11/jun)
- Natividade de João Batista (24/jun)

**Julho-Setembro:**
- Maria Madalena (22/jul)
- Tiago (25/jul)
- Bem-Aventurada Virgem Maria (15/ago)
- Bartolomeu (24/ago)
- Natividade da Virgem Maria (8/set)
- Santa Cruz (14/set)
- Mateus (21/set)
- Arcanjo Miguel (29/set)

**Outubro-Dezembro:**
- Lucas (18/out)
- Tiago de Jerusalém (23/out)
- Simão e Judas (28/out)
- Memorial de Todas as Almas (2/nov)
- Dia de Ação de Graças
- Tomé (21/dez)
- Estêvão (26/dez)
- João Evangelista (27/dez)
- Santos Inocentes (28/dez)

### Coletas Comuns

- Mártir
- Mestre na Fé ou Confessor(a)
- Bispo(a)
- Membro(a) de comunidade religiosa
- Missionário(a)
- Santo(a)

### Ocasiões Especiais

- Batismo
- Confirmação e Recepção
- Matrimônio
- Sepultamento (criança e adulto)
- Aniversário de Dedicação de Igreja
- Sínodos e Concílios
- Ordenação de Bispo(a)
- Ordenação de Diácono(a) ou Presbítero(a)
- Pelo Dia da Pátria

### Ocasiões Variadas

- Pela Pátria e suas Autoridades (4 variações)
- Pela Unidade da Igreja (7 variações)
- Pelas Lideranças da Igreja (4 variações)
- Pela Missão (5 variações)
- Pelas Vocações (6 variações)

## 🔧 Script Helper para Conversão

Criei um modelo de estrutura. Aqui está um exemplo de como você pode estruturar as coletas para facilitar a cópia-e-cola:

```ruby
# === QUARESMA - DOMINGOS ===
quaresma = LiturgicalSeason.find_by(name: "Quaresma")

quaresma_domingos = [
  {
    ref: "1_domingo_quaresma",
    text: "Deus que nos livras de todo mal, cujo bendito Filho foi conduzido pelo Espírito para ser tentado pelo demônio, apressa-te em socorrer a nós, que sofremos com muitas tentações, nós te rogamos. E, assim como conheces as nossas fraquezas, permite que cada qual encontre em ti o poder de salvação. Por Jesus Cristo, teu Filho, nosso Senhor, que vive e reina contigo e com o Espírito Santo, um só Deus, agora e sempre. Amém.",
    preface: "Prefácio para Quadra da Quaresma"
  },
  # ... adicione os demais
]

quaresma_domingos.each do |c|
  Collect.create!(
    season: quaresma,
    sunday_reference: c[:ref],
    language: "pt-BR",
    text: c[:text],
    preface: c[:preface]
  )
end
```

## 🚀 Executando a Importação

Depois de adicionar as coletas ao arquivo rake:

```bash
bin/rails import:collects
```

Ou se você criar uma nova task (ex: `import:all_collects`):

```bash
bin/rails import:all_collects
```

## ✅ Verificação

Para verificar quantas coletas foram importadas:

```bash
bin/rails console
> Collect.count
> Collect.where(celebration_id: nil).count  # Coletas de domingos/quadras
> Collect.where.not(celebration_id: nil).count  # Coletas de celebrações
```

## 📊 Meta Final

Baseado no documento, você deve ter aproximadamente:
- **~50-60 coletas de domingos** (Advento, Quaresma, Páscoa, Tempo Comum)
- **~30-40 coletas de festivais** (Apóstolos, Evangelistas, Santos)
- **~15-20 coletas para dias santos principais**
- **~10 coletas comuns** (tipos de santos)
- **~20 coletas para ocasiões especiais**
- **~25 coletas para ocasiões variadas**

**Total estimado: ~150-165 coletas**

## 💡 Dica

Para facilitar a entrada de dados, você pode:

1. Copiar o texto completo das coletas que enviei
2. Usar um editor de texto para fazer find/replace e criar a estrutura Ruby
3. Ou usar o Rails console interativo para ir adicionando aos poucos

Se preferir, posso criar um parser automático que lê o texto formatado e cria os registros!
