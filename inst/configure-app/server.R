library(shiny)
library(RColorBrewer)
library(ggplot2)
library(googledrive)
library(googlesheets4)
library(reshape)

server <- function(input, output, session) {
  filedata <- reactive({
    infile <- input$datafile
    if (is.null(infile)) {
      return(NULL)
    }
    read.csv(infile$datapath)
  })
  output$filetable <- renderTable({
    filedata()
  })

  getsheetname <- reactive({
    mysheet <- drive_find(input$sheetname, type = "spreadsheet")
    mysheet
  })

  sheetdata <- eventReactive(input$searchsheets, {
    mysheet <- getsheetname()
    if (nrow(mysheet) == 1) {
      read_sheet(mysheet)
    } else {
      return(NULL)
    }
  })

  output$sheetdata <- renderTable({
    sheetdata()
  })

  observe({
    if (input$closebutton > 0) stopApp(list(num.assign = filedata(),
                                            google.sheet = getsheetname()))
  })
}
