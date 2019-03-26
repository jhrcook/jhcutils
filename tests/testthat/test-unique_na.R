context("test-unique_na")

test_that("multiplication works", {
    expect_equal(unique_na(letters[1:5]), letters[1:5])
    expect_equal(unique_na(c(letters[1:5], NA)), letters[1:5])
    expect_equal(unique_na(list(c(1:3))), list(c(1:3)))
    expect_equal(unique_na(list(c(1:3)), to_unlist = TRUE), c(1:3))
    expect_equal(unique_na(list(c(1:3, NA))), list(c(1:3, NA)))
    expect_equal(unique_na(list(c(1:3, NA)), to_unlist = TRUE), c(1:3))
})
