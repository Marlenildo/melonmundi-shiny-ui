# CLAUDE.md — melonmundi-shiny-ui

Pacote R `melonmundiShinyUI`: tema visual e helpers de UI compartilhados pelos
apps Shiny da MelonMundi (AgroFito, AgroFruta, AgroIrriga, AgroSolo). Regras do
ecossistema: `../melonmundi-workspace/AGENTS.md`. Detalhes: `README.md`,
`docs/SYNC.md` e `docs/DEPLOY.md`.

## Como o Claude trabalha aqui

- Ler este arquivo antes de explorar. Não revisar a repo inteira: o pacote é
  pequeno e quase tudo está nos arquivos abaixo.
- Ao fim de cada sessão, atualizar a seção "Estado atual" abaixo.

## Onde está cada coisa

- `inst/assets/melonmundi-theme.css`: tema compartilhado, fonte de verdade.
- `R/theme.R`: dependência CSS (`mm_use_theme()`).
- `R/components.R`: helpers `mm_*` (cards, alertas, rodapé, passos, fórmulas,
  `mm_before_unload_guard()` etc.).
- `scripts/sync-theme.sh`: copia o tema para `www/melonmundi-theme.css` de cada app.
- `inst/examples/`: exemplos de uso.

## Convenções

- Classes CSS com prefixo `mm-`; helpers R com prefixo `mm_`.
- Só entra aqui o que se repete entre apps. Regra, texto ou branding de um app
  fica no `www/estilo.css` do próprio app.
- O tema não carrega comportamento nem texto de produto.
- Preferir recursos nativos de Shiny/Bootstrap; CSS pequeno e localizado.
- Texto ao usuário em português com acentuação correta.
- Os apps em produção não instalam o pacote: dependem apenas do CSS
  sincronizado. Não exigir o pacote em runtime sem mudar o deploy da VPS
  (`docs/DEPLOY.md`).
- Mudança de versão: atualizar `DESCRIPTION` e `CHANGELOG.md` juntos.

## Comandos rápidos

```bash
./scripts/sync-theme.sh check all   # confere se os apps têm o tema atual
./scripts/sync-theme.sh sync <app>  # agrofito | agrofruta | agroirriga | agrosolo | all
```

```r
devtools::document()  # após mudar roxygen em R/
devtools::check()
```

Depois de mudar o tema, sincronizar os apps e registrar a nova versão do tema no
`CHANGELOG.md` de cada app afetado.

## Estado atual

- Versão: 0.2.3 (`DESCRIPTION`, `CHANGELOG.md`).
- Último trabalho: padronização dos campos Shiny e das bordas das tabelas técnicas.
- `docs/SYNC.md` ainda lista só três apps; o script e o README já incluem o
  AgroIrriga.
- Próximos passos: (preencher)
