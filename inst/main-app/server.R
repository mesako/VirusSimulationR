library(shiny)
library(RColorBrewer)
library(ggplot2)
library(googledrive)
library(googlesheets4)
library(reshape)

server <- function(input, output) {
  react.vals <- reactiveValues()
  observeEvent(input$reload, {
    react.vals$data <- read_sheet(setup$google.sheet$id, sheet = 1)
    react.vals$data <- VirusSimulationR:::ProcessData(react.vals$data, setup$num.assign)
    react.vals$numassign <- VirusSimulationR:::FixNumAssign(react.vals$data, setup$num.assign)
    react.vals$roundoptions <- VirusSimulationR:::GetRoundOptions(react.vals$data)
    react.vals$numround <- VirusSimulationR:::GetNumRounds(react.vals$roundoptions)
    react.vals$numparticipant <- VirusSimulationR:::GetNumParticipants(react.vals$data)
    react.vals$data <- VirusSimulationR:::SummarizeData(react.vals$data, react.vals$numassign,
                                                        react.vals$roundoptions)
    react.vals$histdata <- VirusSimulationR:::GetHistData(react.vals$data)
    react.vals$freqdata <- VirusSimulationR:::GetFreqData(react.vals$histdata, react.vals$numround)

  }, ignoreNULL = FALSE)

  showhist <- eventReactive(input$hist, {
    VirusSimulationR:::PlotNumberCounts(react.vals$freqdata,
                                        as.numeric(input$roundnum),
                                        VirusSimulationR:::GetPalette(react.vals$numround))
  })
  output$showhist <- renderPlot({
    showhist()
  })

  showfreq <- eventReactive(input$summary, {
    VirusSimulationR:::PlotAllRoundFrequencies(react.vals$freqdata,
                                               react.vals$numparticipant)
  })
  output$showfreq <- renderPlot({
    showfreq()
  })

  # output$mydata <- renderDataTable(react.vals$data)
  # output$numassign <- renderDataTable(react.vals$numassign)
  # output$histdata <- renderDataTable(react.vals$histdata)
  # output$freqdata <- renderDataTable(react.vals$freqdata)
  output$numrefresh <- renderText(input$reload)
  output$roundnum <- renderText(input$roundnum)
}

# server <- function(input, output) {
#   react.vals <- reactiveValues()
#   observeEvent(input$reload, {
#     react.vals$data <- read_sheet(setup$google.sheet$id, sheet = 1)
#   }, ignoreNULL = FALSE)
#   output$mydata <- renderDataTable(react.vals$data)
#   output$numrefresh <- renderText(input$reload)
# }
