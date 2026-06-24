# melonmundiShinyUI

Pacote interno de UI para os apps Shiny da MelonMundi.

## Objetivo

Centralizar em uma fonte de verdade única:

- tema visual compartilhado (`melonmundi-theme.css`)
- componentes de layout recorrentes
- helpers R para construir superfícies comuns sem duplicação entre apps

O pacote foi desenhado para que cada app mantenha localmente apenas:

- branding específico do produto
- cards e badges de domínio
- assets próprios (`logo`, imagens, ícones específicos)
- fluxos e textos do app

## Estrutura

- `inst/assets/melonmundi-theme.css`: tema compartilhado
- `R/theme.R`: dependência CSS e carregamento do tema
- `R/components.R`: helpers reutilizáveis `mm_*`

## Helpers disponíveis

- `mm_use_theme()`
- `mm_surface_card()`
- `mm_page_title()`
- `mm_detail_panel()`
- `mm_info_card()`
- `mm_card_grid()`
- `mm_chip()`
- `mm_inline_action()`
- `mm_steps()`
- `mm_alert_warning()`
- `mm_note_warning()`
- `mm_brand_showcase()`
- `mm_empty_state()`
- `mm_loading_hint()`
- `mm_status_line()`
- `mm_formula_card()`
- `mm_before_unload_guard()`
- `mm_footer()`

## Primitivos de layout compartilhados

Além dos helpers R, o tema compartilhado já concentra classes reutilizáveis para
estrutura e responsividade:

- `mm-field-stack`: pilha vertical uniforme entre grupos de campos
- `mm-field-grid`: grade de campos em duas colunas que empilha no mobile
- `mm-field-grid-compact`: linha com campo principal e campo lateral compacto
- `mm-field-grid-wide-side`: linha com campo principal e campo lateral mais largo
- `mm-matrix-grid`: grade matricial simétrica para entradas tabulares
- `mm-workspace-grid`: ajuste consistente entre colunas principais da página
- `mm-formula-card`, `mm-formula-list`, `mm-formula-badge`: cards e badges para fórmulas em abas de ajuda
- `mm-modal-cancel-btn`, `mm-modal-primary-btn`, `mm-modal-danger-btn`: botões padronizados para rodapés de modais

## Convenções

- Classes compartilhadas usam prefixo `mm-`
- Helpers compartilhados usam prefixo `mm_`
- Regras específicas de um app não entram neste pacote
- O tema compartilhado não deve carregar comportamento ou texto de produto

## Exemplo mínimo

```r
library(shiny)
library(melonmundiShinyUI)

ui <- fluidPage(
  tags$head(mm_use_theme()),
  mm_page_title("Painel de exemplo"),
  tags$p("Base compartilhada para apps MelonMundi."),
  mm_surface_card(
    class = "mm-section-box",
    mm_card_grid(
      columns = 2,
      mm_info_card(
        "Consulta",
        tags$p("Superfície compartilhada para filtros e resultados."),
        icon_name = "search"
      ),
      mm_info_card(
        "Ajuda",
        tags$p("Cards e grids podem ser reaproveitados com conteúdo diferente."),
        icon_name = "circle-info"
      )
    )
  )
)

server <- function(input, output, session) {}

shinyApp(ui, server)
```

## Adoção nos apps

1. Instalar o pacote localmente ou via Git interno.
2. Trocar o carregamento manual do CSS por `mm_use_theme()`.
3. Migrar classes locais genéricas para helpers `mm_*`.
4. Manter no `www/estilo.css` do app apenas o que for específico daquele produto.

## Sincronização do tema

Sem mexer no `melonmundi-auth`, o fluxo recomendado é manter os apps
autocontidos e sincronizar apenas o arquivo de tema compartilhado.

O script [`scripts/sync-theme.sh`](scripts/sync-theme.sh) copia:

- origem: `inst/assets/melonmundi-theme.css`
- destino: `www/melonmundi-theme.css` em cada app

Uso:

```bash
./scripts/sync-theme.sh check all
./scripts/sync-theme.sh sync agrofito
./scripts/sync-theme.sh sync all
```

Apps suportados hoje:

- `agrofito`
- `agrofruta`
- `agrosolo`

Se o guarda-chuva local estiver em outro caminho, use `MELONMUNDI_ROOT`:

```bash
MELONMUNDI_ROOT=/caminho/para/melonmundi ./scripts/sync-theme.sh sync agrofito
```

O script altera apenas `www/melonmundi-theme.css`. Cada app continua dono de:

- `www/estilo.css`
- logos e imagens
- textos e componentes específicos do produto

## Estado atual dos apps

Os apps abaixo estão sincronizados com `inst/assets/melonmundi-theme.css`:

- `app-agrofito`
- `app-agrofruta`
- `app-agrosolo`

Use `./scripts/sync-theme.sh check all` antes de publicar mudanças no tema para
confirmar que todos continuam usando a mesma base compartilhada.

## Deploy na VPS

O fluxo atual de produção da MelonMundi sincroniza apenas o repositório do app
para a VPS. Isso significa que este pacote separado não passa a existir em
produção automaticamente só por estar em outro repositório.

Resumo prático:

- `app-agrofito` continua publicável como hoje enquanto estiver autocontido
- para um app depender deste pacote em runtime, o deploy da VPS precisa instalar
  `melonmundiShinyUI`

Detalhes e caminhos de adoção estão em [`docs/DEPLOY.md`](docs/DEPLOY.md).

## Próximos passos recomendados

- manter `inst/assets/melonmundi-theme.css` como fonte de verdade do tema
- sincronizar os apps sempre que o tema compartilhado mudar
- mover helpers recorrentes dos apps para este pacote apenas quando o padrão realmente se repetir
