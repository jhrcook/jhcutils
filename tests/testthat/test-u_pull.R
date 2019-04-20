context("test-u_pull")

test_that("pull unique values from a data table", {
    library(datasets)
    library(magrittr)
    n_gears <- unique(mtcars$gear)
    new_n_gears <- mtcars %>%
        u_pull(gear)
    expect_true(all(n_gears %in% new_n_gears))

    n_gears <- sort(n_gears)
    new_n_gears <- mtcars %>%
        u_pull(gear, sorted = TRUE)
    expect_equal(n_gears, new_n_gears)

    ozone <- unique(airquality$Ozone)
    ozone <- ozone[!is.na(ozone)]
    new_ozone <- airquality %>%
        u_pull(Ozone, na.rm = TRUE)
    expect_equal(ozone, new_ozone)


    ozone <- unique(airquality$Ozone)
    ozone <- sort(ozone[!is.na(ozone)])
    new_ozone <- airquality %>%
        u_pull(Ozone, sorted = TRUE, na.rm = TRUE)
    expect_equal(ozone, new_ozone)
})
