#' Create random graphs using my preferred models
#'
#' @description These are light-weight wrappers around 'tidygraph' functions to
#' create random graphs. They return graphs with named nodes.
#'
#' @param n number of nodes
#' @param name node names; default is \code{LETTERS}
#' @param directed boolean value for directed or undirected graph
#'
#' @return a tridygraph object with named nodes
#'
#' @name random_graph
#'
#' @importFrom tidygraph %N>%
#' @importFrom rlang !!
#' @export quick_forestfire
quick_forestfire <- function(n, name = c(), directed = FALSE) {
    prepped_names <- prep_node_names(n, name)
    g <- tidygraph::play_forestfire(n,
                                   p_forward = 0.5,
                                   growth = 1.2,
                                   directed = directed) %N>%
        tidygraph::mutate(name = !!prepped_names)
    return(g)
}


#' @rdname random_graph
#' @export quick_barabasi
quick_barabasi <- function(n, name = c(), directed = FALSE) {
    prepped_names <- prep_node_names(n, name)
    g <- tidygraph::play_barabasi_albert(n = n,
                                         power = 0.5,
                                         directed = FALSE) %N>%
        tidygraph::mutate(name = !!prepped_names)
    return(g)
}


#' @rdname random_graph
#' @export quick_graph
quick_graph <- function(n, name = c(), directed = FALSE) {
    graph_list <- list(forestfire = quick_forestfire,
                       barabasi_albert = quick_barabasi)
    i <- sample(length(graph_list), 1)
    message(paste("using", names(graph_list)[[i]]))
    return(graph_list[[i]](n = n, name = name, directed = directed))
}


#' Prepare the needed number of names
#'
#' @description Ensures there are \code{n} number of names in \code{name}. If
#'   not, permutations of the values in \code{name} are catentated together to
#'   reeach the requestion amount. This function can also be used to make
#'   \code{n} number of unique names by passing \code{NA} to \code{name}, in
#'   which case the default is to use \code{LETTERS}.
#'
#' @param n number of names desired
#' @param name a vector of names; default is \code{LETTERS}
#'
#' @return a vector of \code{n} unique names
#'
#' @examples
#' prep_node_names(5)
#' head(prep_node_names(50))
#'
#' @importFrom magrittr %>%
#' @export prep_node_names
prep_node_names <- function(n, name = c()) {
    if (length(name) == 0) name <- LETTERS
    x <- 0
    n_combs <- 0
    while (n_combs < n) {
        x <- x + 1
        n_combs <- n_perm(length(name), x)
    }
    name_list <- gtools::permutations(length(name), x, name) %>%
        apply(1, paste0, collapse = "") %>%
        unlist()
    return(name_list[1:n])
}



#' Calculate the number of permutations
#'
#' @description Calcualte the number of possible permutations for a vector of
#'   length \code{n} taking \code{k} at a time
#'
#' @param n length of vector
#' @param k number of values to take at a time
#'
#' @return a numeric value or vector if input values are a vector of vectors
#'
#' @examples
#' n_perm(10, 2)
#' n_perm(3, 4)
#'
#' @export n_perm
n_perm <- function(n, k) {
    choose(n, k) * factorial(k)
}
