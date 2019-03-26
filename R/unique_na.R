#' Unique and omit \code{NA}
#'
#' Returns the unique list of input, removing \code{NA} values, first
#'
#' @param x input vector
#' @param to_unlist boolean of whether to flatten the input with
#'   \code{unlist()}; default is \code{FALSE}
#'
#' @examples
#' unique_na(c(1, 2, 3, 3, 4, NA))
#'
#' @export unique_na
unique_na <- function(x, to_unlist = FALSE) {
    if (to_unlist) {
        return(unique(stats::na.omit(unlist(x))))
    } else {
        return(unique(stats::na.omit(x)))
    }
}
