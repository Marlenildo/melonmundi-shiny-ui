# Changelog

Todas as alterações relevantes deste projeto serão documentadas neste arquivo.

## [0.2.4] - 2026-11-10

### Corrigido

- Menus abertos dentro de um `mm-surface-card` (selectize e dropdown do Bootstrap) ficam por cima do cartão seguinte. Antes, o `backdrop-filter` do cartão prendia o menu na camada dele, e as opções que passavam da borda ficavam escondidas atrás do próximo cartão (no AgroFito, os filtros atrás dos resultados).

## [0.2.3] - 2026-07-27

### Alterado

- Restaura as dimensões nativas dos campos do Shiny, preservando as cores, a tipografia e o foco do tema MelonMundi.
- Alinha cabeçalhos, rótulos e campos das matrizes ao tamanho padrão dos controles.
- Aplica a paleta MelonMundi aos estados de seleção e interação do calendário.

## [0.2.2] - 2026-06-30

### Alterado

- Padroniza em cinza o contorno e as divisórias das tabelas técnicas da Ajuda.
- Garante borda superior visível e consistente nas tabelas estáticas compartilhadas.

## [0.2.1] - 2026-06-28

### Alterado

- Padroniza Aviso Legal e Ajuda com a mesma largura informativa nos apps Shiny.
- Centraliza a largura das páginas informativas no token `--mm-informative-page-max-width`.

## [0.2.0] - 2026-06-28

### Adicionado

- Adiciona tabelas técnicas compartilhadas com `mm-rule-table`.
- Adiciona layouts compartilhados para campos, fórmulas, ajuda e aviso legal.
- Padroniza campos de data, modais e superficies recorrentes entre os apps.

### Alterado

- Consolida AgroSolo, AgroFito, AgroFruta e AgroIrriga na mesma fonte de tema.
