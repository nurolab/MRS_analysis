# R script to draw grouped boxplots ---------------------------------------

if (!require(readxl)) install.packages('readxl')
library(readxl)

# Analyzer parameters -----------------------------------------------------

setwd("~/work/MRS_plots")
data <- read.csv(file = "MRS_data.csv", header = TRUE, sep = ',') # MRS data file

x <- data$X2
y <- factor(data$X8)

boxplot(x ~ y, col = "white", border = "white",
  main = "Data points and Mean",
  xlab = "Groups", ylab = "Concentration",
  boxwex = 0.2, yaxt= 'n', ann=T)
axis(lwd=0.5, line=0, side=2, las=2)

points(y, x, pch = 20, col = "blue", cex = 1)
means <- aggregate(x ~ y, data, mean)
points(1:2, means$x, pch = "_", cex = 3, col = "darkgreen")
medians <- aggregate(x ~ y, data, median)
points(1:2, medians$x, pch = "_", cex = 3, col = "red")

