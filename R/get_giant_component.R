#' Returns the giant component of a graph
#'
#' @description The "giant component" of a graph is defined as the component of
#'   the largest order (i.e. most number of nodes)
#'
#' @param gr tidygraph object
#'
#' @return the giant component of the input tidygraph object or all components
#'   except for the giant component
#'
#' @examples
#' gr_large <- quick_forestfire(10, name = LETTERS)
#' gr_small <- quick_forestfire(5, name = letters)
#' gr <- tidygraph::bind_graphs(gr_large, gr_small)
#' gr
#' get_giant_component(gr)
#' rm_giant_component(gr)
#'
#' @export get_giant_component
get_giant_component <- function(gr) {
    if (igraph::count_components(gr) < 2) {
        return(gr)
    }
    new_gr <- gr %>%
        tidygraph::morph(tidygraph::to_components, type = "weak") %N>%
        tidygraph::mutate(.comp_order = tidygraph::graph_order()) %>%
        tidygraph::unmorph()  %>%
        tidygraph::filter(.comp_order == max(.comp_order)) %>%
        tidygraph::select(-.comp_order)
    return(new_gr)
}


#' @rdname get_giant_component
#' @export rm_giant_component
rm_giant_component <- function(gr) {
    if (igraph::count_components(gr) < 2) {
        warning("only one component in 'gr' - returning empty graph")
        new_gr <- gr %>%
            dplyr::filter(FALSE)
        return(new_gr)
    }
    new_gr <- gr %>%
        tidygraph::morph(tidygraph::to_components, type = "weak") %N>%
        tidygraph::mutate(.comp_order = tidygraph::graph_order()) %>%
        tidygraph::unmorph()  %>%
        tidygraph::filter(.comp_order != max(.comp_order)) %>%
        tidygraph::select(-.comp_order)
    return(new_gr)
}



# for "get_giant_component"
utils::globalVariables(c(".comp_order"), add = TRUE)
