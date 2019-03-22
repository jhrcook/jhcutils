context("test-n_unique")

test_that("return the correct number of unique values", {
    expect_equal(n_unique(letters[1:5]), 5)
    expect_equal(n_unique(list(c(1:3))), 1)
    expect_equal(n_unique(list(c(1:3)), to_unlist = TRUE), 3)
})
