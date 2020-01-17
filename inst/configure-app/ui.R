
ui <- fluidPage(
  navbarPage("Viral Spread Simulation Set-up",
    tabPanel("Number Assignments",
             sidebarLayout(
               sidebarPanel(
                 h4("CSV File Upload"),
                 fileInput("datafile", "Choose CSV File",
                           accept = c("text/csv", "text/comma-separated-values,text/plain"))
               ),
               mainPanel(
                 h4("Original Number Assignments"),
                 tableOutput("filetable")
               )
             )),
    tabPanel("Google Sheet Connection",
             sidebarLayout(
               sidebarPanel(
                 h4("Google Sheet File Name"),
                 textInput("sheetname", "File Name", value = "", width = NULL,
                           placeholder = NULL),
                 actionButton("searchsheets","Search")
               ),
               mainPanel(
                 h4("File Preview"),
                 tableOutput("sheetdata")
               )
             )),
    tabPanel("Room Set-up",
             sidebarLayout(
               sidebarPanel(
                 h4("Labels for Room Regions"),
                 p("Please enter room labels separated by commas."),
                 textInput("roomlabels", "Labels", value = "", width = NULL,
                           placeholder = "Branner, FloMo, Roble, Stern, Toyon, Wilbur, Crothers, Lagunita, Sterling"),
                 actionButton("loadroom","Load")
               ),
               mainPanel(
                 h4("Room Preview"),
                 plotOutput("roompreview")
               )
             ))
  ),
  fluidRow(actionButton("closebutton", "Exit Set-up"))
)
