library(shiny)
library(shinythemes)
library(plotly)

ui <- fluidPage(
    theme = shinytheme("darkly"),
    includeCSS("styles/main.css"),
    
    
    titlePanel("Shiny Fruit - Farm Activity"),
    
    
    sidebarLayout(sidebarPanel(
        sliderInput(
            "bins",
            "Numero de bins:",
            min = 1,
            max = 200,
            value = 30
        )
    ),
    
    
    mainPanel(plotlyOutput("distPlot")))
)


server <- function(input, output) {
    output$distPlot <- renderPlotly({
        x <- c(1:input$bins)
        y <- rnorm(input$bins, mean = 0)
        
        fig <- plot_ly(x = ~ x, color = "blue")
        fig <-
            fig %>% add_lines(
                y = y + 2,
                name = "25% HIGH",
                line = list(
                    color = 'red',
                    width = 2,
                    dash = 'dot'
                )
            )
        fig <- fig %>% add_lines(
            y = y + 1 ,
            name = "50%",
            line = list(
                color = 'white',
                width = 2,
                dash = 'dot'
            )
        )
        fig <- fig %>% add_lines(
            y = y ,
            name = "25% LOW",
            line = list(
                color = 'blue',
                width = 2,
                dash = 'dot'
            )
        )
        
        fig %>%
            layout(
                font = list(color = '#FFFFFF'),
                plot_bgcolor  = "rgba(0, 0, 0, 0)",
                paper_bgcolor = "rgba(0, 0, 0, 0.3)",
                
                list(
                    type = "line",
                    x0 = 0,
                    x1 = 1,
                    xref = "paper",
                    y0 = y,
                    y1 = y,
                    line = list(color = "red")
                )
            )
    })
    
}


shinyApp(ui = ui, server = server)
