
#Install packages (Do this section only for new installation of R)
#-------------------------------------------------------------------------------
source("http://www.bioconductor.org/biocLite.R") 
biocLite("multtest")
install.packages("gplots")
install.packages("LDheatmap")
install.packages("genetics")
install.packages("ape")
install.packages("EMMREML")
install.packages("scatterplot3d")

#Step 0: Import library and GAPIT functions run this section each time to start R)
#######################################################################################
library(multtest)
library(gplots)
library(LDheatmap)
library(genetics)
library(ape)
library(EMMREML)
library(compiler) #this library is already installed in R
library("scatterplot3d")

source("http://www.zzlab.net/GAPIT/emma.txt")
source("http://www.zzlab.net/GAPIT/gapit_functions.txt")

#source("/Users/Zhiwu/Dropbox/Current/revolutionr/gapit/gapit_functions.txt")
#############################################################################################

#download tutorial data and save them in myGAPIT directory under C drive and  run tutorials
setwd("C:\\Users\\Abiskar Gyawali\\Desktop\\Heavy Filtering\\Heavy Filtering\\merged\\17_split/")

#### Convert Hapmap data to Numerical 
myG <- read.delim("Genotype.hmp.txt", head = FALSE)
myGAPIT <- GAPIT(G=myG, output.numerical=TRUE)


#Tutorial 1: Basic Scenario of Compressed MLM by Zhang and et. al. (Nature Genetics, 2010) 
#----------------------------------------------------------------------------------------
#Step 1: Set data directory and import files
myY  <- read.table("Merge_residuals.txt", head = TRUE)
myG <- read.delim("Merged_Bialllelic.hmp.txt", head = FALSE)
myCV <- read.delim("Covariate.txt", head= TRUE)

#Step 2: Run GAPIT
myGAPIT <- GAPIT(
  Y=myY,
  G=myG,
  CV = myCV,
  SNP.MAF = 0.05)

