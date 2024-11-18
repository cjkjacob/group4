library(shiny)
library(ggplot2)
library(dplyr)
library(scales)

# Define UI
ui <- fluidPage(
  titlePanel("US Economic Analysis: Effect of Unemployment Rate to GDP"),
  sidebarLayout(
    sidebarPanel(
      fileInput("datafile", "Upload Your Dataset (.xls or .xlsx)", 
                accept = c(".xls", ".xlsx")),
      sliderInput("year_range", "Select Year Range", min = 2000, max = 2024, 
                  value = c(2000, 2024), step = 1),
      h4("Click on a point to see details."),
      h5("Recession Periods"),
      numericInput("start_recession1", "Start Year (Recession 1)", value = 2007, min = 2004),
      numericInput("end_recession1", "End Year (Recession 1)", value = 2009, min = 2004),
      numericInput("start_recession2", "Start Year (Recession 2)", value = 2019, min = 2004),
      numericInput("end_recession2", "End Year (Recession 2)", value = 2020, min = 2004)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Unemployment Rate", plotOutput("unemployment_plot"), click = "plot_clock", verbatimTextOutput("unemployment_analysis")),
        tabPanel("GDP and Unemployment", plotOutput("gdp_plot"), verbatimTextOutput("gdp_analysis"))
      )
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  
  # Reactive expression for data upload
  data <- reactive({
    req(input$datafile)
    readxl::read_excel(input$datafile$datapath) %>%
      rename(
        Year = `Years (DATE)`,
        Unemployment_Rate = `Average of Unemployment Rate`,
        GDP = `Average of Nominal Gross Domestic Product for United States`
      ) %>%
      mutate(Year = as.numeric(Year))
  })
  
  # Unemployment Rate Plot
  output$unemployment_plot <- renderPlot({
    req(data())
    filtered_data <- data() %>% filter(Year >= input$year_range[1] & Year <= input$year_range[2])
    
    recessions <- data.frame(
      start = c(input$start_recession1, input$start_recession2),
      end = c(input$end_recession1, input$end_recession2)
    )
    
    ggplot(data = filtered_data, aes(x = Year, y = Unemployment_Rate)) +
      geom_line(color = "lightblue", size = 1) +
      geom_point(color = "blue", size = 1) +
      geom_rect(data = recessions, aes(xmin = start, xmax = end, ymin = -Inf, ymax = Inf),
                fill = "grey", alpha = 0.2, inherit.aes = FALSE) +
      labs(title = "Unemployment Rate in the US (Last 20 Years)",
           x = "Year",
           y = "Unemployment Rate (in %)") +
      theme_minimal()
  })
  
  output$unemployment_analysis <- renderText({ 
  "Unemployment Rate Appears to Surge in Periods of Recession
As shown in the graph, there are two periods in time where unemployment rate 
spikes significantly, which started in 2007 and peaked in 2010. The second period 
of time where unemployemnt rate spiked starts in 2019 and peaked in 2020. It 
is evident that the 2008 economic crisis and COVID-19 pandemic caused the 
unemployment rate to increase. During high uenmployment levels, people have 
less money to spend, so demand decreases, and prices (inflation) stay low. 
Wages also tend to remain stagnant. However, the spike in unemployment rate is 
followed by a continous and steady decrease in unemployment rate, showing that 
the economy is recovering. This indicates that as unemployment rate decreases, 
inflation start to increase for periods after 2010.
    
  2008 Economic Crisis Has Bigger Effect on Unemployment Rate than COVID-19 
The graph shows that the recovery after the 2007-2008 economic crisis in the 
US is longer than the recover after the COVID-19 pandemic.The 2008 financial 
crisis was an epic financial and economic collapse that cost many ordinary people 
their jobs, their life savings, their homes, or all three. Therefore, the effects 
of the crisis caused unemployment rate to spike significantly (reaching over 9%), 
more than COVID-19 caused unemployment rate to increase (slightly above 8%). The 
amount of years it took for the unemployment rate to decrease are 9 years, from 
2011 to 2019. The decreasing levels of unemployment rates signify that inflation 
starts to increase during those years. More jobs and higher wages increase household 
incomes and lead to a rise in consumer spending, further increasing aggregate demand 
and the scope for firms to increase the prices of their goods and services. "
  })
  
  # GDP and Unemployment Plot
  output$gdp_plot <- renderPlot({
    req(data())
    filtered_data <- data() %>% filter(Year >= input$year_range[1] & Year <= input$year_range[2])
    
    scale_factor <- max(filtered_data$GDP) / max(filtered_data$Unemployment_Rate)
    
    ggplot(filtered_data, aes(x = Year)) +
      geom_bar(aes(y = GDP), stat = "identity", fill = "#48c9b0", width = 0.7) +
      geom_line(aes(y = Unemployment_Rate * scale_factor, color = "Unemployment Rate"), size = 1) +
      scale_y_continuous(
        name = "GDP (in millions $)",
        sec.axis = sec_axis(~ . / scale_factor, name = "Unemployment Rate (%)")
      ) +
      labs(title = "GDP (in millions $) and Unemployment Rate (%)",
           x = "Year") +
      scale_color_manual(name = "", values = c("Unemployment Rate" = "#1f78b4")) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  output$gdp_analysis <- renderText({ 
  "Spikes in Unemployment Rates Leads to Decrease in GDP
This chart illustrates the relationship between GDP (in millions of dollars) and 
the unemployment rate (%) over time, highlighting how spikes in unemployment rates 
often correspond with subsequent declines or slower growth in GDP. For example, the 
significant rise in the unemployment rate around 2009 aligns with the economic downturn 
during the financial crisis, which visibly impacted GDP growth. Similarly, the spike in 
unemployment in 2020 due to the COVID-19 pandemic coincides with a decline in GDP growth, 
indicating the strong influence that high unemployment rates have on economic productivity 
and output. This pattern shows the negative impact of rising unemployment on economic 
health, as reduced consumer spending and decreased business activity contribute to slower 
GDP growth during these periods.
    
Economic Resilience Amidst Fluctuating Unemployment Rates
The graph suggests that despite spikes in unemployment, U.S. GDP demonstrates a trend of steady 
growth over the long term. Even after significant increases in unemployment and economic 
downturns, GDP eventually resumes its upward trajectory, highlighting the economy’s resilience
and capacity for recovery. The pattern shows that while unemployment has short-term impacts on 
economic output, other factors, such as policy responses, innovation, and investment, play 
crucial roles in sustaining and driving GDP growth over time. This resilience points to the 
adaptability of the economy, as it manages to recover and expand even after periods of high 
unemployment."
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
