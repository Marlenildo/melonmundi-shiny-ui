# Deploy e adoção

## Situação atual

Hoje o deploy de produção dos apps Shiny segue este fluxo:

1. push no repositório do app
2. GitHub Actions do app aciona o deploy
3. a VPS roda `sync-prod-content.sh <app>`
4. o script clona apenas o repositório do app e sincroniza seu conteúdo
5. o container `shiny` é reiniciado

Esse fluxo presume que o app é autocontido no próprio repositório.

## O que isso significa para este pacote

Criar `melonmundiShinyUI` como repositório separado é a opção mais limpa para
fonte de verdade compartilhada, mas esse pacote **não entra automaticamente em
produção** no fluxo atual.

Se um app passar a depender diretamente de `melonmundiShinyUI`, a VPS precisará
ter acesso ao pacote durante o deploy ou durante o build da imagem.

## Caminhos possíveis

### 1. Compatibilidade imediata com o fluxo atual

Manter o app autocontido em produção, usando este repositório como fonte de
verdade e copiando para o app apenas os assets e helpers compartilhados
necessários.

Vantagem:

- não exige mudar o deploy atual

Limitação:

- ainda existe sincronização de código entre repositórios

### 2. Dependência real de pacote compartilhado

Atualizar a infraestrutura para instalar `melonmundiShinyUI` no ambiente Shiny.

Opções comuns:

- instalar o pacote na imagem Docker do Shiny
- instalar o pacote no deploy antes de reiniciar o container
- clonar o repositório compartilhado no processo de sync e rodar `R CMD INSTALL`

Vantagem:

- uma única fonte de verdade efetiva em runtime

Limitação:

- exige ajuste no deploy da VPS

## Recomendação para a MelonMundi

1. usar este repositório como fonte de verdade compartilhada agora
2. manter `app-agrofito` autocontido até o pacote entrar no deploy da VPS
3. depois evoluir `melonmundi-auth` para instalar o pacote compartilhado de forma reproduzível

Assim a padronização começa já, sem quebrar o fluxo atual de publicação.
