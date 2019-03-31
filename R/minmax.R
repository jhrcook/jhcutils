#' Bound values to a lower and upper limit
#'
#' @description Bound the values of \code{x} to lie within the upper and lower
#'   bounds.
#' @param x vector of values to limit
#' @param lower,upper lower and upper limits
#'
#' @return vector of the same length as \code{x}
#'
#' @examples
#' set.seed(0)
#' c <- sample(-100:100, 20)
#' c
#' minmax(c, -10, 10)
#'
#' @export minmax
minmax <- function(x, lower, upper) {
    y <- purrr::map_dbl(x, minmax_,
                    lower = lower, upper = upper)
    return(y)
}

minmax_ <- function(x, lower, upper) {
    if (is.na(x)) {
        return(x)
    } else {
        return(min(max(x, lower), upper))
    }
}
