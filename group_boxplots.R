# R script to draw grouped boxplots ---------------------------------------

library(xlsx)
setwd("~/work/Github/nurolab/MRS_analysis/")
cat('\f')
rm(list=ls())
ifile <- 'MRS_data.xlsx'
cat("Drawing group boxplots of", ifile, "for all metabolites\n")
data <- read.xlsx(ifile, sheetIndex = 1)
data <- as.matrix(noquote(na.omit(data)))
cols <- ncol(data)
rows <- nrow(data)
groups <- length(unique((data[,cols])))
df_len <- 0
for( j in 3:cols-1 ){
    paste("Now drawing plot for", colnames(data)[j])
    plotfile <- paste(colnames(data)[j],".png", sep = "")
    png(filename = plotfile, width = 600, height = 600)
    for( i in unique((data[,cols]))){
        if(df_len < length(data[which(data[,cols]==i),][,j]))
            df_len <- length(data[which(data[,cols]==i),][,j])
    }
    d <- matrix(nrow = df_len, ncol = groups)
    for( i in unique((data[,cols]))){
        d[1:length(data[which(data[,cols]==i),][,j]),i] <- data[which(data[,cols]==i),][,j]
    }
    boxplot(d, col = heat.colors(groups, alpha=1), boxwex = 0.2,
            notch = F, at = 1:groups, axes=F,
            main = "Metabolite difference in groups", xlab = colnames(data)[j])
    axis(side = 2)
    axis(1, at = 1:groups, labels = 1:groups)
    dev.off()
}

