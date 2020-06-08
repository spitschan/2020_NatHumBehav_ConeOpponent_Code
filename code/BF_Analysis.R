###################################################################################
## Code written for Bayes Factor analysis for the "Twilight Study"               ##
##                                                                               ##
## Author: MSpitschan                                                            ##
##                                                                               ##
###################################################################################
rm(list = ls())

# --- set working directory
p <- "/Users/spitschan/Projects/2020_NatHumBehav_ConeOpponent_Code/code"
setwd(p)

#----- check if pacman is installed - if not install it
if(!require(pacman)) install.packages("pacman")

#----- use pacman function p_load to check all packages that you are using in this script
pacman::p_load(ggplot2, viridis, BayesFactor, devtools)


####################################################################
#----- Step 1: Simulate some data.
# We are simulating the data for 16 subjects across three conditions here. 
# For demonstration purposes, we are simply simulating data that are not meaningful.
# The purpose is just to show the use of the BayesFactor package.
NSubjects <- 16
NConditions <- 3 
phaseShifts <- rnorm(NSubjects*NConditions, 0, 1)
participantID <- factor(rep(seq(1, NSubjects), NConditions))
condition <- c(rep(1, NSubjects), rep(2, NSubjects), rep(3, NSubjects))
condition <- factor(condition, levels=c(1, 2, 3), labels=c("Background", "+S-(L+M)", "-S+(L+M)"))

# Set it up in a dataframe
df <- data.frame(participantID, condition, phaseShifts)

#----- Step 2: Run the Bayes Factor analysis
bf = anovaBF(phaseShifts ~ condition + participantID, data = df, 
             whichRandom="ID")

#----- Step 3: Plot the BFs
plot(bf)