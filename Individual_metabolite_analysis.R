# R script to draw grouped boxplots ---------------------------------------

# library(ggplot2)
# library(ggsignif)
library(readxl)
data <- read_excel("Final_Hyper_ Follow Hyper_MRS_PhD.xlsx", sheet = 1)

# Visualization -----------------------------------------------------------

g1_range <- 1:30
g2_range <- 31:45
g3_range <- 46:76

glu_c <- data$Glu[g1_range]
glu_sch <- data$Glu[g2_range]
glu_hyper <- data$Glu[g3_range]

gln_c <- data$Gln[g1_range]
gln_sch <- data$Gln[g2_range]
gln_hyper <- data$Gln[g3_range]

glu_gln_c <- data$`Glu+Gln`[g1_range]
glu_gln_sch <- data$`Glu+Gln`[g2_range]
glu_gln_hyper <- data$`Glu+Gln`[g3_range]

ins_c <- data$Ins[g1_range]
ins_sch <- data$Ins[g2_range]
ins_hyper <- data$Ins[g3_range]

boxplot(glu_c,gln_c,glu_gln_c,ins_c,
        ylim = c(0,4),xlim = c(0,4),axes=FALSE,
        add = F, boxwex = 0.1, at = 0:3,
        col = "magenta", notch = F,
        ylab = "Metabolite Concentration",main = "")
boxplot(glu_sch,gln_sch,glu_gln_sch,ins_sch,
        add = T, boxwex = 0.1, at = 0:3 + 0.2,axes=FALSE,
        col = "deepskyblue2", notch = F)
boxplot(glu_hyper,gln_hyper,glu_gln_hyper,ins_hyper,
        add = T, boxwex = 0.1, at = 0:3 + 0.4,axes=FALSE,
        col = c("orange"), notch = F)

axis(side = 2, at = seq(0,4.5,0.5))
axis(1, at = c(-0.03,0.98,2,3) + 0.2, labels = c("Glu/tCr","Gln/tCr","(Glu+Gln)/tCr","mI/tCr"))

