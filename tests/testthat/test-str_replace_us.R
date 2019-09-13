test_that("properly replace underscores with spaces", {
    library(stringr)

    expect_true(str_detect("_", "_"))
    expect_false(str_detect(str_replace_us(""), "_"))
    expect_false(str_detect(str_replace_us(" "), "_"))
    expect_equal(str_replace_us("_"), " ")
    expect_false(str_detect(str_replace_us("_"), "_"))

    txt_no_us <- "here is some text"
    txt_with_us <- "here_is an underscore_"

    expect_false(str_detect(str_replace_us(txt_no_us), "_"))
    expect_false(str_detect(str_replace_us(txt_with_us), "_"))
    expect_equal(str_replace_us(txt_no_us), txt_no_us)
    expect_equal(str_replace_us(txt_with_us), "here is an underscore ")

    txt_array <- c("_", " ", "some text", "some_text")
    expect_false(all(str_detect(str_replace_us(txt_array), "_")))
    expect_true(all(str_detect(str_replace_us(txt_array), " ")))
})
#

test_that("properly replace spaces with underscores", {
    library(stringr)

    expect_equal(str_replace_sp(""), "")
    expect_equal(str_replace_sp(" "), "_")
    expect_equal(str_replace_sp("_"), "_")

    txt_with_sp <- "Here is some text "

    expect_true(str_detect(txt_with_sp, " "))
    expect_false(str_detect(txt_with_sp, "_"))

    expect_false(str_detect(str_replace_sp(txt_with_sp), " "))
    expect_true(str_detect(str_replace_sp(txt_with_sp), "_"))

    txt_array <- c("_", " ", "some text", "some_text")
    expect_false(all(str_detect(str_replace_sp(txt_array), " ")))
    expect_true(all(str_detect(str_replace_sp(txt_array), "_")))
})
