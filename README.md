
<!-- README.md is generated from README.Rmd. Please edit that file -->

# jhcutils <a href="https://jhrcook.github.io/jhcutils/index.html"> <img src="man/figures/logo.png" align="right" alt="" width="120" /> </a>

[![License: GPL
v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Travis build
status](https://travis-ci.org/jhrcook/jhcutils.svg?branch=master)](https://travis-ci.org/jhrcook/jhcutils)
[![Coverage
status](https://codecov.io/gh/jhrcook/jhcutils/branch/master/graph/badge.svg)](https://codecov.io/github/jhrcook/jhcutils?branch=master)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/jhrcook/jhcutils?branch=master&svg=true)](https://ci.appveyor.com/project/jhrcook/jhcutils)

These are a bunch of functions that I find myself declaring and
rewriting in a many scripts and analyses.

## Installation

You can install ‘jhcutils’ with:

``` r
devtools::install_github("jhrcook/jhcutils")
```

Full documentation: [‘pkgdown
site’](https://jhrcook.github.io/jhcutils/index.html)

-----

## General Use

**n\_unique** - return the number of unique values in a vector.

``` r
a <- c(1, 2, 2, 3, 4, 5)
n_unique(a)
#> [1] 5
b <- list(c(1, 2, 3, 4), c(1, 2, 3, 4, 5))
n_unique(b)
#> [1] 2
n_unique(b, to_unlist = TRUE)
#> [1] 5
```

**unique\_na** - return the unique values in a vector, omitting `NA`.

``` r
a <- c(1, 2, 3, NA, 3)
unique_na(a)
#> [1] 1 2 3
b <- list(c(1, 2, 3, NA), c(1, 2, NA, 5))
unique_na(b)
#> [[1]]
#> [1]  1  2  3 NA
#> 
#> [[2]]
#> [1]  1  2 NA  5
```

## Tidygraph

**recursive\_graph\_join** - recursively join a list of tidygraph
objects

``` r
# TODO
```
