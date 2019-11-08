#' GUI for launching shiny Application for Configuration
#' @examples
#' \dontrun{ConfigureApp()}
#' @export
ConfigureApp <- function() {
  requireNamespace("shiny")
  requireNamespace("googledrive")
  requireNamespace("googlesheets4")
  runApp(appDir = file.path(system.file(package = "VirusSimulationR"), "configure-app"))
}

#' GUI for launching shiny Application for Visualization
#' @examples
#' \dontrun{LaunchGUI()}
#' @export
LaunchGUI <- function() {
  requireNamespace("shiny")
  requireNamespace("googledrive")
  requireNamespace("googlesheets4")
  runApp(appDir = file.path(system.file(package = "VirusSimulationR"), "main-app"))
}
