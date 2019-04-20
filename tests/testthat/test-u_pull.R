context("test-u_pull")

test_that("pull unique values from a data table", {
    library(datasets)
    library(magrittr)
    n_gears <- sort(unique(mtcars$gear))
    new_n_gears <- mtcars %>%
        u_pull(gear) %>%
        sort()
    expect_equal(n_gears, new_n_gears)
})
