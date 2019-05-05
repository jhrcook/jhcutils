context("test-get_giant_component")

test_that("multiplication works", {
    gr_large1 <- quick_forestfire(10, name = LETTERS)
    gr_large2 <- quick_forestfire(10, name = c(1:10))
    gr_small <- quick_forestfire(5, name = letters)

    gr_test1 <- tidygraph::bind_graphs(gr_large1, gr_small)
    gr_test2 <- tidygraph::bind_graphs(gr_large1, gr_large2)

    # test single component
    expect_equal(vcount(get_giant_component(gr_large1)), 10)
    expect_equal(igraph::V(get_giant_component(gr_large1))$name, LETTERS[1:10])

    # test multiple components
    expect_equal(vcount(get_giant_component(gr_test1)), 10)
    expect_equal(igraph::V(get_giant_component(gr_test1))$name, LETTERS[1:10])
    expect_equal(vcount(get_giant_component(gr_test2)), 20)

    # test single component
    expect_warning(rm_giant_component(gr_large1), regexp = "only one component")
    expect_equal(vcount(suppressWarnings(rm_giant_component(gr_large1))), 0)

    # test multiple components
    expect_equal(vcount(rm_giant_component(gr_test1)), 5)
    expect_equal(igraph::V(rm_giant_component(gr_test1))$name, letters[1:5])
    expect_equal(vcount(rm_giant_component(gr_test2)), 0)
})
