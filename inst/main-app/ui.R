
ui <- fluidPage(
  fluidRow(column(12, align = "right", offset = 0,
                  actionButton(inputId = "reload", label = "Reload Data")
  )),
  navbarPage("Viral Spread Simulation Activity",
             tabPanel("Histograms",
                      sidebarLayout(
                        sidebarPanel(h4("Simulation Data"),
                                     selectInput("roundnum1", "Round Number", choices = list("Round 0" = 0,
                                                                                             "Round 1" = 1, "Round 2" = 2,
                                                                                             "Round 3" = 3, "Round 4" = 4,
                                                                                             "Round 5" = 5, "Round 6" = 6,
                                                                                             "Round 7" = 7, "Round 8" = 8,
                                                                                             "Round 9" = 9), selected = 0),
                                     actionButton(inputId = "hist", label = "Get Round Histogram")
                        ),
                        mainPanel(plotOutput("showhist")))),
             tabPanel("Frequencies",
                      sidebarLayout(
                        sidebarPanel(h4("Simulation Data"),
                                     actionButton(inputId = "summary", label = "Get Frequencies")),
                        mainPanel(plotOutput("showfreq"))
                      )
             ),
             tabPanel("Spatial",
                      sidebarLayout(
                        sidebarPanel(h4("Simulation Data"),
                                     selectInput("roundnum2", "Round Number", choices = list("Round 0" = 0,
                                                                                             "Round 1" = 1, "Round 2" = 2,
                                                                                             "Round 3" = 3, "Round 4" = 4,
                                                                                             "Round 5" = 5, "Round 6" = 6,
                                                                                             "Round 7" = 7, "Round 8" = 8,
                                                                                             "Round 9" = 9), selected = 0),
                                     actionButton(inputId = "map", label = "Get Round Map")),
                        mainPanel(plotOutput("showspatial"))
                      )
             )
  )
)
