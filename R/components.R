mm_join_classes <- function(...) {
  classes <- unlist(list(...), use.names = FALSE)
  classes <- trimws(classes)
  classes <- classes[nzchar(classes)]
  paste(classes, collapse = " ")
}

mm_surface_card <- function(..., class = NULL) {
  htmltools::tags$div(
    class = mm_join_classes("mm-surface-card", class),
    ...
  )
}

mm_page_title <- function(text, class = NULL, tag = c("span", "h1", "h2")) {
  tag <- match.arg(tag)
  do.call(
    htmltools::tags[[tag]],
    list(class = mm_join_classes("mm-page-title", class), text)
  )
}

mm_detail_panel <- function(..., accent = FALSE, class = NULL) {
  htmltools::tags$div(
    class = mm_join_classes(
      "mm-detail-panel",
      if (isTRUE(accent)) "mm-detail-panel-accent",
      class
    ),
    ...
  )
}

mm_info_card <- function(title, ..., icon_name = NULL, class = NULL) {
  htmltools::tags$div(
    class = mm_join_classes("mm-info-card", class),
    if (!is.null(icon_name)) shiny::icon(icon_name),
    htmltools::tags$h4(title),
    ...
  )
}

mm_card_grid <- function(..., columns = 3, class = NULL) {
  if (!(columns %in% c(2, 3))) {
    stop("`columns` must be 2 or 3.", call. = FALSE)
  }

  htmltools::tags$div(
    class = mm_join_classes("mm-card-grid", paste0("mm-card-grid-", columns), class),
    ...
  )
}

mm_chip <- function(label, class = NULL) {
  htmltools::tags$span(
    class = mm_join_classes("mm-chip", class),
    label
  )
}

mm_inline_action <- function(label, href, icon_name = NULL, class = NULL, target = "_blank", rel = "noopener noreferrer") {
  htmltools::tags$a(
    href = href,
    target = target,
    rel = rel,
    class = mm_join_classes("mm-inline-action", class),
    if (!is.null(icon_name)) shiny::icon(icon_name),
    htmltools::tags$span(label)
  )
}

mm_steps <- function(items, class = NULL) {
  if (is.character(items)) {
    items <- lapply(seq_along(items), function(i) {
      htmltools::tags$li(
        htmltools::tags$span(as.character(i)),
        items[[i]]
      )
    })
  }

  if (!is.list(items)) {
    stop("`items` must be a character vector or a list of tags.", call. = FALSE)
  }

  do.call(
    htmltools::tags$ol,
    c(list(class = mm_join_classes("mm-steps", class)), items)
  )
}

mm_alert_warning <- function(..., title = NULL, icon_name = NULL, class = NULL) {
  content <- list()

  if (!is.null(title)) {
    content <- c(
      content,
      list(
        htmltools::tags$p(
          class = "mm-alert-title",
          if (!is.null(icon_name)) shiny::icon(icon_name),
          title
        )
      )
    )
  }

  content <- c(content, list(...))

  do.call(
    htmltools::tags$div,
    c(list(class = mm_join_classes("mm-alert-warning", class)), content)
  )
}

mm_note_warning <- function(..., icon_name = "info-circle", class = NULL) {
  htmltools::tags$div(
    class = mm_join_classes("mm-note-warning", class),
    if (!is.null(icon_name)) shiny::icon(icon_name),
    ...
  )
}

mm_brand_showcase <- function(..., class = NULL) {
  htmltools::tags$div(
    class = mm_join_classes("mm-brand-showcase", class),
    ...
  )
}

mm_empty_state <- function(title, detail = NULL, class = NULL) {
  htmltools::tags$div(
    class = mm_join_classes(
      "mm-empty-box",
      if (!is.null(detail)) "mm-empty-message",
      class
    ),
    if (!is.null(detail)) {
      list(
        htmltools::tags$div(class = "mm-empty-message-title", title),
        htmltools::tags$div(class = "mm-empty-message-detail", detail)
      )
    } else {
      title
    }
  )
}

mm_loading_hint <- function(title, detail = NULL, class = NULL) {
  htmltools::tags$div(
    class = mm_join_classes("mm-loading-inline", class),
    htmltools::tags$div(class = "mm-loading-spinner", shiny::icon("spinner", class = "fa-spin")),
    htmltools::tags$div(class = "mm-loading-title", title),
    if (!is.null(detail)) htmltools::tags$div(class = "mm-loading-detail", detail)
  )
}

mm_status_line <- function(text, tone = c("success", "neutral", "warning"), icon_name = NULL, class = NULL) {
  tone <- match.arg(tone)

  htmltools::tags$div(
    class = mm_join_classes("mm-status-line", paste0("mm-status-", tone), class),
    if (!is.null(icon_name)) shiny::icon(icon_name, class = "mm-status-icon"),
    htmltools::tags$span(text)
  )
}

mm_footer <- function(app_name, app_version = NULL, product_logo = NULL, company_logo_src = NULL, company_logo_alt = "MelonMundi", company_notice = "\u00a9 2026 MelonMundi - Global Solutions. Todos os direitos reservados.", license_url = NULL, license_label = "Licen\u00e7a propriet\u00e1ria", class = NULL) {
  footer_meta <- if (!is.null(app_version) || !is.null(license_url)) {
    htmltools::tags$div(
      class = "mm-footer-line mm-footer-line-legal",
      if (!is.null(app_version)) htmltools::tags$span(paste0(app_name, " v", app_version, if (!is.null(license_url)) " | " else "")),
      if (!is.null(license_url)) htmltools::tags$a(href = license_url, target = "_blank", license_label)
    )
  }

  htmltools::tags$footer(
    class = mm_join_classes("mm-footer", class),
    htmltools::tags$div(
      class = "mm-footer-logos",
      if (!is.null(company_logo_src)) htmltools::tags$img(
        class = "mm-footer-logo",
        src = company_logo_src,
        alt = company_logo_alt
      ),
      product_logo
    ),
    htmltools::tags$div(
      class = "mm-footer-content",
      htmltools::tags$div(
        class = "mm-footer-line mm-footer-line-main",
        htmltools::tags$span(company_notice)
      ),
      footer_meta
    )
  )
}
