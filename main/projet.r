setwd("/users/licence/ixxxxx/LogdeStat/Projet/Salaires universitaires/")

salaires <- read.csv("Salaries.csv",header = TRUE)

library(FactoMineR)

salaires.pca<-PCA(salaires,quali.sup=c(1,2,5),graph = T)
plot.PCA(salaires.pca,axes=c(1,2),choix="ind",habillage=1,col.hab=c("red","blue","green"),label = "none", invisible = "quali")
plot.PCA(salaires.pca,axes=c(1,2),choix="ind",habillage=5,col.hab=c("purple","orange"),label = "none", invisible = "quali")
plot.PCA(salaires.pca,axes=c(1,2),choix="ind",habillage=2,col.hab=c("brown","cyan"),label = "none", invisible = "quali")


salairecc <- salaires[-1]
rank <- salaires[1]
discipline <- salaires[2]
sex <- salaires[5]
salairecc <- salairecc[-1]
salairecc <- salairecc[-3]

scc <- dist(salairecc)
sccl <- hclust(scc)
plot(sccl,labels = sex$X.)
