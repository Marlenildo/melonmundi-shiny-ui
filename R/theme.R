mm_theme_dependency <- function() {
  htmltools::htmlDependency(
    name = "melonmundi-shiny-theme",
    version = utils::packageVersion("melonmundiShinyUI"),
    src = system.file("assets", package = "melonmundiShinyUI"),
    stylesheet = "melonmundi-theme.css"
  )
}

mm_use_theme <- function() {
  htmltools::tagList(
    htmltools::tags$link(
      rel = "preconnect",
      href = "https://fonts.googleapis.com"
    ),
    htmltools::tags$link(
      rel = "preconnect",
      href = "https://fonts.gstatic.com",
      crossorigin = "anonymous"
    ),
    htmltools::tags$link(
      rel = "stylesheet",
      href = "https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
    ),
    mm_theme_dependency()
  )
}

