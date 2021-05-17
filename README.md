
# shinycontestscrape

<!-- badges: start -->
<!-- badges: end -->

The goal of shinycontestscrape is to create an automated way of obtaining  all of the RStudio Shiny Contest submissions for the year 2021. Additional years may be supported in the future!


## Installation

You can install the development version from GitHub:

``` r
remotes::install_github("rpodcast/shinycontestscrape")
```

## Example

All you need to do is run the simple `get_contest_data()` function to return a tidy `tibble` with the various post metadata

``` r
library(shinycontestscrape)
df <- get_contest_data()
```

## Contribution

### Development Environment

I am using [`{renv}`](https://rstudio.github.io/renv/) to manage the dependencies for the package. After cloning the repository, you should be able to install the development package library with a call to `renv::restore()` after launching your R session.

If you are interested in using a containerized development workflow, the `.devcontainer` subdirectory contains Docker configurations to support a containerized RStudio server and Visual Studio Code environments. If you would like more background on this idea, please see my [rpodcast/r_dev_projects](https://github.com/rpodcast/r_dev_projects) GitHub repo and the recording from my previous [Shiny Developer Series](https://shinydevseries.com) livestream on [YouTube](https://www.youtube.com/watch?v=4wRiPG9LM3o).

### Current Issues

This package is extremely basic and there is a lot of room for improvement. Pull requests are welcome!

* All of the columns associated with links (RStudio Cloud, Shiny app deployment, and code repository) are list columns, since a post may not have any of the three links or may have multiple links in these three categories. It would be nice to have a way of intelligently post-process the link metadata
* The Discourse API associated with search results does not have a straight-forward approach to pagination. By default, up to 50 results are returned from a given call, and I could not determine a reliable way to grab the next batch of results if more than 50 are actually contained in the date range. Hence I manually defined a set of data ranges such that all of the individual calls would not return more than 50 results, which was not an ideal solution.

## Code of Conduct
  
Please note that the shinycontestscrape project is released with a [Contributor Code of Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html). By contributing to this project, you agree to abide by its terms.
