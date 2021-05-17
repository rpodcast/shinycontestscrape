#' Obtain Shiny Contest Submissions
#'
#' @param year integer for year of contest. Currently only the
#'   year `2021` is supported.
#' @param add_sleep boolean to add a simple sleep between the calls to
#'   extracting contest post details.
#' @param show_progress boolean to show progress bar. Default is `TRUE`.
#' @return tidy data frame with post metadata and links
#' @import progress
#' @import dplyr
#' @export
get_contest_data <- function(year = 2021, add_sleep = TRUE, show_progress = TRUE) {
  if (year != 2021) {
    stop("Only the 2021 Shiny Contest is supported at this time.", call. = FALSE)
  }

  # Obtain metadata of posts as a tidy data frame
  df <- get_contest_posts(year = year)

  # initialize progress bar if requested
  pb <- NULL
  if (show_progress) {
    pb <- progress::progress_bar$new(total = nrow(df))
  }

  # finish extraction
  df <- df %>%
    mutate(links = purrr::map(url, ~get_post_links(.x, add_sleep = add_sleep, pb = pb))) %>%
    mutate(rstudiocloud_url = purrr::map(links, extract_rstudiocloud_link),
           shinyapp_url = purrr::map(links, extract_shinyapp_link),
           repo_url = purrr::map(links, extract_repo_link))

  return(df)
}
