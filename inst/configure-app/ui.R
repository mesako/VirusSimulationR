
ui <- fluidPage(
  # titlePanel("THINK 61 Day 1 Set-up",
  #            windowTitle = "THINK 61 Day 1 Set-up"),
  navbarPage("THINK 61 Day 1 Set-up",
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
             ))
  ),
  fluidRow(actionButton("closebutton", "Exit Set-up"))
)
