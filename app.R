# Load packages ----------------------------------------------------------------
# detach("package:waspasR", unload = TRUE)
# devtools::install_github("flavio-barbara/waspasR", ref = "master")

library(waspasR)
library(shiny)
library(readxl)
library(shinyalert)
library(shinyjs)
library(fmsb)

# Define UI --------------------------------------------------------------------

ui <- fluidPage(
  shinythemes::themeSelector(),
  # App title
  titlePanel("WASPAS for Dummies"),
  # Sidebar layout with input and output definitions
  sidebarLayout(
    # Sidebar panel
    sidebarPanel(
      tags$div(
          h5("This is a web machine that implements the WASPAS method.
          All you have to do is to download the template spreadsheet, fill it with
          your data (alternatives, criteria, weights, the Cost-Benefit flags and
          the values), and upload it. The web WASPAS machine will do the whole
          hard work for you."),
          hr(),
          h4("Please, use the links below to Download:"),
          HTML("User Manual (Portuguese): <a href =
               'Manual waspasWEB.pdf'>
               waspasWEB Manual</a>"),
          p(),
          HTML("Database Template: <a href =
               'https://flaviob.shinyapps.io/waspasWeb/WASPAS_Data_Template.xlsx'>
               WASPAS_Data_Template.xlsx</a>"),
          p(),
          HTML("waspasR Pack from CRAN: <a href =
               'https://cran.r-project.org/bin/windows/contrib/4.3/waspasR_0.1.1.zip'>
               waspasR_0.1.0.tar.gz</a>"),
          p(),
          HTML("waspasR Source from GitHub: <a href =
               'https://github.com/flavio-barbara/waspasR/archive/refs/heads/master.zip'>
               master.zip</a>"),
          p(),
          h5("All rights reserved. Non-commercial (academic) use of the resources
          available on this page is free of charge. The only thing asked in return
          is to cite this tool when the results are used in publications."),
          HTML("Cite the source as: <em>Barbara, Flavio; SANTOS, Marcos dos.
               WASPAS in R (v.1) 2023.</em>"),
          # h5("Todos os direitos reservados. O uso não comercial (acadêmico) dos
          #    recursos disponíveis nessa página é gratuito. A única coisa que se
          #    pede em troca é citar esta ferramenta quando os resultados forem
          #    utilizados em publicações"),
          # HTML("Para citar a fonte: <em>Barbara, Flavio; SANTOS, Marcos dos.
          #                         WASPAS in R (v.1) 2023.</em>"),
          p(),
          fluidRow(
            column(10, align="center",
                   tags$img(height = 124, width = 90, src = "foto.jpeg"),
                   tags$img(height = 124, width = 90, src = "orientador.jpeg"))
          ),
          HTML("Contact: <a href =
               'mailto:flavio.barbara@gmail.com'>flavio.barbara@gmail.com</a>"),

      )
    ),
    # Main panel
    mainPanel(
      tabsetPanel(
        id = "tabset",
        tabPanel("Input",
                 h4("Load CSV from Spreadsheet"),
                 p("Please, upload the file (.csv or .xlsx)."),
                 fileInput("upload", NULL, accept = c(".csv", ".xlsx")),
                 HTML("<hr>"),
                 # htmlOutput("checkInputFormat"),
                 span(textOutput("checkInputFormat"), style="color:red"),
                 HTML("<hr>"),
                 htmlOutput("uploaded_data"),
                 HTML("<hr>"),
                 actionButton("buttonI", "View your data"),
        ),
        tabPanel("View",
                 actionButton("buttonV", "Calculate WASPAS"),
                 tableOutput("upfile")
        ),
        tabPanel("Output",
                 sliderInput(inputId = "lambda",
                             label = "Define the lambda Value:",
                             min = 0,
                             max = 1,
                             value = 0.5),
                 tableOutput("waspas")
        ),
        tabPanel("Radar Graph",
                 sliderInput(inputId = "lambdaR",
                             label = "Define the lambda Value:",
                             min = 0,
                             max = 1,
                             value = 0.5),
                 plotOutput('radarPlot')
        )
      )
    )))

# Define server logic ----------------------------------------------------------

server <- function(input, output, session) {

  # global control flag
  global_control_flag <- "do nothing"
  global_waspas <- NULL

  data <- reactive({
    req(input$upload)
    ext <- tools::file_ext(input$upload$name)
    switch(ext,
           csv = read.csv(input$upload$datapath, header = F),
           xlsx = read_xlsx(input$upload$datapath, col_names = F),
           validate("Invalid file; Please upload a .csv or .xlsx file")
    )
  })

  output$upfile <- renderTable({data()})

  observeEvent(input$buttonI, {
    updateTabsetPanel(session, "tabset", selected = "View")
  })

  observeEvent(input$upload, {
    req(data())
    output$uploaded_data <- renderUI(
      tagList(tags$p(paste("Uploaded file: ",input$upload$name)),
              tags$p(paste("Size: ",input$upload$size, " bytes")),
              tags$p(paste("Type: ",input$upload$type)),
              tags$p(paste("Number of Criteria: ",ncol(data())-1)),
              tags$p(paste("Number of Alternatives: ",nrow(data())-3))
      )
    )})

  observeEvent(input$upload, {
    req(data())
    msg <- checkInputFormat(data())
    if (!isTRUE(msg)){
      global_control_flag <<- "cannot calculate"
      output$checkInputFormat <- renderText(msg)
    } else {
      global_control_flag <<- "go ahead"
    }
  })

  observeEvent(input$buttonV, {
    if (global_control_flag == "do nothing")
      return(NULL)
    if (global_control_flag == "cannot calculate") {
      shinyalert("Can't Calculate!",
                 "Please fix the error in you database and reload it."
                 , type = "error")
      updateTabsetPanel(session, "tabset", selected = "Input")
      return(NULL)
    }
    updateTabsetPanel(session, "tabset", selected = "Output")
    observe({
      val <- input$lambda
      if (!global_control_flag == "already have waspas"){
        waspas <- waspasR(data(), val)
        waspas <- waspas[-(1:2), c("Alternative","WSM_Rank","WPM_Rank","WASPAS_Rank")]
      } else {
        wsm <- global_waspas[, c("Alternative","WSM_Rank")]
        wpm <- global_waspas[, c("Alternative","WPM_Rank")]
        waspas <- applyLambda(wsm, wpm, val)
      }
      waspas <- waspas[order(waspas$WASPAS_Rank, decreasing = TRUE),]
      if (nrow(waspas) > 100) {
        waspas <- waspas[1:100,]
      }
      global_control_flag <<- "already have waspas"
      global_waspas <<- waspas
      output$waspas <- renderTable(global_waspas, digits = 3)
      # if (input$save_xls) write_xlsx(waspas, "WASPAS_Rank.xlsx")
      radardf <- create_radardf(waspas)
      output$radarPlot <- renderPlot({radarchart(
        radardf,
        axistype = 4,
        plwd = 4 ,
        plty = 1,
        cglcol = "grey",
        cglty = 1,
        axislabcol = "grey",
        cglwd = 0.8,
        vlcex = 0.8
      )})
      shinyjs::disable("Button1")
    })
  })

  observeEvent(input$lambdaR, {
    req(data())
    updateSliderInput(session, "lambda", value = input$lambdaR)
    # legend(x=0.7, y=1.2, legend = c("WSM","WPM","WASPAS"))
  })

}

####### Radar Chart
create_radardf  <- function(inputdf) {
  # Transposing the matrix (df) rows will be column names
  radardf <- data.frame(matrix(ncol = nrow(inputdf), nrow = 0))
  colnames(radardf) <- inputdf$Alternative
  radardf[1, ] <- 1.0
  radardf[2, ] <- 0.0
  radardf[3, ] <- inputdf[, 2]
  radardf[4, ] <- inputdf[, 3]
  radardf[5, ] <- inputdf[, 4]
  return(radardf)
}

####### run app
shinyApp(ui = ui, server = server)
