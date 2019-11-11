setwd("/home/agr75/data/R/")
newmbf = read.delim("Combined_Freq.txt", header=T)
lengths = read.table("/home/agr75/data/analysis/merged/Genotypes/BSA/Imputed/sizes.genome", header=T)
consec_pos = matrix(nrow=length(newmbf[,1]), ncol=1)
consec_pos[(which(newmbf[,1] == "1")),] = newmbf[which(newmbf[,1] == "1"),2]

for(i in 2:10){
  chromo=paste(i,sep="")
  consec_pos[(which(newmbf[,1] ==chromo)),] =
    (newmbf[(which(newmbf[,1] == chromo)),2]) + (lengths[(i-1),3])
}

newmbf = cbind(newmbf, consec_pos)

colnames(newmbf)
mbfPH <- newmbf[,c(1,2,4,5,7,8,10,11,15,16,18,19,20)]

mbfPH <- mbfPH[-(which((mbfPH[,5]+mbfPH[,7])<40)),]
mbfPH <- mbfPH[-(which((mbfPH[,9]+mbfPH[,11])<40)),]

mbfPH <- mbfPH[order(mbfPH[,"consec_pos"], decreasing=F),]

install.packages("zoo")
library(zoo)

ztest_ph = matrix(nrow=length(mbfPH[,1]), ncol = 14)
colnames(ztest_ph) = c("Pos","B73.Freq.Diff","count1","count2","sample1",
                       "sample2","p_hat","Z","Avg_Z","testable_z", "P_value", "-log10(P_value)","chr","consec")
colnames(ztest_ph)
colnames(mbfPH)
ztest_ph[,1] = mbfPH[,2]
ztest_ph[,2] = mbfPH[,6]-mbfPH[,10]
ztest_ph[,3] = mbfPH[,5]
ztest_ph[,4] = mbfPH[,9]
ztest_ph[,5] = mbfPH[,5]+mbfPH[,7]
ztest_ph[,6] = mbfPH[,9]+mbfPH[,11]
ztest_ph[,7] = ((ztest_ph[,"count1"]+ztest_ph[,"count2"])/(ztest_ph[,"sample1"]+ztest_ph[,"sample2"]))
ztest_ph[,8] = (ztest_ph[,2])/(sqrt((ztest_ph[,7])*(1-(ztest_ph[,7]))*((1/ztest_ph[,"sample1"])+(1/ztest_ph[,"sample2"]))))
ztest_ph[(which(mbfPH[,1]=="1")),9]=rollapply(data=as.numeric(ztest_ph[(which(mbfPH[,1]=="1")),8]), width=15, FUN=mean, fill=NA)
ztest_ph[(which(mbfPH[,1]=="2")),9]=rollapply(data=as.numeric(ztest_ph[(which(mbfPH[,1]=="2")),8]), width=15, FUN=mean, fill=NA)
ztest_ph[(which(mbfPH[,1]=="3")),9]=rollapply(data=as.numeric(ztest_ph[(which(mbfPH[,1]=="3")),8]), width=15, FUN=mean, fill=NA)
ztest_ph[(which(mbfPH[,1]=="4")),9]=rollapply(data=as.numeric(ztest_ph[(which(mbfPH[,1]=="4")),8]), width=15, FUN=mean, fill=NA)
ztest_ph[(which(mbfPH[,1]=="5")),9]=rollapply(data=as.numeric(ztest_ph[(which(mbfPH[,1]=="5")),8]), width=15, FUN=mean, fill=NA)
ztest_ph[(which(mbfPH[,1]=="6")),9]=rollapply(data=as.numeric(ztest_ph[(which(mbfPH[,1]=="6")),8]), width=15, FUN=mean, fill=NA)
ztest_ph[(which(mbfPH[,1]=="7")),9]=rollapply(data=as.numeric(ztest_ph[(which(mbfPH[,1]=="7")),8]), width=15, FUN=mean, fill=NA)
ztest_ph[(which(mbfPH[,1]=="8")),9]=rollapply(data=as.numeric(ztest_ph[(which(mbfPH[,1]=="8")),8]), width=15, FUN=mean, fill=NA)
ztest_ph[(which(mbfPH[,1]=="9")),9]=rollapply(data=as.numeric(ztest_ph[(which(mbfPH[,1]=="9")),8]), width=15, FUN=mean, fill=NA)
ztest_ph[(which(mbfPH[,1]=="10")),9]=rollapply(data=as.numeric(ztest_ph[(which(mbfPH[,1]=="10")),8]), width=15, FUN=mean, fill=NA)

ztest_ph[,10] =-(abs(ztest_ph[,9]))
ztest_ph[,11] = 2*(pnorm(ztest_ph[,10],mean=0,sd=1))
ztest_ph[,12] =-(log10(ztest_ph[,11]))
ztest_ph[,13] = as.character(mbfPH[,1])
ztest_ph[,14] = mbfPH[,15]

for(z in 2:length(ph_regions[,1])) {
  if((as.numeric(ph_regions[z,"consec"])-as.numeric(ph_regions[(z-1),"consec"])) > (5*10^6)) {
   peaks=c(peaks,(peaks[(z-1)]+1))
   }
   if((as.numeric(ph_regions[z,"consec"])-as.numeric(ph_regions[(z-1),"consec"])) <= (5*10^6)) {
   peaks=c(peaks,(peaks[(z-1)]))
   }
 }
