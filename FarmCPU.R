options(repos="https://cran.cnr.berkeley.edu/")
install.packages("bigmemory")
install.packages("biganalytics")
install.packages("bigmemory.sri")
install.packages("foreach")
install.packages("biglm")
install.packages("DBI")

library("bigmemory")
library("biganalytics")
library("bigmemory.sri")
library("foreach")
library("biglm")
library("DBI")


library("compiler") #this library is already installed in R
source("http://zzlab.net/GAPIT/gapit_functions.txt")
source("http://www.zzlab.net/GAPIT/emma.txt")
source("http://www.zzlab.net/GAPIT/gapit_functions.txt")
source("http://zzlab.net/FarmCPU/FarmCPU_functions.txt")


#Step 1: Set working directory and import data
setwd("C:/Users/Abiskar Gyawali/OneDrive/filter/")


myY <- read.delim("Pheno.txt", head = TRUE) # in case of error use read.delim
myGM <- read.delim("map.txt", head = TRUE)
myGD <- read.big.matrix("GAPIT.Genotype.Numerical.txt", type = "char", sep = "\t", head = TRUE)
myCV <- read.delim("Covariate.txt", header = T)

#Step 2: Run FarmCPU
myFarmCPU <- FarmCPU(
  Y=myY[,c(1,2)],
  GD=myGD,
  GM=myGM,
  CV = myCV[,2,3],
  method.bin = "optimum")
