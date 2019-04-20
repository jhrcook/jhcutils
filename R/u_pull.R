#' Pull the unique values from a column of a tibble
#'
#' @description Acts just like 'pull()' from 'dplyr' except that it only
#'     returns the unique values.
#'
#' @param data a table of data
#' @inheritParams tidyselect::vars_pull
#'
#' @examples
#' suppressPackageStartupMessages(library(dplyr))
#' tibble::tibble(a = c(1:3, 1:3),
#'                b = LETTERS[1:6]) %>%
#'     u_pull(a)
#'
#' @export u_pull
u_pull <- function(data, var = -1) {
    UseMethod("u_pull")
}

#' @export
u_pull.data.frame <- function(data, var = -1) {
    var <- tidyselect::vars_pull(names(data), !!rlang::enquo(var))
    unique(data[[var]])
}


#' u_pull.tbl_df <- function(data, var = -1) {
#'     var <- tidyselect::vars_pull(names(data), !!enquo(var))
#'     unique(data[[var]])
#' }
