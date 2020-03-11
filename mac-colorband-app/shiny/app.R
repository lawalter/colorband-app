# license -----------------------------------------------------------------

# MIT License
# 
# Copyright (c) 2020 L. Abigail Walter
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#   
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# intro -------------------------------------------------------------------

# A BIRD BAND COLOR COMBINATION GENERATOR SHINY APP
# Mar 2020

# libraries ---------------------------------------------------------------

library(tidyverse)

#devtools::install_github("trestletech/shinyStore", force = TRUE)
library(shinyStore)

# ui ----------------------------------------------------------------------

# Define UI for application:

ui <- 
  
  fluidPage(
    
    # CSS:
    includeCSS('www/colorband-app.css'),
    
    # Application title:
    fluidRow(
      column(
        width = 10, 
        tags$h1("Colorband Combination Generator"))),
    
    # Sidebar with input options:
    sidebarLayout(
      sidebarPanel(
        
        # Initialize shinyStore:
        initStore("store", "shinyStore-mac-app"),
        
        # Colors checkbox input:
        checkboxGroupInput("colorVector",
                           "Colors available:",
                           choices = list("[X] Aluminum" = "X",
                                          "[R] Red" = "R", 
                                          "[O] Orange" = "O",
                                          "[Y] Yellow" = "Y", 
                                          "[G] Green" = "G",
                                          "[B] Blue" = "B", 
                                          "[M] Purple" = "M",
                                          "[P] Pink" = "P", 
                                          "[W] White" = "W",
                                          "[K] Black" = "K", 
                                          "[E] Grey" = "E"),
                           selected = c("X")),
        
        # Location selection input:
        selectInput("location", 
                    "Location:", 
                    choices = list("Washington, DC" = 1, 
                                   "Newark, DE" = 2,
                                   "Tallahassee, FL" = 3,
                                   "Pittsburgh, PA" = 4,
                                   "Providence, RI" = 5)),
        
        actionButton("go", "Save choices", 
                     icon("crow", lib = "font-awesome"))),
      
      # Main panel:
      
      mainPanel(
        h4("Colors chosen"),
        verbatimTextOutput("colors"),
        br(),
        h4("Random combination"),
        tableOutput("combo_list"), 
        actionButton("refresh", icon("refresh")),
        br(), 
        br(),
        textOutput("combo_count"),
        br(),
        downloadButton("downloadData", "Download full .csv"),
        br(),
        br(),
        imageOutput("image"))
    )
  )

# server ------------------------------------------------------------------

# Define color combo function:

combo_generate <-
  function(x) {
    as_tibble(x) %>%
      transmute(color = value) %>%
      # All potential combos of left and right legs:
      expand(left = color,
             right = color) %>%
      unite('color', sep = '') %>%
      expand(left = color,
             right = color) %>%
      # Unite as a single column:
      unite('color', sep = '') %>%
      # Filter for correct number of bands:
      filter(str_count(color, '[A-Z]') == 4) %>%
      {if("X" %in% x){
        filter(
          .,
          # Keep combos with one, and only one, aluminum:
          str_count(.$color, 'X') == 1)
      } else .} %>%
      # Randomize output:
      sample_n(size = nrow(.))
  }

# Define server logic:

server <- function(input, output, session) {
  
  # Reactive:
  dataInput <- reactive({
    combo_generate(input$colorVector)
  })
  
  # Vector of colors chosen:
  output$colors <- renderText(input$colorVector)
  
  # One random combination created from colors chosen:
  output$combo_list <-
    renderTable({head(dataInput(), n = 1)},
                bordered = TRUE,
                hover = FALSE,
                colnames = FALSE)
  
  # Number of possibilities:
  output$combo_count <- renderText({
    paste0('Total possibilities: ', 
           nrow(combo_generate(input$colorVector)))})
  
  # All random combinations in a download-friendly format:
  combo_list_csv <- reactive({dataInput()})
  
  # Download handler:
  output$downloadData <- downloadHandler(
    filename = paste0("colorband_list-", Sys.Date(), ".csv"),
    content = function(file){write.csv(combo_list_csv(), file)})
  
  # Load image from location chosen:
  output$image <- 
    renderImage({
      # When input$location is 1, filename is ./www/image1.png
      filename <- 
        normalizePath(
          file.path(
            './www', paste('image', input$location, '.png', sep='')))
      # Return a list containing the filename
      list(src = filename, height = 200, class = 'shiny-image-output')}, 
      deleteFile = FALSE)
  
  # Memory using shinyStore for color checkbox input:
  observe({
    if (input$go <= 0){
      # On initialization, set the values of the checkbox group
      # to the saved values.
      updateCheckboxInput(session, "colorVector", 
                          value = isolate(input$store)$colorVector)
      updateSelectInput(session, "location",
                        selected = isolate(input$store)$location)
      
      return()
    }
    updateStore(session, "colorVector", isolate(input$colorVector))
    updateStore(session, "location", isolate(input$location))
  })
  
}

# run ---------------------------------------------------------------------

# Run the application:

shinyApp(ui = ui, server = server)

