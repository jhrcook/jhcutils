context("test-filter_component_size")

test_that("filter out components by number of nodes", {
    library(tidygraph)
    library(igraph)
    gr_10 <- play_barabasi_albert(10, 0.5)
    gr_15 <- play_barabasi_albert(15, 0.5)
    gr_bind <- bind_graphs(gr_10, gr_15)

    expect_equal(vcount(filter_component_size(gr_10)), 10)
    expect_equal(count_components(filter_component_size(gr_10)), 1)
    expect_equal(vcount(filter_component_size(gr_10, 20)), 0)
    expect_equal(count_components(filter_component_size(gr_10, 20)), 0)

    expect_equal(vcount(filter_component_size(gr_bind)), 25)
    expect_equal(count_components(filter_component_size(gr_bind)), 2)

    expect_equal(vcount(filter_component_size(gr_bind, 11)), 15)
    expect_equal(count_components(filter_component_size(gr_bind, 11)), 1)

    expect_equal(vcount(filter_component_size(gr_bind, max_size = 11)), 10)
    expect_equal(count_components(filter_component_size(gr_bind, max_size = 11)), 1)

    empty_gr <- tidygraph::create_empty(0)
    expect_identical(filter_component_size(empty_gr), empty_gr)
    expect_equal(igraph::vcount(filter_component_size(empty_gr)), 0)
})
