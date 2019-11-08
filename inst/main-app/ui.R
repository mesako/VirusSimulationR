ui <- fluidPage(
  fluidRow(column(12, align = "right", offset = 0,
                  actionButton(inputId = "reload", label = "Reload Data")
  )),
  navbarPage("THINK 61 Day 1 Activity",
             tabPanel("Histograms",
                      sidebarLayout(
                        sidebarPanel(h4("Simulation Data"),
                                     selectInput("roundnum", "Round Number", choices = list("Round 1" = 1, "Round 2" = 2,
                                                                                            "Round 3" = 3, "Round 4" = 4,
                                                                                            "Round 5" = 5, "Round 6" = 6,
                                                                                            "Round 7" = 7, "Round 8" = 8,
                                                                                            "Round 9" = 9), selected = 1),
                                     actionButton(inputId = "hist", label = "Get Round Histogram")
                        ),
                        mainPanel(plotOutput("showhist")))),
             tabPanel("Frequencies",
                      sidebarLayout(
                        sidebarPanel(h4("Simulation Data"),
                                     actionButton(inputId = "summary", label = "Get Frequencies")),
                        mainPanel(plotOutput("showfreq"))
                      )
             )
  )
)