# Load required libraries
library(shiny)
library(ggplot2)
library(dplyr)

# Mock data for Renewable Adoption Rates and Total Energy Consumption
set.seed(42)
mock_data <- data.frame(
  year = 2000:2023,
  energy_price = runif(24, 50, 150), # Placeholder for WPU0543 or CUSR0000SEHF01
  renewable_adoption = runif(24, 10, 50), # Mock renewable adoption rate (%)
  total_consumption = runif(24, 500, 2000), # Mock total energy consumption (TWh)
  renewable_share = runif(24, 5, 30) # Mock renewable share (%)
)

# UI
ui <- fluidPage(
  titlePanel("Bubble Chart: Energy Prices, Renewable Adoption, and Total Energy"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("yearRange", "Select Year Range:", 
                  min = min(mock_data$year), max = max(mock_data$year),
                  value = c(min(mock_data$year), max(mock_data$year)), step = 1)
    ),
    mainPanel(
      plotOutput("bubbleChart")
    )
  )
)

# Server
server <- function(input, output) {
  filtered_data <- reactive({
    mock_data %>%
      filter(year >= input$yearRange[1], year <= input$yearRange[2])
  })
  
  output$bubbleChart <- renderPlot({
    ggplot(filtered_data(), aes(x = energy_price, y = renewable_adoption, 
                                size = renewable_share, color = as.factor(year))) +
      geom_point(alpha = 0.7) +
      scale_size_continuous(range = c(5, 15)) +
      labs(
        title = "Energy Prices vs Renewable Adoption",
        x = "Energy Price Index",
        y = "Renewable Adoption Rate (%)",
        size = "Renewable Share (%)",
        color = "Year"
      ) +
      theme_minimal()
  })
}

# Run the app
shinyApp(ui = ui, server = server)
