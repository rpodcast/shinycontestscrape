#' Obtain Shiny Contest Submissions Metadata
#'
#' @param year integer for year of contest. Currently only the
#'   year `2021` is supported.
#'
#' @return tibble data frame with various meta-data columns associated
#'   with the post.
#' @import httr
#' @import purrr
#' @import dplyr
#' @export
#' @noRd
get_contest_posts <- function(year = 2021) {
  url <- "https://community.rstudio.com/search.json"

  # set up individual queries with custom date ranges
  if (year == 2021) {
    start_date <- "2021-03-10"
    end_date <- "2021-05-17"
  }
  query_base <- glue::glue("#shiny:shiny-contest tags:shiny-contest-{year}")

  query_all <- c(
    paste(query_base, "after:2021-03-10", "before:2021-03-31"),
    paste(query_base, "after:2021-03-30", "before:2021-04-15"),
    paste(query_base, "after:2021-04-14", "before:2021-04-30"),
    paste(query_base, "after:2021-04-29", "before:2021-05-05"),
    paste(query_base, "after:2021-05-04", "before:2021-05-10"),
    paste(query_base, "after:2021-05-09", "before:2021-05-12"),
    paste(query_base, "after:2021-05-11", "before:2021-05-13"),
    paste(query_base, "after:2021-05-12", "before:2021-05-13"),
    paste(query_base, "after:2021-05-13", "before:2021-05-14"),
    paste(query_base, "after:2021-05-14", "before:2021-05-15"),
    paste(query_base, "after:2021-05-15", "before:2021-05-16"),
    paste(query_base, "after:2021-05-16", "before:2021-05-17")
  )

  df <- purrr::map_dfr(query_all, ~{
    req <- httr::GET(url, query = list(q = .x))
    httr::stop_for_status(req)
    con <- httr::content(req)
    df <- tidy_post_metadata(con)
    Sys.sleep(0.5)
    return(df)
  })

  df <- distinct(df)

  return(df)
}
