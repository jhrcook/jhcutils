#' Filter a tidygraph by component size
#'
#' @description Filter a tidygraph object by component size.
#'
#' @param .data a tidygraph object (for use in a pipeline)
#' @param min_size,max_size minumum and maximum sizes of components to keep
#'   (inclussive bounds)
#'
#' @return An object of the same class as \code{.data}.
#'
#' @examples
#' gr <- tidygraph::bind_graphs(tidygraph::play_barabasi_albert(3, 2),
#'                              tidygraph::play_barabasi_albert(6, 2))
#' igraph::count_components(gr)
#' new_gr <- filter_component_size(gr, min_size = 4)
#' igraph::count_components(new_gr)
#'
#' @importFrom tidygraph %N>% %>%
#' @export filter_component_size
filter_component_size <- function(.data, min_size = 0, max_size = Inf) {
    if (igraph::vcount(.data) == 0) return(.data)
    new_gr <- .data %>%
        tidygraph::morph(tidygraph::to_components, type = "weak") %N>%
        tidygraph::mutate(.comp_order = tidygraph::graph_order()) %>%
        tidygraph::unmorph() %>%
        tidygraph::filter(dplyr::between(.comp_order, !!min_size, !!max_size)) %>%
        tidygraph::select(-.comp_order)
    return(new_gr)
}

# for "filter_component_size"
utils::globalVariables(c(".comp_order"), add = TRUE)
