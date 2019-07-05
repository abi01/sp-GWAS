### This script to estimate BLUPs for shoepeg

### Read data
phenos <- read.table("C:\\Users\\Abiskar Gyawali\\Documents\\Rcode\\2016_shoepeg_no imputation\\2016_shoepeg_phenos.txt",header=T,stringsAsFactors=F)
Loc <- unlist(strsplit(phenos$Taxa,split="_"))
Loc <- unlist(strsplit(phenos$Taxa,split="_"))[seq(1,1152,3)]
phenos2 <- cbind(phenos,Loc)

### make LM
lm.ph <- lm(phenos2$PlantHt~phenos2$Loc)
predict(lm.ph)

### Calculate residuals
predict.ph <- predict(lm.ph,newdata=phenos2)
resid.ph <- phenos2$PlantHt-predict.ph

plot(resid.ph)

### Add residuals to phenos
phenos3 <- cbind(phenos2,resid.ph)

## Export the file
write.csv(phenos3, "residuals.txt")
