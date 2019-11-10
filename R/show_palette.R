#' Show a color palette in a matrix
#'
#' This function is very simillar to the \code{show_cols()} in 'scales'. The
#' main difference is that this function returns a true \code{ggplot2} object.
#' This allows for further customization.
#'
#' @param cols The colors to present in a matrix. If the values are named, these
#' will be used for the cell label. If not, then the color value itself is used
#' for the label.
#' @param num_rows The number of rows to use or if the matrix should be as
#' square as possible.
#' @param label_size The size passed to \code{ggplot2::geom_text()} for the size
#' of the label. Default is 5.
#' @param base_size The base font size passed to \code{theme_bw()}. The default
#' is to use \code{label_size}.
#' @param font_family The font to use for thee plot. Default is "Times".
#' @param ... Any other information to pass to \code{ggplot2::theme()}.
#'
#' @return A \code{ggplot2} object.
#'
#' @examples
#' pal <- c("#3fc5f0", "#42dee1", "#6decb9", "#eef5b2")
#' show_palette(pal)
#'
#' show_palette(pal, num_rows = 1)
#'
#' names(pal) <- paste("color", 1:4)
#' show_palette(pal)
#'
#' @importFrom magrittr %>%
#' @importFrom ggplot2 aes
#'
#' @export show_palette
show_palette <- function(cols,
                         num_rows = "square",
                         label_size = 5,
                         font_family = "Times",
                         base_size = label_size,
                         ...) {

    if (is.null(names(cols))) {
        col_names <- cols
    } else {
        col_names <- names(cols)
    }

    if (num_rows == "square") {
        num_rows <- ceiling(sqrt(length(cols)))
    } else if (!is.numeric(num_rows)) {
        stop("The `num_rows` argument must be either 'smart' or a numeric value.")
    }
    num_cols <- ceiling(length(cols) / num_rows)

    col_assignments <- c()
    for (j in seq(num_rows, 1)) {
        col_assignments <- c(col_assignments, rep(j, num_cols))
    }
    row_assignments <- rep(seq(1, num_cols), num_rows)

    tibble::tibble(col_names = col_names,
           color_vals = cols,
           x = row_assignments[1:length(cols)],
           y = col_assignments[1:length(cols)]) %>%
        ggplot2::ggplot(aes(x = x, y = y)) +
        ggplot2::geom_tile(aes(fill = color_vals),
                           color = NA) +
        ggplot2::geom_text(aes(label = col_names),
                           size = label_size,
                           family = font_family) +
        ggplot2::scale_fill_identity() +
        ggplot2::scale_x_discrete(expand = c(0, 0)) +
        ggplot2::scale_y_discrete(expand = c(0, 0)) +
        ggplot2::theme_bw(
            base_family = font_family,
            base_size = base_size
        ) +
        ggplot2::theme(
            axis.text = ggplot2::element_blank(),
            axis.title = ggplot2::element_blank(),
            axis.ticks = ggplot2::element_blank(),
            ...
        )
}

# for "show_palette"
utils::globalVariables(c("x", "y", "color_vals"), add = TRUE)
