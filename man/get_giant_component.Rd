% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_giant_component.R
\name{get_giant_component}
\alias{get_giant_component}
\alias{rm_giant_component}
\title{Returns the giant component of a graph}
\usage{
get_giant_component(gr)

rm_giant_component(gr)
}
\arguments{
\item{gr}{tidygraph object}
}
\value{
the giant component of the input tidygraph object or all components
  except for the giant component
}
\description{
The "giant component" of a graph is defined as the component of
  the largest order (i.e. most number of nodes)
}
\examples{
gr_large <- quick_forestfire(10, name = LETTERS)
gr_small <- quick_forestfire(5, name = letters)
gr <- tidygraph::bind_graphs(gr_large, gr_small)
gr
get_giant_component(gr)
rm_giant_component(gr)

}
