if (!require(xlsx)) install.packages('xlsx')
library(xlsx)
cat('\f')
rm(list=ls())
setwd("~/work/Github/nurolab/MRS_analysis")
ifile = 'MRS_data.xlsx'
cat('Drawing datapoints and their mean of', ifile, 'for all groups\n')
data <- read.xlsx(ifile, sheetIndex = 1)
data <- as.matrix(data)
cols <- ncol(data)
rows <- nrow(data)
x <- data[,2]
y <- factor(data[,cols])

# Generate points and mean only
jpeg("Points_and_mean.jpg", width = 600, height = 600)
boxplot(x ~ y, col = "white", border = "white",
  main = "Data points and Mean",
  xlab = "Groups", ylab = "Concentration",
  boxwex = 0.2, yaxt= 'n', ann=T)
axis(lwd=0.5, line=0, side=2, las=2)
groups <- length(unique(data[,cols]))
points(y, x, pch = 20, col = "blue", cex = 1)
means <- aggregate(x ~ y, data, mean)
points(1:groups, means$x, pch = "_", cex = 3, col = "darkgreen")
# medians <- aggregate(x ~ y, data, median)
# points(1:groups, medians$x, pch = "_", cex = 3, col = "red")
dev.off()

# Generate points and mean with boxplots
jpeg("Points_and_mean_with_boxplots.jpg", width = 600, height = 600)
boxplot(x ~ y, col = "orange", border = "brown",
        main = "Data points and Mean",
        xlab = "Groups", ylab = "Concentration",
        boxwex = 0.2, yaxt= 'n', ann=T)
axis(lwd=0.5, line=0, side=2, las=2)
groups <- length(unique(data[,cols]))
points(y, x, pch = 20, col = "blue", cex = 1)
means <- aggregate(x ~ y, data, mean)
points(1:groups, means$x, pch = "_", cex = 3, col = "darkgreen")
# medians <- aggregate(x ~ y, data, median)
# points(1:groups, medians$x, pch = "_", cex = 3, col = "red")
dev.off()

cat("\fPlease see the Plots")