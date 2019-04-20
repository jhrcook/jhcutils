#' Pull the unique values from a column of a tibble
#'
#' @description Acts just like 'pull()' from 'dplyr' except that it only
#'     returns the unique values.
#'
#' @param data a table of data
#' @inheritParams tidyselect::vars_pull
#' @param sorted (boolean) sort the output; default \code{FALSE}
#' @param na.rm (boolean) remove \code{NA}; default \code{FALSE}
#'
#' @examples
#' suppressPackageStartupMessages(library(dplyr))
#' tibble::tibble(a = c(1:3, 1:3),
#'                b = LETTERS[1:6]) %>%
#'     u_pull(a)
#'
#' @export u_pull
u_pull <- function(data, var = -1, sorted = FALSE, na.rm = FALSE) {
    UseMethod("u_pull")
}

#' @export
u_pull.data.frame <- function(data, var = -1, sorted = FALSE, na.rm = FALSE) {
    var <- tidyselect::vars_pull(names(data), !!rlang::enquo(var))
    val <- unique(data[[var]])
    if (na.rm) val <- val[!is.na(val)]
    if (sorted) val <- sort(val)
    return(val)
}
