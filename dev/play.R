devtools::load_all()
devtools::document()

res <- get_contest_posts()

library(progress)

pb <- progress_bar$new(total = nrow(res))

res2 <- res %>%
  mutate(links = purrr::map(url, ~get_post_links(.x)))


res3 <- res2 %>%
  mutate(rstudiocloud_url = purrr::map(links, extract_rstudiocloud_link),
         shinyapp_url = purrr::map(links, extract_shinyapp_link),
         repo_url = purrr::map(links, extract_repo_link))
