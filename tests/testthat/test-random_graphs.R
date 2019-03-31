context("test-random_graphs")

test_that("random graphs are made", {
    expect_equal(n_perm(0, 1), 0)
    expect_equal(n_perm(1, 1), 1)
    expect_equal(n_perm(3, 2), 6)

    expect_equal(length(prep_node_names(5)), 5)
    expect_equal(length(prep_node_names(100)),100)
    expect_equal(prep_node_names(26), LETTERS)
    expect_equal(prep_node_names(26, letters), letters)

    expect_true(tidygraph::is.tbl_graph(quick_forestfire(10)))
    expect_true(tidygraph::is.tbl_graph(quick_barabasi(10)))
    expect_true(tidygraph::is.tbl_graph(quick_graph(10)))

    n <- 10
    expect_equal(igraph::vcount(quick_forestfire(n)), n)
    expect_equal(igraph::vcount(quick_barabasi(n)), n)
    expect_equal(igraph::vcount(quick_barabasi(n)), n)

    n <- 100
    expect_equal(igraph::vcount(quick_forestfire(n)), n)
    expect_equal(igraph::vcount(quick_barabasi(n)), n)
    expect_equal(igraph::vcount(quick_barabasi(n)), n)

    expect_equal(n_unique(igraph::V(quick_forestfire(n))$name), n)
    expect_equal(n_unique(igraph::V(quick_barabasi(n))$name), n)
    expect_equal(n_unique(igraph::V(quick_graph(n))$name), n)
})
