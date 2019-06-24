test_that("accurately handle having no neighbors", {
    library(igraph)
    library(tidygraph)

    empty_gr <- tidygraph::create_empty(10)
    empty_test <- empty_gr %>%
        mutate(A = map_local_int(
            .f = num_qual_neighbors,
            lgl_filter = rlang::expr(1 == 1)
        )) %>%
        mutate(B = map_local_int(
            .f = num_qual_neighbors,
            lgl_filter = rlang::expr(1 == 2)
        )) %>%
        mutate(C = map_local_int(
            .f = num_qual_neighbors,
            lgl_filter = rlang::expr(dplyr::n() > 1)
        )) %>%
        mutate(A2 = map_local_int(
            order = 2,
            .f = num_qual_neighbors,
            lgl_filter = rlang::expr(1 == 1)
        )) %>%
        mutate(B2 = map_local_int(
            order = 2,
            .f = num_qual_neighbors,
            lgl_filter = rlang::expr(1 == 2)
        )) %>%
        mutate(C2 = map_local_int(
            order = 2,
            .f = num_qual_neighbors,
            lgl_filter = rlang::expr(dplyr::n() > 1)
        ))
    expect_true(all(V(empty_test)$A == 1))
    expect_true(all(V(empty_test)$B == 0))
    expect_true(all(V(empty_test)$C == 0))
    expect_true(all(V(empty_test)$A2 == 1))
    expect_true(all(V(empty_test)$B2 == 0))
    expect_true(all(V(empty_test)$C2 == 0))
})


test_that("accurately count neighbors (simple expressions)", {
    library(igraph)
    library(tidygraph)

    gr <- create_ring(26) %N>%
        mutate(name = LETTERS) %>%
        mutate(A = map_local_int(
            .f = num_qual_neighbors,
            lgl_filter = rlang::expr(name %in% !!LETTERS)
        )) %>%
        mutate(B = map_local_int(
            .f = num_qual_neighbors,
            lgl_filter = rlang::expr(name %in% !!letters)
        )) %>%
        mutate(C = map_local_int(
            .f = num_qual_neighbors,
            lgl_filter = rlang::expr(is.numeric(name))
        )) %>%
        mutate(A2 = map_local_int(
            order = 2,
            .f = num_qual_neighbors,
            lgl_filter = rlang::expr(name %in% !!LETTERS)
        )) %>%
        mutate(B2 = map_local_int(
            order = 2,
            .f = num_qual_neighbors,
            lgl_filter = rlang::expr(name %in% !!letters)
        )) %>%
        mutate(C2 = map_local_int(
            order = 2,
            .f = num_qual_neighbors,
            lgl_filter = rlang::expr(is.numeric(name))
        ))

    expect_true(all(V(gr)$A == 3))
    expect_true(all(V(gr)$B == 0))
    expect_true(all(V(gr)$C == 0))
    expect_true(all(V(gr)$A2 == 5))
    expect_true(all(V(gr)$B2 == 0))
    expect_true(all(V(gr)$C2 == 0))
})



test_that("accurately count neighbors (complex expressions)", {
    library(igraph)
    library(tidygraph)
    library(stringr)

    gr <- create_ring(26) %N>%
        mutate(name = LETTERS) %>%
        mutate(A = map_local_int(
            .f = num_qual_neighbors,
            lgl_filter = rlang::expr(str_detect(name, "[F-T]")),
            ignore_nodes = c("A")
        )) %>%
        mutate(B = map_local_int(
            .f = num_qual_neighbors,
            lgl_filter = rlang::expr(str_detect(str_to_lower(name), "[ago|pwe]")),
            ignore_nodes = c("A")
        )) %>%
        mutate(C = map_local_int(
            .f = num_qual_neighbors,
            lgl_filter = rlang::expr(str_count(unlist(name), "[A-M]") > 1),
            ignore_nodes = c("A")
        )) %>%
        mutate(A2 = map_local_int(
            order = 2,
            .f = num_qual_neighbors,
            lgl_filter = rlang::expr(str_detect(name, "[F-T]"))
        )) %>%
        mutate(B2 = map_local_int(
            order = 2,
            .f = num_qual_neighbors,
            lgl_filter = rlang::expr(str_detect(str_to_lower(name), "[ago|pwe]"))
        )) %>%
        mutate(C2 = map_local_int(
            order = 2,
            .f = num_qual_neighbors,
            lgl_filter = rlang::expr(str_count(unlist(name), "[A-M]") > 1)
        ))

    expect_true(all(is.numeric(V(gr)$A)))
    expect_true(all(is.numeric(V(gr)$B)))
    expect_true(all(is.numeric(V(gr)$C)))
    expect_true(all(is.numeric(V(gr)$A2)))
    expect_true(all(is.numeric(V(gr)$B2)))
    expect_true(all(is.numeric(V(gr)$C2)))
})

