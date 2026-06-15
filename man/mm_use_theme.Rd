\name{mm_use_theme}
\alias{mm_use_theme}
\title{Attach the Shared MelonMundi Theme}
\usage{
mm_use_theme()
}
\description{
Registers the shared MelonMundi CSS dependency and the Inter font required by
the design system.
}
\value{
An \code{htmltools::tagList()} ready to be included in \code{tags$head()}.
}
\examples{
if (interactive()) {
  shiny::fluidPage(
    htmltools::tags$head(mm_use_theme()),
    mm_page_title("Exemplo")
  )
}
}
