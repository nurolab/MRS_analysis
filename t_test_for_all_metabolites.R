library(xlsx)
setwd("~/work/Github/nurolab/MRS_analysis")
cat('\f')
rm(list=ls())
ifile <- 'MRS_data.xlsx'
cat('Performing T-statistics on', ifile, 'for all metabolites\n')
data <- read.xlsx(ifile, sheetIndex = 1)
data <- as.matrix(data)
combins <- combn(ncol(data), 2)
rows <- ncol(combins)
t_stats <- matrix(nrow = rows, ncol = 12, data = NA)
colnames(t_stats) <- c("X","Y","T-statistic","Parameter","P-value","Method","Alternative",
                       "Null-value","Conf. Int 1","Conf. Int 2","Estimate 1","Estimate 2")
for(i in 1:rows){
    t_stat <- t.test(data[,combins[1,i]],data[,combins[2,i]])
    t_stats[i,1]  <- colnames(data)[combins[1,i]]
    t_stats[i,2]  <- colnames(data)[combins[2,i]]
    t_stats[i,3]  <- t_stat$statistic
    t_stats[i,4]  <- t_stat$parameter
    t_stats[i,5]  <- t_stat$p.value
    t_stats[i,6]  <- t_stat$method
    t_stats[i,7]  <- t_stat$alternative
    t_stats[i,8]  <- t_stat$null.value
    t_stats[i,9]  <- t_stat$conf.int[1]
    t_stats[i,10] <- t_stat$conf.int[2]
    t_stats[i,11] <- t_stat$estimate[1]
    t_stats[i,12] <- t_stat$estimate[2]
}
write.xlsx2(file = "t_stats.xlsx",x = t_stats,sheetName = "1")
cat("\fPlease find results in t_stats.xlsx file")