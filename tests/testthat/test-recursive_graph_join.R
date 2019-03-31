context("test-recursive_graph_join")

test_that("multiplication works", {
    gr_list <- purrr::map(c(10, 20, 30), quick_forestfire)
    expect_true(tidygraph::is.tbl_graph(recursive_graph_join(gr_list)))
})
