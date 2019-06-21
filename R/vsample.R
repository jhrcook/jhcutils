#' Wrapper for \code{sample()} that always assumes input is a vector of options
#'
#' The function \code{base::sample()} accepts either a vector of valuesto sample
#' from, or a single numeric value that is turned into a vector from 1 to the
#' input value and this range is sampled from. This has resulted in a rather
#' frustrating (and perplexing) error for me in the past. This function,
#' \code{vsample()} always assumes the input is a vector. Therefore, if the
#' input vector is of length 1, that value is just returned (i.e. sampling 1
#' value from a vector of length 1 will always select the single element).
#'
#' @param x either a vector of one or more elements from which to choose, or a
#'   positive integer. See ‘Details.’
#' @param size a non-negative integer giving the number of items to choose.
#' @param replace should sampling be with replacement?
#' @param prob a vector of probability weights for obtaining the elements of the
#'   vector being sampled.
#'
#' @return For sample a vector of length size with elements drawn from either x
#'
#' @examples
#' sample(10)
#' vsample(10)
#'
#' vsample(10, size = 3, replace = TRUE)
#'
#' sample(c(1, 2, 3))
#' vsample(c(1, 2, 3))
#'
#' @export vsample
vsample <- function(x, size = length(x), replace = FALSE, prob = NULL) {
    if (length(x) != 1) {
        return(sample(x = x, size = size, replace = replace, prob = prob))
    } else if (length(x) == 1 & replace) {
        return(rep(x, size))
    } else if (length(x) == 1 & size == 1) {
        return(x)
    } else if (length(x) < size & !replace) {
        stop("cannot take a sample larger than the population when 'replace = FALSE'")
    }
}
