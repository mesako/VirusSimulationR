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
    react.vals$data <- VirusSimulationR:::RemoveOddData(react.vals$data, react.vals$numassign)
    react.vals$roundoptions <- VirusSimulationR:::GetRoundOptions(react.vals$data)
    react.vals$numround <- VirusSimulationR:::GetNumRounds(react.vals$roundoptions)
    react.vals$numparticipant <- VirusSimulationR:::GetNumParticipants(react.vals$data)
    react.vals$data <- VirusSimulationR:::SummarizeData(react.vals$data, react.vals$numassign,
                                                        react.vals$roundoptions)
    react.vals$histdata <- VirusSimulationR:::GetHistData(react.vals$data, react.vals$roundoptions)
    react.vals$freqdata <- VirusSimulationR:::GetFreqData(react.vals$histdata, react.vals$numround)

  }, ignoreNULL = FALSE)

  showhist <- eventReactive(input$hist, {
    VirusSimulationR:::PlotNumberCounts(react.vals$freqdata,
                                        as.numeric(input$roundnum1),
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

  showspatial <- eventReactive(input$map, {
    results <- VirusSimulationR:::GenerateSpatialMap(react.vals$data, setup$roomlabels,
                                                     react.vals$roundoptions)
    roommap <- results[[1]]
    spatialdata <- results[[2]]
    positions <- results[[3]]
    roundmap <- VirusSimulationR:::PlotSpatial(spatialdata, positions, as.numeric(input$roundnum2), roommap)
    roundmap
  })
  output$showspatial <- renderPlot({
    showspatial()
  })

  output$numrefresh <- renderText(input$reload)
  output$roundnum1 <- renderText(input$roundnum1)
  output$roundnum2 <- renderText(input$roundnum2)
}
