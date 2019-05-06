#' Get the node indices from a tidygraph
#'
#' @description Some functions in the 'tidygraph' package require the index of a
#'   node. This function evalutes an input expression in the
#'   \code{dplyr::filter()} function in the node tibble of a tidygraph object
#'   and returns the indices of the nodes that pass.
#'
#' @param gr a tidygraph
#' @param expr an expression to be quoted and evaluated in the context of the
#'   node tibble of the tidygraph object
#'
#' @examples
#' get_node_index(quick_barabasi(10), name == "B")
#' get_node_index(quick_barabasi(10), name %in% c("B", "C", "D"))
#' get_node_index(quick_barabasi(10), stringr::str_detect(name, "A|B|C"))
#'
#' @export get_node_index
get_node_index <- function(gr, expr) {
    idx <- tibble::as_tibble(gr, active = "nodes") %>%
        dplyr::mutate(.node_idx = 1:dplyr::n()) %>%
        dplyr::filter(!!rlang::enquo(expr)) %>%
        u_pull(.node_idx)
    if (length(idx) == 0) {
        return(NULL)
    } else {
        return(idx)
    }
}

# for "get_node_index"
utils::globalVariables(c(".node_idx"), add = TRUE)
