# melonmundi-shiny-ui - Regras Locais para Agentes

Pacote R `melonmundiShinyUI`: tema visual e helpers de UI compartilhados pelos
apps Shiny da MelonMundi (AgroFito, AgroFruta, AgroIrriga, AgroSolo). Regras do
ecossistema: `../melonmundi-workspace/AGENTS.md`. Detalhes: `README.md`,
`docs/SYNC.md` e `docs/DEPLOY.md`.

## Responsabilidade

- `inst/assets/melonmundi-theme.css`: tema compartilhado, fonte de verdade.
- `R/theme.R`: dependência CSS (`mm_use_theme()`).
- `R/components.R`: helpers `mm_*` (cards, alertas, rodapé, passos, fórmulas,
  `mm_before_unload_guard()` etc.).
- `scripts/sync-theme.sh`: copia o tema para `www/melonmundi-theme.css` de cada app.
- `inst/examples/`: exemplos de uso.

## Cuidados obrigatórios

- Classes CSS com prefixo `mm-`; helpers R com prefixo `mm_`.
- Só entra aqui o que se repete entre apps. Regra, texto ou branding de um app
  fica no `www/estilo.css` do próprio app.
- O tema não carrega comportamento nem texto de produto.
- Preferir recursos nativos de Shiny/Bootstrap; CSS pequeno e localizado.
- Todo texto exibido ao usuário deve seguir o português brasileiro com
  acentuação correta.
- Os apps em produção não instalam o pacote: dependem apenas do CSS
  sincronizado. Não exigir o pacote em runtime sem mudar o deploy da VPS
  (`docs/DEPLOY.md`).
- Nunca editar `www/melonmundi-theme.css` dentro de um app: alterar aqui e
  sincronizar.
- Mudança de versão: atualizar `DESCRIPTION` e `CHANGELOG.md` juntos.

## Verificação recomendada

```bash
./scripts/sync-theme.sh check all   # confere se os apps têm o tema atual
./scripts/sync-theme.sh sync <app>  # agrofito | agrofruta | agroirriga | agrosolo | all
```

```r
devtools::document()  # após mudar roxygen em R/
devtools::check()
```

Depois de mudar o tema, sincronizar os apps, validar cada app afetado no
navegador (desktop e celular) e registrar a nova versão do tema no
`CHANGELOG.md` de cada app.
