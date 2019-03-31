#' Recursively join a list of tidygraphs
#'
#' Joins the graphs into a single graph. This recursively implementes
#' \code{tidygraph::graph_join()}
#'
#' @param grs a list of tidygraph objects
#' @param by what to group by (passed to \code{tidygraph::graph_join()})
#'
#' @return a single tidygraph object
#'
#' @examples
#' gr_list <- purrr::map(c(10, 20, 30), quick_forestfire)
#' gr <- recursive_graph_join(gr_list)
#' gr
#'
#' plot(gr)
#'
recursive_graph_join <- function(grs, by = "name") {
    if (length(grs) == 1) {
        # base case
        return(grs[[1]])
    } else {
        # recurse
        GR <- tidygraph::graph_join(grs[[1]],
                                    recursive_graph_join(grs[-1], by = by),
                                    by = by)
    }
    return(GR)
}
