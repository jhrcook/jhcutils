context("test-tidy_colnames")

test_that("the column names are cleaned", {
    expect_equal(tidy_colnames(tibble::tibble()), tibble::tibble())

    tib <- tibble::tibble("colname.1" = c(1:5),
                          "colname 2" = LETTERS[1:5],
                          "colname-3" = letters[26:22])
    new_tib <- tidy_colnames(tib)

    expect_false(all(colnames(tib) == colnames(new_tib)))

    expect_true(any(stringr::str_detect(colnames(tib), "\\.")))
    expect_true(any(stringr::str_detect(colnames(tib), "[:space:]")))
    expect_true(any(stringr::str_detect(colnames(tib), "-")))

    expect_false(any(stringr::str_detect(colnames(new_tib), "\\.")))
    expect_false(any(stringr::str_detect(colnames(new_tib), "[:space:]")))
    expect_false(any(stringr::str_detect(colnames(new_tib), "-")))
})
