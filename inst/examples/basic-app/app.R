library(shiny)
library(melonmundiShinyUI)

ui <- fluidPage(
  tags$head(mm_use_theme()),
  mm_page_title("Exemplo MelonMundi"),
  tags$p("Exemplo mínimo do pacote interno de UI."),
  mm_surface_card(
    class = "mm-section-box",
    mm_card_grid(
      columns = 3,
      mm_info_card(
        "Cards",
        tags$p("Use os mesmos estilos compartilhados com conteúdo diferente."),
        icon_name = "table-cells-large"
      ),
      mm_info_card(
        "Ações",
        mm_inline_action("Abrir documentação", "#", icon_name = "up-right-from-square"),
        tags$p("Botões inline podem ser reutilizados entre os apps."),
        icon_name = "bolt"
      ),
      mm_info_card(
        "Avisos",
        tags$p("Alertas e notas também vêm da mesma base."),
        icon_name = "triangle-exclamation"
      )
    ),
    mm_note_warning(
      tags$p("Este app é apenas um exemplo local de adoção do pacote.")
    )
  )
)

server <- function(input, output, session) {}

shinyApp(ui, server)
