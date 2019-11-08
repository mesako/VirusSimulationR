# VirusSimulationR
R code to run in-class activity

# Navigation
[Getting Started](#install)  
[Updating VirusSimulationR](#update)  
[Running VirusSimulationR](#howtorun)  
[Example Code for VirusSimulationR](#example)  
[Authors and License](#info)  


## Getting Started
VirusSimulationR was developed and tested on a 64-bit computer with a 3.1-GHz processor running Mac OS X (Version 10.13.6) with 16 GB of RAM.

The instructions below demonstrate how to install this package directly from Github to get the latest release.

### Software and Package Prerequisites:
Install version 3.6.0 or later of R. Users can install R by downloading the appropriate R-x.y.z.tar.gz  file from http://www.r-project.org and following the system-specific instructions. VirusSimulationR was developed and tested on version 3.6.0 of R. As of this release, we recommend using version 3.6.0.

VirusSimulationR depends on the following R libraries: ?? (version). The versions provided are the R package versions for which this VirusSimulationR code has been tested.

In order to install a package from github, you will need the devtools package. You can install this package with the following commands:

```
install.packages("devtools")
library(devtools)
```

VirusSimulationR package depends on several packages, which can be installed using the below commands:

```
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

