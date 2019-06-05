library(xlsx)
cat('\f')
rm(list=ls())
of <- "MRS_data.xlsx"
cat("Generating a sample dataset. File name :",of)
sheets <- floor(runif(1, min=2, max=5))
fill <- function(){
metabolites <- floor(runif(1, min=3, max=10))
groups <- floor(runif(1, min=2, max=6))
records <- floor(runif(1, min=30, max=60))
data <- matrix(nrow = records,ncol = metabolites+1)
# Add random values for each metabolite
for(i in 2:metabolites){
    data[,i] <- rnorm(records,50,10) # Populate random metabolite concentration
}
# Add random group names
for(i in 1:records){
    data[i,1] <- i # Subject ID no
    data[i,ncol(data)] <- floor(runif(1,min=1, max=groups)) # Subject group category
}
# Add header to dataset
for(i in 2:ncol(data)-1){
    data[1,1] <- 1
}
colnames(data) <- seq(1,ncol(data),1)
return(data)
}
if(file.exists(of))
    file.remove(of)
for(i in 1:sheets){
    write.xlsx(data <- fill(), file = of, sheetName = stringr::str_glue("Sheet",toString(i)), col.names = T, row.names = F, append = T)
}
hist(data[,3])
boxplot(data[,3])
cat("\fData file is now available. Filename :",of)