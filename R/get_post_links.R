#' Extract all links contained in a discourse post
#'
#' @param url character string of the URL for a post.
#' @param add_sleep boolean to add a simple sleep before
#'   function completes.
#' @param pb progress bar object. If no progress output is
#'   needed, keep this value as `NULL`.
#'
#' @return character vector of all links
#' @import httr
#' @import rvest
#' @import progress
#' @export
get_post_links <- function(url, add_sleep = TRUE, pb = NULL) {
  if (add_sleep) Sys.sleep(0.4)

  if (!is.null(pb)) {
    pb$tick()
  }

  req <- httr::GET(paste0(url, ".json"))
  httr::stop_for_status(req)

  con <- httr::content(req)

  post_text <- con$post_stream$posts[[1]]$cooked

  links <- read_html(post_text) %>%
    html_elements("a") %>%
    html_attr("href")
  return(links)
}
