##Analyzing phenotypes Cycle 1_2017

setwd("C:\\Users\\Abiskar Gyawali\\OneDrive\\PhD_Mizzou\\Tim's lab\\Shoepeg_GWAS\\Cycle_1")
Roll_Tall_2 <- read.delim("Rollins_Tall_2.txt",header=T,stringsAsFactors=F,sep="\t")
Gen_Short_2 <- read.delim("Genetics_Pinetree_Short_2.txt",header=T,stringsAsFactors=F,sep="\t")
VH_Short_1 <- read.delim("VinyardHighland_Short_1.txt",header=T,stringsAsFactors=F,sep="\t")
VL_Tall_1 <- read.delim("VinyardLowland_Tall_1.txt",header=T,stringsAsFactors=F,sep="\t")

##histogram of phenotypes
## Rollins_Tall_2
hist(Roll_Tall_2$PlantHt, main = "Roll_Tall_2 Plant Heights", xlab = "Plant Height")
hist(Roll_Tall_2$EarHt, main = "Roll_Tall_2 Ear Heights", xlab = "Ear Height")
hist(Roll_Tall_2$EarNumber, main = "Roll_Tall_2 Ear Number", xlab = "Ear Number")
hist(Roll_Tall_2$Tillers, main = "Roll_Tall_2 Tillers", xlab = "Tillers")
hist(Roll_Tall_2$NodeNumber, main = "Roll_Tall_2 Node Number", xlab = "Node Number")
hist(Roll_Tall_2$EarPosition, main = "Roll_Tall_2 Ear Position", xlab = "Ear Position")

## Genetics_PineTree_Short_2
hist(Gen_Short_2$PlantHt, main = "Gen_Short_2 Plant Heights", xlab = "Plant Height")
hist(Gen_Short_2$EarHt, main = "Gen_Short_2 Ear Heights", xlab = "Ear Height")
hist(Gen_Short_2$EarNumber, main = "Gen_Short_2 Ear Number", xlab = "Ear Number")
hist(Gen_Short_2$Tillers, main = "Gen_Short_2 Tillers", xlab = "Tillers")
hist(Gen_Short_2$NodeNumber, main = "Gen_Short_2 Node Number", xlab = "Node Number")
hist(Gen_Short_2$EarPosition, main = "Gen_Short_2 Ear Position", xlab = "Ear Position")

## Vinyard_Highland_Short_1
hist(VH_Short_1$PlantHt, main = "VH_Short_1 Plant Heights", xlab = "Plant Height")
hist(VH_Short_1$EarHt, main = "VH_Short_1 Ear Heights", xlab = "Ear Height")
hist(VH_Short_1$EarNumber, main = "VH_Short_1 Ear Number", xlab = "Ear Number")
hist(VH_Short_1$Tillers, main = "VH_Short_1 Tillers", xlab = "Tillers")
hist(VH_Short_1$NodeNumber, main = "VH_Short_1 Node Number", xlab = "Node Number")
hist(VH_Short_1$EarPosition, main = "VH_Short_1 Ear Position", xlab = "Ear Position")

## Vinyard_Lowland_Tall_1
hist(VL_Tall_1$PlantHt, main = "VL_Tall_1 Plant Heights", xlab = "Plant Height")
hist(VL_Tall_1$EarHt, main = "VL_Tall_1 Ear Heights", xlab = "Ear Height")
hist(VL_Tall_1$EarNumber, main = "VL_Tall_1 Ear Number", xlab = "Ear Number")
hist(VL_Tall_1$Tillers, main = "VL_Tall_1 Tillers", xlab = "Tillers")
hist(VL_Tall_1$NodeNumber, main = "VL_Tall_1 Node Number", xlab = "Node Number")
hist(VL_Tall_1$EarPosition, main = "VL_Tall_1 Ear Position", xlab = "Ear Position")


###truncation point for selection
quantile(Roll_Tall_2$PlantHt,c(0.05, 0.95), na.rm=T)
quantile(Gen_Short_2$PlantHt,c(0.05, 0.95), na.rm=T)
quantile(VH_Short_1$PlantHt,c(0.05, 0.95), na.rm=T)
quantile(VL_Tall_1$PlantHt,c(0.05, 0.95), na.rm=T)


hist(Roll_Tall_2$PlantHt, main="Rollins: Tall2; \n Plant Heights > 228.6cm",xlab="Plant Height")
abline(v=quantile(Roll_Tall_2$PlantHt,c(0.95), na.rm=T), col="red", lwd=3)
arrows(230,16,235,16,length=0.1,col="red",lwd=2)


hist(Gen_Short_2$PlantHt, main="Genetics_PineTree: Short2; \n Plant Heights < 143.5cm",xlab="Plant Height")
abline(v=quantile(Gen_Short_2$PlantHt,c(0.05), na.rm=T), col="red", lwd=3)
arrows(141,16,136,16,length=0.1,col="red",lwd=2)

hist(VH_Short_1$PlantHt, main="Vinyards_Highland: Short1; \n Plant Heights < 138.75cm",xlab="Plant Height")
abline(v=quantile(VH_Short_1$PlantHt,c(0.05), na.rm=T), col="red", lwd=3)
arrows(136,16,131,16,length=0.1,col="red",lwd=2)

hist(VL_Tall_1$PlantHt, main="Vinyards_Lowland: Tall1; \n Plant Heights > 235cm",xlab="Plant Height")
abline(v=quantile(VL_Tall_1$PlantHt,c(0.95), na.rm=T), col="red", lwd=3)
arrows(237,16,242,16,length=0.1,col="red",lwd=2)







