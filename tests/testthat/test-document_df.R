context("test-document_df")

test_that("documentation of data frames if formatted correctly", {
    expect_equal(get_df_type(tibble::tibble()), "tibble")
    expect_equal(get_df_type(data.table::data.table()), "data.table")
    expect_equal(get_df_type(data.frame()), "data.frame")

    dat <- tibble::tibble(x = c(LETTERS[1:5]),
                          y = c(1:5),
                          z = list(rep(list(1:3), 5)))

    expect_output(line_one(dat), regexp = "format")
    expect_output(line_one(dat), regexp = "tibble")
    expect_output(line_one(dat), regexp = "5 x 3")

    expect_output(item_lines(dat, 2), regexp = "describe")
    expect_output(item_lines(dat, 2), regexp = "item")
    expect_output(item_lines(dat, 2), regexp = "x")
    expect_output(item_lines(dat, 2), regexp = "y")
    expect_output(item_lines(dat, 2), regexp = "z")

    expect_output(close_line(), regexp = "}")
})
