#' Test if neighborhood passes a logical filter
#'
#' Using the 'tidygraph' functions \code{map_local_*()}, it is easy to scan the
#' neighborhood of all the nodes in a graph. This function takes a logical
#' filter expression to apply on the node attributes of a graph, and returns the
#' number of neighbors that qualify.
#'
#' @param neighborhood passed by the \code{tidygraph::map_local_lgl()} function.
#' @param lgl_filter an expression to apply to the node attributes of
#'   \code{neighborhood}; must be encapsulated in \code{expr( ... )}
#' @param ignore_nodes nodes to exclude from the filter (use the \code{"name"}
#'   attribute of the nodes)
#' @param ... just takes any other arguments passed automatically by
#'   \code{tidygraph::map_local_lgl()}
#'
#' @return an integer of the number of nodes that qualify for each neighborhood
#'
#' @examples
#' suppressPackageStartupMessages(library(tidygraph))
#' set.seed(0)
#' gr <- quick_barabasi(30)
#' gr
#'
#' plot(gr)
#'
#' # number of neighbors with a "B" in their name
#' B_gr <- gr %>%
#'     mutate(name_with_B = map_local_int(
#'         .f = num_qual_neighbors,
#'         lgl_filter = rlang::expr(stringr::str_detect(name, "B"))
#'     ))
#' B_gr %N>%
#'     filter(name_with_B > 0) %>%
#'     plot()
#'
#' @importFrom tidygraph %>% %N>%
#' @importFrom magrittr %>%
#' @export num_qual_neighbors
num_qual_neighbors <- function(neighborhood,
                               lgl_filter,
                               ignore_nodes = c(),
                               ...) {
    # remove nodes if any to ignore
    if (length(ignore_nodes) > 0) {
        neighborhood <- neighborhood %N>%
            tidygraph::filter(!(name %in% ignore_nodes))
    }

    # get the number of neighbors that qualify
    n_bridged <- neighborhood %N>%
        tidygraph::as_tibble(neighborhood, active = "nodes") %>%
        dplyr::mutate(.lgl_results = rlang::eval_tidy(lgl_filter)) %>%
        dplyr::pull(.lgl_results) %>%
        sum()
    return(n_bridged)
}

# for "num_qual_neighbors"
utils::globalVariables(c("name", ".lgl_results"), add = TRUE)
