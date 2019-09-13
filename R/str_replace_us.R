#' Replace underscores with spaces or \emph{vice versa}
#'
#' @description Vectorised over string, to replace underscores with spaces or \emph{vice versa}.
#'
#' @details These two functions are thin wrappers around \code{str_replace_all()} from the 'stringr' package.
#' They just pass a space (\code{" "}) or an underscore (\code{"_"}) to the parameters  \code{pattern} and \code{replacement}, automatically.
#' (Yes, I do this often enough to warrant adding two new functions to my namespace!)
#'
#' @param string "Input vector. Either a character vector, or something coercible to one." (from \code{?stringr::str_replace_all})
#'
#' @return "A character vector." (from \code{?stringr::str_replace_all})
#'
#' @examples
#' txt <- "This_is_a_string"
#' str_replace_us(txt)
#'
#' txt <- "This is a string"
#' str_replace_sp(txt)
#'
#' @export str_replace_us
str_replace_us <- function(string) {
    stringr::str_replace_all(
        string = string,
        pattern = "_",
        replacement = " ")
}



#' @export str_replace_sp
#' @rdname str_replace_us
str_replace_sp <- function(string) {
    stringr::str_replace_all(
        string = string,
        pattern = " ",
        replacement = "_")
}
