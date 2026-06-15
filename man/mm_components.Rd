\name{mm_components}
\alias{mm_surface_card}
\alias{mm_page_title}
\alias{mm_detail_panel}
\alias{mm_info_card}
\alias{mm_card_grid}
\alias{mm_chip}
\alias{mm_inline_action}
\alias{mm_steps}
\alias{mm_alert_warning}
\alias{mm_note_warning}
\alias{mm_brand_showcase}
\alias{mm_empty_state}
\alias{mm_loading_hint}
\alias{mm_status_line}
\alias{mm_footer}
\title{Reusable MelonMundi UI Components}
\usage{
mm_surface_card(..., class = NULL)

mm_page_title(text, class = NULL, tag = c("span", "h1", "h2"))

mm_detail_panel(..., accent = FALSE, class = NULL)

mm_info_card(title, ..., icon_name = NULL, class = NULL)

mm_card_grid(..., columns = 3, class = NULL)

mm_chip(label, class = NULL)

mm_inline_action(
  label,
  href,
  icon_name = NULL,
  class = NULL,
  target = "_blank",
  rel = "noopener noreferrer"
)

mm_steps(items, class = NULL)

mm_alert_warning(..., title = NULL, icon_name = NULL, class = NULL)

mm_note_warning(..., icon_name = "info-circle", class = NULL)

mm_brand_showcase(..., class = NULL)

mm_empty_state(title, detail = NULL, class = NULL)

mm_loading_hint(title, detail = NULL, class = NULL)

mm_status_line(
  text,
  tone = c("success", "neutral", "warning"),
  icon_name = NULL,
  class = NULL
)

mm_footer(
  app_name,
  app_version = NULL,
  product_logo = NULL,
  company_logo_src = NULL,
  company_logo_alt = "MelonMundi",
  company_notice = "\u00a9 2026 MelonMundi - Global Solutions. Todos os direitos reservados.",
  license_url = NULL,
  license_label = "Licen\u00e7a propriet\u00e1ria",
  class = NULL
)
}
\arguments{
  \item{...}{Child tags or text content appended to the component.}
  \item{class}{Optional additional CSS classes.}
  \item{text}{Display text used by the title or status helpers.}
  \item{tag}{HTML tag used by \code{mm_page_title()}.}
  \item{accent}{Whether to apply the shared accent treatment to a detail panel.}
  \item{title}{Short heading used by cards, alerts or empty states.}
  \item{icon_name}{Optional Font Awesome icon name passed to \code{shiny::icon()}.}
  \item{columns}{Shared card grid variant. Supported values are \code{2} and \code{3}.}
  \item{label}{Visible label for chips, actions or license links.}
  \item{href}{Destination URL for inline actions.}
  \item{target}{Anchor target used by inline actions.}
  \item{rel}{Anchor relation used by inline actions.}
  \item{items}{Character vector or list of tags used to build a numbered steps list.}
  \item{detail}{Optional secondary text for loading and empty states.}
  \item{tone}{Shared status tone. Supported values are \code{"success"}, \code{"neutral"} and \code{"warning"}.}
  \item{app_name}{App name shown in the shared footer metadata row.}
  \item{app_version}{Optional version text shown in the footer.}
  \item{product_logo}{Optional app-specific logo tag appended beside the company logo.}
  \item{company_logo_src}{Optional URL for the shared company logo image.}
  \item{company_logo_alt}{Alternative text for the company logo.}
  \item{company_notice}{Footer copyright text.}
  \item{license_url}{Optional destination URL for the footer license link.}
  \item{license_label}{Visible label for the footer license link.}
}
\description{
Composable helpers for recurring MelonMundi Shiny surfaces. These functions
apply the shared \code{mm-*} classes so apps can reuse the same design tokens
and structural patterns without repeating markup.
}
\details{
These helpers are intentionally generic. Product-specific text, branding and
domain rules should remain in the app repository, while shared visual patterns
should stay in this package.
}
\examples{
htmltools::tagList(
  mm_page_title("Painel"),
  mm_surface_card(
    class = "mm-section-box",
    mm_card_grid(
      columns = 2,
      mm_info_card(
        title = "Consulta",
        htmltools::tags$p("Filtro compartilhado."),
        icon_name = "search"
      ),
      mm_info_card(
        title = "Ajuda",
        htmltools::tags$p("Conteúdo próprio com estrutura comum."),
        icon_name = "circle-info"
      )
    )
  )
)
}
