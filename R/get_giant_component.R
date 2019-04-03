#' Returns the giant component of a graph
#'
#' @description The "giant component" of a graph is defined as the component of
#'   the largest order (i.e. most number of nodes)
#'
#' @param gr tidygraph object
#'
#' @return the giant component of the input tidygraph object
#'
#' @examples
#' gr_large <- quick_forestfire(10, name = LETTERS)
#' gr_small <- quick_forestfire(5, name = letters)
#' gr <- tidygraph::bind_graphs(gr_large, gr_small)
#' gr
#' get_giant_component(gr)
#'
#' @export get_giant_component
get_giant_component <- function(gr) {
    new_gr <- gr %>%
        tidygraph::morph(tidygraph::to_components, type = "weak") %N>%
        tidygraph::mutate(.comp_order = tidygraph::graph_order()) %>%
        tidygraph::unmorph() %>%
        tidygraph::filter(.comp_order == max(.comp_order)) %>%
        tidygraph::select(-.comp_order)
    return(new_gr)
}


# for "get_giant_component"
utils::globalVariables(c(".comp_order"), add = TRUE)
