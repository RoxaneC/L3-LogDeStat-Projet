setwd("/users/licence/il04062/LdS/Projet/")
getwd

salaires <- read.csv("Salaries.csv",header = TRUE)
salaires$sex <- as.numeric(factor(salaires$sex)) #female=1 et male=2
salaires$rank <- as.numeric(factor(salaires$rank))                        
salaires$discipline <- as.numeric(factor(salaires$discipline))                             

v<-c()         
for (i in 1:6){v<-c(v,var(salaires[,i]))} #variances

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
vect_propres = matrix(unlist(a[3]),6,6) 

qlte_rep_par_var<-matrix(0,6,6)
for (i in 1:6){
  for (j in 1:6){
    qlte_rep_par_var[i,j]<-(vect_propres[i,j])^2
  }
}

qlte_rep <- c() #qualité de representation p/r à plusieurs axes
for (i in 1:6){
  qlte_rep = cumsum(val_propres)/6} #3 axes nécessaires

#Cercle des corrélations
nom=c('r','d','yp','ys','sx','sl')
plot(vect_propres[,1], vect_propres[,2], asp = 1, xlim = c(-1, 1),ylim=c(-1,1),type='n')
text(vect_propres[,1], vect_propres[,2],nom)
abline(v=0,h=0)
symbols(0,0,circles=0.7, inches=F, add=T)
symbols(0,0,circles=1, inches=F, add=T)

#Représentation des variables
