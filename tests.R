library(tidyverse)
library(rtweet)
library(tidytext)

rt <- search_tweets(
  "#podemos", n = 18000, include_rts = FALSE
)

tkns <- rt %>%
  select(text) %>% 
  unnest_tokens(word, text) %>%
  anti_join(stop_words)

count_tkns <- tkns %>%
  count(word, sort = TRUE)


ts_plot(rt, "3 hours") +
  ggplot2::theme_minimal() +
  ggplot2::theme(plot.title = ggplot2::element_text(face = "bold")) +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frequency of #rstats Twitter statuses from past 9 days",
    subtitle = "Twitter status (tweet) counts aggregated using three-hour intervals",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )