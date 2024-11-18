# Load required libraries
library(shiny)
library(tidyverse)
library(lubridate) # For year extraction

# Load the datasets
PNRG <- read_csv("PNRGINDEXM.csv", col_types = cols())
PCU <- read_csv("PCU221110221110P.csv", col_types = cols())

# Prepare the data for plotting
PNRG <- PNRG %>% 
  rename(Date = `DATE`, Value = `PNRGINDEXM`) %>% 
  mutate(Source = "PNRGINDEXM")

PCU <- PCU %>% 
  rename(Date = `DATE`, Value = `PCU221110221110P`) %>% 
  mutate(Source = "PCU221110221110P")

# Combine datasets and convert Date column to Date type
combined_data <- bind_rows(PNRG, PCU) %>% 
  mutate(Date = as.Date(Date))

# Shiny UI
ui <- fluidPage(
  titlePanel("FRED Data Viewer"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("yearRange", 
                  "Select Year Range:", 
                  min = as.numeric(format(min(combined_data$Date), "%Y")),
                  max = as.numeric(format(max(combined_data$Date), "%Y")),
                  value = range(as.numeric(format(combined_data$Date, "%Y"))),
                  step = 1,
                  sep = "")
    ),
    mainPanel(
      plotOutput("linePlot")
    )
  )
)

# Shiny Server
server <- function(input, output) {
  # Filter data based on year range
  filtered_data <- reactive({
    combined_data %>% 
      filter(year(Date) >= input$yearRange[1] & year(Date) <= input$yearRange[2])
  })
  
  # Render the line plot
  output$linePlot <- renderPlot({
    ggplot(filtered_data(), aes(x = Date, y = Value, color = Source, group = Source)) +
      geom_line() +
      labs(title = "FRED Data Over Time",
           x = "Date", 
           y = "Value", 
           color = "Dataset") +
      theme_minimal()
  })
}

# Run the app
shinyApp(ui = ui, server = server)
