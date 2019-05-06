test_that("retrieve the node index of a graph", {
    gr <- quick_barabasi(10)
    expect_equal(get_node_index(quick_barabasi(10), name == "B"), 2)
    expect_null(get_node_index(quick_barabasi(10), name == "W"))
    expect_equal(get_node_index(quick_barabasi(10), name %in% c("B", "C", "D")), c(2, 3, 4))
    expect_equal(get_node_index(quick_barabasi(10), stringr::str_detect(name, "A|B|C")), c(1, 2, 3))
})
