library(shiny)
library(bslib)
library(ggplot2)
library(dplyr)
library(readxl)
library(plotly)

# Default dataset path
default_path <- "C:/Users/sammy/Downloads/csv/week 4 deliverables shiny app/Labor_Market_Dynamics_Trends_.xlsx"

# UI definition
ui <- page_sidebar(
  title = "Data Analysis Dashboard",
  sidebar = sidebar(
    # Data input options
    radioButtons("data_input_type", "Choose data input method:",
                 choices = c("Use Default File" = "default",
                             "Upload New File" = "upload")),
    
    # Conditional panel for file upload
    conditionalPanel(
      condition = "input.data_input_type == 'upload'",
      fileInput("file", "Upload Excel File (.xlsx)", accept = c(".xlsx"))
    ),
    
    # Other inputs
    selectInput("sheet", "Select Sheet", choices = NULL),
    selectInput("x_var", "Select X Variable", choices = NULL),
    selectInput("y_var", "Select Y Variable", choices = NULL),
    selectInput("group_var", "Select Grouping Variable (Optional)", 
                choices = NULL, multiple = TRUE)
  ),
  
  navset_card_tab(
    nav_panel(
      "Timeline",
      plotlyOutput("timeline_plot")
    ),
    nav_panel(
      "Bar Plot",
      plotlyOutput("bar_plot")
    ),
    nav_panel(
      "Histogram",
      plotlyOutput("histogram")
    ),
    nav_panel(
      "Scatter Plot",
      plotlyOutput("scatter_plot")
    )
  )
)

# Server logic
server <- function(input, output, session) {
  
  # Reactive value for storing the dataset
  data <- reactiveVal()
  
  # Handle data input based on selection
  observe({
    if (input$data_input_type == "default") {
      # Check if default file exists
      if (file.exists(default_path)) {
        sheets <- excel_sheets(default_path)
        updateSelectInput(session, "sheet", choices = sheets)
      } else {
        showNotification("Default file not found!", type = "error")
      }
    }
  })
  
  # Update sheet names when file is uploaded
  observeEvent(input$file, {
    req(input$file)
    sheets <- excel_sheets(input$file$datapath)
    updateSelectInput(session, "sheet", choices = sheets)
  })
  
  # Read selected sheet and update variable choices
  observeEvent(input$sheet, {
    req(input$sheet)
    
    tryCatch({
      if (input$data_input_type == "default") {
        df <- read_excel(default_path, sheet = input$sheet)
      } else {
        req(input$file)
        df <- read_excel(input$file$datapath, sheet = input$sheet)
      }
      
      data(df)
      
      # Update variable selection choices
      vars <- names(df)
      updateSelectInput(session, "x_var", choices = vars)
      updateSelectInput(session, "y_var", choices = vars)
      updateSelectInput(session, "group_var", choices = c("None" = "", vars))
    }, 
    error = function(e) {
      showNotification(paste("Error reading data:", e$message), type = "error")
    })
  })
  
  # Timeline Plot
  output$timeline_plot <- renderPlotly({
    req(data(), input$x_var, input$y_var)
    df <- data()
    
    p <- ggplot(df, aes_string(x = input$x_var, y = input$y_var)) +
      geom_line() +
      theme_minimal() +
      labs(title = "Timeline Plot")
    
    ggplotly(p)
  })
  
  # Bar Plot
  output$bar_plot <- renderPlotly({
    req(data(), input$x_var, input$y_var)
    df <- data()
    
    p <- ggplot(df, aes_string(x = input$x_var, y = input$y_var)) +
      geom_bar(stat = "identity") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      labs(title = "Bar Plot")
    
    ggplotly(p)
  })
  
  # Histogram
  output$histogram <- renderPlotly({
    req(data(), input$x_var)
    df <- data()
    
    p <- ggplot(df, aes_string(x = input$x_var)) +
      geom_histogram(bins = 30) +
      theme_minimal() +
      labs(title = "Histogram")
    
    ggplotly(p)
  })
  
  # Scatter Plot
  output$scatter_plot <- renderPlotly({
    req(data(), input$x_var, input$y_var)
    df <- data()
    
    if (length(input$group_var) > 0 && input$group_var != "") {
      p <- ggplot(df, aes_string(x = input$x_var, y = input$y_var, 
                                 color = input$group_var)) +
        geom_point() +
        theme_minimal() +
        labs(title = "Scatter Plot")
    } else {
      p <- ggplot(df, aes_string(x = input$x_var, y = input$y_var)) +
        geom_point() +
        theme_minimal() +
        labs(title = "Scatter Plot")
    }
    
    ggplotly(p)
  })
}

# Run the app
shinyApp(ui = ui, server = server)
