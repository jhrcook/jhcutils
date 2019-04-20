#' Easily tidy the column names of a tibble
#'
#' @description Cleans up bad data table names by removing dots ".", spaces, and
#'   hyphens, replacing all with an underscore "_"
#'
#' @param data data.frame or tibble
#'
#' @examples
#' tib <- tibble::tibble("colname.1" = c(1:5),
#'                       "colname 2" = LETTERS[1:5],
#'                       "colname-3" = letters[26:22])
#' tidy_colnames(tib)
#'
#'
#' @importFrom magrittr %<>% %>%
#' @importFrom stringr str_replace_all
#' @export tidy_colnames
tidy_colnames <- function(data) {
    colnames(data) %<>%
        stringr::str_replace_all("\\.|[:space:]|-", "_")
    return(data)
}
