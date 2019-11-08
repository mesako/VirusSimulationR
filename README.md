# VirusSimulationR
Interactive group simulation activity for viral spread in R.

# Navigation
[Installing VirusSimulationR](#install)  
[Updating VirusSimulationR](#update)  
[Running VirusSimulationR](#howtorun)  
<!-- [Example Code for VirusSimulationR](#example) -->
<!-- [Authors and License](#info) -->


## Getting Started
VirusSimulationR was developed and tested on a 64-bit computer with a 3.1-GHz processor running Mac OS X (Version 10.13.6) with 16 GB of RAM.

The instructions below demonstrate how to install this package directly from Github to get the latest release.

### Software and Package Prerequisites:
Install version 3.6.0 or later of R. Users can install R by downloading the appropriate R-x.y.z.tar.gz  file from http://www.r-project.org and following the system-specific instructions. VirusSimulationR was developed and tested on version 3.6.0 of R. As of this release, we recommend using version 3.6.0.

VirusSimulationR depends on the following R libraries: RColorBrewer (version 1.1.2), ggplot2 (version 3.2.1), googledrive (version 1.0.0), googlesheets4 (version 0.1.0), reshape (version 0.8.8), and shiny (version 1.3.2). The versions provided are the R package versions for which this VirusSimulationR code has been tested.

In order to install a package from github, you will need the devtools package. You can install this package with the following commands:

```
install.packages("devtools")
library(devtools)
```

VirusSimulationR package depends on several packages, which can be installed using the below commands:

```
install.packages("RColorBrewer") 
install.packages("ggplot2") 
install.packages("googledrive") 
install.packages("googlesheets4") 
install.packages("reshape") 
install.packages("shiny") 
```

<a name="install"></a>
### Installing VirusSimulationR:

To currently get the VirusSimulationR R package up and working on your computer, once you have installed all package dependencies (see above):

1. Open R studio and load devtools using `library(devtools)`. If you don't have devtools you may have to install it with `install.packages("devtools")` and then use `library(devtools)`.
2. Type the following into R studio: `install_github(repo = "mesako/VirusSimulationR")`. 
3. This should start installing all library dependencies so it may take a bit to finish. Check that it finishes without ERROR messages, though it may print WARNINGS.

Typical installation time should take no more than 5 minutes for the most up-to-date VirusSimulationR package. However, total installation time will vary depending on the installation time of other required packages and the speed of your internet connectoin.

<a name="update"></a>
### Updating VirusSimulationR:

To quickly update your VirusSimulationR R package up and get the latest version from GitHub:

1. Open R studio and load devtools using `library(devtools)`.
2. Type the following into R studio: `install_github(repo = "mesako/VirusSimulationR")`.
3. Load VirusSimulationR using `library(VirusSimulationR)`.

If the above commands run without error, you should have the latest version of VirusSimulationR.

## Running VirusSimulationR
<a name="howtorun"></a>
To run this Shiny application, you will need to have created a Google spreadsheet (ideally populated with a linked Google form) and a spreadsheet (.csv file format) matching identfiers to starting number assignments (Round 0 Numbers) as described below.

1. Set up the number assignment spreadsheet, formatted as follows:

| Name | Round0Num | Round0Loc | 
|:----:|:---------:|:---------:|
|  A   |     1     |  Region1  |
|  B   |     0     |  Region1  |
|  C   |     1     |  Region2  |
|  D   |     2     |  Region2  |

You might consider placing cards with all student assignments in the described area (e.g. put a card with A written on one side and 1 written on the back in Region1) before class begins, and ask students to pick up the card under their seat. **You must have this spreadsheet on your computer and be able to navigate to this file to load it into R.**

2. Prepare a Google spreadsheet with the following format of questions:

| Timestamp | Your Identifier | Round Number | Your New Number	| Your Location |	Their Identifier |
|:---------:|:---------------:|:------------:|:----------------:|:-------------:|:----------------:|
| 13:04:26  |        A        |       1      |         0        |    Region1    |         B        |
| 13:05:01  |        B        |       1      |         0        |    Region1    |         A        |
| 13:05:39  |        C        |       1      |         2        |    Region2    |         D        |
| 13:05:58  |        D        |       1      |         2        |    Region2    |         C        |

We recommend creating a Google form that asks the following questions: Your Identifier, Round Number, Your New Number, Your Location, and Their Identifier. It is highly recommended that you set up the Google form to validate certain responses (i.e. ensure that the entry to Your New Number is in fact a numeric value) and also to be formatted as a drop-down menu for constrained answers (i.e. Round Number provided with options for Round 1-9). **You must know the name for this spreadsheet (or at least a unique character substring of this file) so that you can navigate to it in R.**

3. Load the VirusSimulationR package. Run the following commands after installing:

```
library(VirusSimulationR)
```

4. Run the set-up process within R (RStudio is recommended). RUn the following commands:

```
setup <- VirusSimulationR::ConfigureApp()
```

This command when run in R will prompt an Shiny window to open. In this window, you must complete two tasks.

* While the tab "Number Assignments" is highlighted, load the number assignment spreadsheet. Click on the "Browse..." button and navigate to the correct csv file then click Open. Confirm that the data table that appears under "Original Number Assignments" is correct. If it shows up incorrectly, you may need to fix your csv file or navigate to a different file, using the "Browse..." button.

* Navigate to the second step by pressing on the tab labeled "Google Sheet Connection." In the provided text field, enter the unique character string that will solely identify your Google spreadsheet in your Google drive storage. Click on the "Search" button to load up the Google sheet that this text pulls up and confirm that it matches your expectations. If you do not see any data load upon clicking "Search," you may have had multiple files that matched the file name you entered. Please double-check that your text is a unique identifier.

* **If you have issues with the second step, please click on your R/RStudio window and check if any messages have appeared.** A prompt may have appeared in R that asks you for permissions to access your Google drive. Resolve this prompt to give the Shiny application the permissions it needs to pull your data.

Once you finish these two steps, click on the "Exit Set-up" button.

5. Once this process is complete, go to your R/Rstudio window and run the following command to pull up the visualization application:

```
VirusSimulationR::LaunchGUI()
```

* When this window appears, you will notice there is a button labeled "Reload" at the top. If you choose to generate visualizations while students are still submitting data and your Google spreadsheet is continuing to change, you can click this button to pull the most recent data.

* There are currently two visualization options: Histograms and Frequencies shown in separate tabs. Histograms will provide the counts (in number of students) for each possible number option during a given round. You must select the relevant Round and click "Get Round Histogram" to generate the plot. Frequencies will pull up a summary of the change in frequencies of each possible number across all rounds.





