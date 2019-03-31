context("test-minmax")

test_that("multiplication works", {
    expect_equal(minmax(c(-5:5), -2, 2),
                 c(-2, -2, -2, -2, -1, 0, 1, 2, 2, 2, 2))
    expect_equal(minmax(c(-5:5), 0, 0), rep(0, 11))
    expect_equal(minmax(c(-10, 0, NA), -1, 2), c(-1, 0, NA))
})
