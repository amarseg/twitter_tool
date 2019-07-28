#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
  output$tweetplot <- renderPlot({
    
    rt <- search_tweets(
      input$search_term, n = 18000, include_rts = FALSE
    )
    
    ts_plot(rt, "3 hours") +
      ggplot2::theme_minimal() +
      ggplot2::theme(plot.title = ggplot2::element_text(face = "bold")) +
      ggplot2::labs(
        x = NULL, y = NULL,
        title = "Frequency of #rstats Twitter statuses from past 9 days",
        subtitle = "Twitter status (tweet) counts aggregated using three-hour intervals",
        caption = "\nSource: Data collected from Twitter's REST API via rtweet"
      )
  })
  
})
