# Fluxo de sincronização do tema

## Objetivo

Permitir reutilização do design entre apps sem criar dependência de runtime no
deploy da VPS e sem mexer no `melonmundi-auth`.

## Regra prática

- o tema compartilhado vive em `melonmundi-shiny-ui`
- cada app continua autocontido para deploy
- somente `www/melonmundi-theme.css` é sincronizado a partir desta fonte
- `www/estilo.css` continua específico de cada app

## Comandos

Conferir se os apps estão atualizados:

```bash
./scripts/sync-theme.sh check all
```

Atualizar um app:

```bash
./scripts/sync-theme.sh sync agrofito
```

Atualizar todos os apps mapeados:

```bash
./scripts/sync-theme.sh sync all
```

## Quando usar

Use esse fluxo quando houver mudanças em:

- cores compartilhadas
- botões compartilhados
- campos compartilhados
- grids, cards e alertas reutilizáveis
- responsividade comum

## O que não entra na sincronização

Cada app continua responsável por:

- logos do produto
- conteúdo da ajuda
- textos operacionais
- exceções visuais específicas do domínio
- CSS específico em `www/estilo.css`

## Publicação

Depois de sincronizar:

1. revisar o diff no app
2. testar o app localmente
3. fazer commit no app
4. publicar no fluxo normal do repositório do app

Assim o design compartilhado evolui em um lugar só, sem introduzir nova
dependência na VPS.
