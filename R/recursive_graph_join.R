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
#' library(tidygraph)
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
