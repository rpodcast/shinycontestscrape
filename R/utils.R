#' @import dplyr
#' @import purrr
#' @export
#' @noRd
tidy_post_metadata <- function(x) {
  # obtain key metadata and assemble tibble
  df <- tibble::tibble(
    author = purrr::map_chr(x[["posts"]], c("name")),
    username = purrr::map_chr(x[["posts"]], c("username")),
    created_at = purrr::map_chr(x[["posts"]], c("created_at")),
    topic_id = purrr::map_int(x[["posts"]], c("topic_id")),
    slug = purrr::map_chr(x[["topics"]], c("slug")),
  ) %>%
    mutate(url = glue::glue("https://community.rstudio.com/t/{slug}/{topic_id}"))

  return(df)
}

extract_rstudiocloud_link <- function(links) {
  res <- stringr::str_subset(links, pattern = "rstudio.cloud")

  if (length(res) < 1) res <- NA
  return(res)
}

extract_shinyapp_link <- function(links) {
  res <- stringr::str_subset(links, pattern = "shinyapps.io")
  if (length(res) < 1) res <- NA
  return(res)
}

extract_repo_link <- function(links) {
  res <- stringr::str_subset(links, pattern = "github.com")
  if (length(res) > 1) {
    slash_count <- purrr::map_dbl(res, ~stringr::str_count(.x, "\\/"))
    res <- res[slash_count == 4]
  }
  return(res)
}
