
<!-- README.md is generated from README.Rmd. Please edit that file -->

# jhcutils <img src="man/figures/logo.png" align="right" alt="" width="120" />

[![License: GPL
v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Travis build
status](https://travis-ci.org/jhrcook/jhcutils.svg?branch=master)](https://travis-ci.org/jhrcook/jhcutils)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/jhrcook/jhcutils?branch=master&svg=true)](https://ci.appveyor.com/project/jhrcook/jhcutils)
[![Coverage
status](https://codecov.io/gh/jhrcook/jhcutils/branch/master/graph/badge.svg)](https://codecov.io/github/jhrcook/jhcutils?branch=master)

These are a bunch of functions that I find myself declaring and
rewriting in a many scripts and analyses.

## Installation

You can install ‘jhcutils’ with:

``` r
devtools::install_github("jhrcook/jhcutils")
```

Full documentation at the [‘pkgdown
site’](https://jhrcook.github.io/jhcutils/index.html).

-----

## General Utilities

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
unique_na(b, to_unlist = TRUE)
#> [1] 1 2 3 5
```

**minmax** - set limits on a vector of numeric values.

``` r
c <- sample(-100:100, 20)
c
#>  [1]  80 -47 -26  13  78 -61  75  83  27  20 -89  95 -67  29 -29  43  -8
#> [18]  32  81 -31
minmax(c, -10, 10)
#>  [1]  10 -10 -10  10  10 -10  10  10  10  10 -10  10 -10  10 -10  10  -8
#> [18]  10  10 -10
```

**u\_pull** - works just like `dplyr::pull()` expect only returns unique
values.

``` r
str(mtcars$gear)
#>  num [1:32] 4 4 4 3 3 3 3 4 4 4 ...
mtcars %>% u_pull(gear)
#> [1] 4 3 5
```

## Tidygraph

**quick\_forestfire** - wrapper around `tidygraph::play_forestfire`
except that it will return a tidygraph object with the node attribute
`"name"`.

``` r
set.seed(0)
forest_gr <- quick_forestfire(10)
forest_gr
#> # A tbl_graph: 10 nodes and 23 edges
#> #
#> # An undirected simple graph with 1 component
#> #
#> # Node Data: 10 x 1 (active)
#>   name 
#>   <chr>
#> 1 A    
#> 2 B    
#> 3 C    
#> 4 D    
#> 5 E    
#> 6 F    
#> # … with 4 more rows
#> #
#> # Edge Data: 23 x 2
#>    from    to
#>   <int> <int>
#> 1     1     2
#> 2     1     3
#> 3     2     3
#> # … with 20 more rows
my_plot_fxn(forest_gr) +
    labs(title = "Example of a quick Forest Fire graph model")
```

<img src="man/figures/README-forestfire-1.png" width="100%" />

**quick\_barabasi** - wrapper around `tidygraph::play_barabasi_albert`
except that it will return a tidygraph object with the node attribute
`"name"`.

``` r
set.seed(0)
barabasi_gr <- quick_barabasi(10)
barabasi_gr
#> # A tbl_graph: 10 nodes and 9 edges
#> #
#> # An undirected simple graph with 1 component
#> #
#> # Node Data: 10 x 1 (active)
#>   name 
#>   <chr>
#> 1 A    
#> 2 B    
#> 3 C    
#> 4 D    
#> 5 E    
#> 6 F    
#> # … with 4 more rows
#> #
#> # Edge Data: 9 x 2
#>    from    to
#>   <int> <int>
#> 1     1     2
#> 2     2     3
#> 3     1     4
#> # … with 6 more rows
my_plot_fxn(barabasi_gr) +
    labs(title = "Example of a quick Barabasi-Albert graph")
```

<img src="man/figures/README-barbasi-1.png" width="100%" />

**quick\_graph** - randomly selects one of the above random graphs.

``` r
set.seed(0)
quick_gr <- quick_graph(10)
#> using barabasi_albert
```

**recursive\_graph\_join** - recursively join a list of tidygraph
objects.

``` r
gr_list <- purrr::map(c(5, 10, 15), quick_forestfire)
gr <- recursive_graph_join(gr_list)
gr
#> # A tbl_graph: 15 nodes and 65 edges
#> #
#> # A directed acyclic multigraph with 1 component
#> #
#> # Node Data: 15 x 1 (active)
#>   name 
#>   <chr>
#> 1 A    
#> 2 B    
#> 3 C    
#> 4 D    
#> 5 E    
#> 6 F    
#> # … with 9 more rows
#> #
#> # Edge Data: 65 x 2
#>    from    to
#>   <int> <int>
#> 1     1     2
#> 2     2     3
#> 3     1     4
#> # … with 62 more rows
my_plot_fxn(gr) +
    labs(title = "Example of joining 3 forest fire graphs")
```

<img src="man/figures/README-recursivegraphjoin-1.png" width="100%" />

**filter\_component\_size** - filter the components of a tidygraph
object by their individual number of nodes (order).

``` r
gr <- tidygraph::bind_graphs(quick_forestfire(4, name = LETTERS),
                             quick_forestfire(6, name = letters))
igraph::count_components(gr)
#> [1] 2
igraph::count_components(filter_component_size(gr, min_size = 5))
#> [1] 1
igraph::count_components(filter_component_size(gr, max_size = 5))
#> [1] 1
```

## Pacakge Utilities

**document\_df** - prints the framework for documenting a data frame
object.

``` r
dat <- tibble::tibble(x = c(LETTERS[1:5]),
                      y = c(1:5),
                      z = list(rep(list(1:3), 5)))
dat
#> # A tibble: 5 x 3
#>   x         y z         
#>   <chr> <int> <list>    
#> 1 A         1 <list [5]>
#> 2 B         2 <list [5]>
#> 3 C         3 <list [5]>
#> 4 D         4 <list [5]>
#> 5 E         5 <list [5]>
document_df(dat)
#> #' @format a tibble (5 x 3)
#> #' \describe{
#> #'     \item{x}{}
#> #'     \item{y}{}
#> #'     \item{z}{}
#> #' }
```

-----

### Additions

If you have any recommended additions, please open an
[issue](https://github.com/jhrcook/jhcutils/issues).
