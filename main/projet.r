setwd("/users/licence/il04062/LdS/Projet/")
getwd

salaires <- read.csv("Salaries.csv",header = TRUE)
salaires$sex <- as.numeric(factor(salaires$sex)) #female=1 et male=2
salaires$rank <- as.numeric(factor(salaires$rank))                        
salaires$discipline <- as.numeric(factor(salaires$discipline))                             

c<-c()         
for (i in 1:6){c<-c(c,var(salaires[,i]))} #variances

#renormalisation des données
salaires$rank <- (salaires$rank-mean(salaires$rank))/sd(salaires$rank)
salaires$discipline <- (salaires$discipline-mean(salaires$discipline))/sd(salaires$discipline)
salaires$yrs.since.phd <- (salaires$yrs.since.phd-mean(salaires$yrs.since.phd))/sd(salaires$yrs.since.phd)
salaires$yrs.service <- (salaires$yrs.service-mean(salaires$yrs.service))/sd(salaires$yrs.service)
salaires$sex <- (salaires$sex-mean(salaires$sex))/sd(salaires$sex)
salaires$salary <- (salaires$salary-mean(salaires$salary))/sd(salaires$salary)

correlation <- cor(salaires) #correlation

a=svd(correlation)
val_propres = unlist(a[1])
vect_propres = matrix(unlist(a[2]),397,6) 

qlte_rep <- c() #qualité de representation p/r à plusieurs axes
for (i in 1:6){
  qlte_rep = cumsum(val_propres)/6}
