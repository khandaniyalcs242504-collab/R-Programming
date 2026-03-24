library(shiny)
library(randomForest)
library(bslib)
library(scales) # for color transparency

# 1. DATA & MODEL -------------------------------------------------------
data <- read.csv("Crop_recommendation.csv")
if ("label" %in% colnames(data)) colnames(data)[colnames(data) == "label"] <- "crop"
X <- data[, !(names(data) %in% c("crop"))]
y <- as.factor(data$crop)
model <- randomForest(x = X, y = y, ntree = 100)

# 2. USER INTERFACE (Vibrant Theme) -------------------------------------
ui <- page_navbar(
  title = "🌾 CROP RECOMMENDER MODEL",
  theme = bs_theme(
    version = 5,
    bootswatch = "lux", # Professional base
    primary = "#1D976C", 
    "navbar-bg" = "#1D976C" # Solid green header
  ),
  
  # Custom CSS for gradients and colors
  tags$head(
    tags$style(HTML("
      body { 
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%); 
        min-height: 100vh;
      }
      .card { border-radius: 20px; border: none; box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
      .prediction-box {
        background: linear-gradient(to right, #1D976C, #93F9B9);
        color: white;
        border-radius: 15px;
        padding: 40px;
        text-align: center;
        margin-bottom: 20px;
      }
      .result-title { font-size: 56px; font-weight: 900; text-shadow: 2px 2px 5px rgba(0,0,0,0.2); }
      /* Colorful Sliders */
      .irs-bar { background: #1D976C !important; border-top: 1px solid #1D976C !important; border-bottom: 1px solid #1D976C !important; }
      .irs-from, .irs-to, .irs-single { background: #1D976C !important; }
    "))
  ),
  
  nav_panel("Predictor",
            layout_sidebar(
              sidebar = sidebar(
                width = 350,
                title = "Parameters",
                # Adding some color icons to labels
                sliderInput("N", "🧪 Nitrogen Content", 0, 150, 50),
                sliderInput("P", "🧪 Phosphorus Content", 0, 150, 50),
                sliderInput("K", "🧪 Potassium Content", 0, 200, 50),
                hr(),
                sliderInput("temperature", "🌡️ Temperature (°C)", 0, 50, 25),
                sliderInput("humidity", "💧 Humidity (%)", 0, 100, 50),
                sliderInput("ph", "⚗️ Soil pH", 0, 14, 6.5, step = 0.1),
                sliderInput("rainfall", "🌧️ Rainfall (mm)", 0, 300, 100),
                
                actionButton("predict", "Get Best Crop", 
                             class = "btn-primary btn-lg", 
                             style = "width: 100%; font-weight: bold; margin-top: 10px;")
              ),
              
              # Main Content Area
              div(
                uiOutput("result_card"),
                layout_column_wrap(
                  width = 1/2,
                  card(
                    card_header(class = "bg-primary text-white", "Soil Nutrient Analysis"),
                    plotOutput("barPlot")
                  ),
                  card(
                    card_header(class = "bg-info text-white", "Regional Climate Trends"),
                    plotOutput("scatterPlot")
                  )
                )
              )
            )
  ),
  
  nav_panel("About Data",
            card(
              card_header("Dataset Overview"),
              "This system uses a Random Forest Classifier trained on soil and climate data to suggest the most profitable crop to grow."
            )
  )
)

# 3. SERVER LOGIC -------------------------------------------------------
server <- function(input, output) {
  
  prediction_val <- eventReactive(input$predict, {
    new_data <- data.frame(N=input$N, P=input$P, K=input$K, 
                           temperature=input$temperature, humidity=input$humidity, 
                           ph=input$ph, rainfall=input$rainfall)
    as.character(predict(model, new_data))
  })
  
  output$result_card <- renderUI({
    if (input$predict == 0) {
      div(class = "prediction-box", style = "background: #7f8c8d;",
          h2("Ready for Analysis"),
          p("Enter parameters and click 'Get Best Crop'"))
    } else {
      div(class = "prediction-box",
          p("Based on AI Analysis, you should plant:", style="font-size: 20px; opacity: 0.9;"),
          div(class = "result-title", paste("✨", toupper(prediction_val()), "✨"))
      )
    }
  })
  
  output$barPlot <- renderPlot({
    req(input$predict)
    vals <- c(input$N, input$P, input$K, input$temperature, input$humidity, input$ph, input$rainfall)
    names(vals) <- c("N","P","K","Temp","Humid","pH","Rain")
    
    # Using a vibrant palette
    colors <- c("#FF6B6B", "#4ECDC4", "#FFE66D", "#1A535C", "#FF9F1C", "#2EC4B6", "#E71D36")
    barplot(vals, col = colors, border = "white", las = 2, main = "Your Input Values")
  })
  
  output$scatterPlot <- renderPlot({
    # Use all data but make it semi-transparent for a "cloud" look
    plot(data$temperature, data$humidity, 
         col = alpha("#3498db", 0.4), pch = 16, 
         xlab = "Temp", ylab = "Humidity", 
         main = "Climate Clustering")
    # Highlight the current user point in red
    points(input$temperature, input$humidity, col = "red", pch = 18, cex = 3)
    legend("topright", legend = "Your Location", col = "red", pch = 18)
  })
}

shinyApp(ui, server)