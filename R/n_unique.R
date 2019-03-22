#' Number of unique values
#'
#' Returns the number of unique values in the input vector
#'
#' @param x input vector
#' @param to_unlist boolean of whether to flatten the input with
#'   \code{unlist()}; default is \code{FALSE}
#'
#' @examples
#' n_unique(c(1, 2, 3, 3, 4))
#' n_unique(c("A", "B", "C", "D", "A"))
#' n_unique(list(letters[1:5], letters[1:4]))
#' n_unique(list(letters[1:5], letters[1:4]), to_unlist = TRUE)
#'
#' @export n_unique
n_unique <- function(x, to_unlist = FALSE) {
    if (to_unlist) {
        return(length(unique(unlist(x))))
    } else {
        return(length(unique(x)))
    }
}
