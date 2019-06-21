test_that("vsample behaves correctly", {
    expect_equal(vsample(10), 10)
    expect_error(vsample(10, 3), "cannot take a sample larger than the population")
    expect_equal(vsample(10, 3, replace = TRUE), c(10, 10, 10))
    expect_null(vsample(c(), 0))
    expect_null(vsample(c()))
    expect_true(length(vsample(1:10, 5)) == 5)
})
