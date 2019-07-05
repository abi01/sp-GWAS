### For publication

theme_Publication <- function(base_size=30, base_family="helvetica") {
  library(grid)
  library(ggthemes)
  (theme_foundation(base_size=base_size, base_family=base_family)
    + theme(plot.title = element_text(face = "bold",
                                      size = 25, hjust = 0.5),
            text = element_text(),
            panel.background = element_rect(colour = NA),
            plot.background = element_rect(colour = NA),
            panel.border = element_rect(colour = NA),
            axis.title = element_text(face = "bold",size = rel(1)),
            axis.title.y = element_text(angle=90,vjust =2),
            axis.title.x = element_text(vjust = -0.2),
            axis.text = element_text(), 
            axis.line = element_line(colour="black"),
            axis.ticks = element_line(),
            panel.grid.major = element_line(colour="#f0f0f0"),
            panel.grid.minor = element_blank(),
            legend.key = element_rect(colour = NA),
            legend.position = "bottom",
            legend.direction = "horizontal",
            legend.key.size= unit(0.2, "cm"),
            #legend.margin = unit(0, "cm"),
            legend.margin = margin(t=0, unit = "cm"),
            legend.title = element_blank(),## or element_text(face="italic") for legent
            plot.margin=unit(c(10,5,5,5),"mm"),
            strip.background=element_rect(colour="#f0f0f0",fill="#f0f0f0"),
            strip.text = element_text(face="bold")
    ))
  
}

scale_fill_Publication <- function(...){
  library(scales)
  discrete_scale("fill","Publication",manual_pal(values = c("#386cb0","#fdb462","#7fc97f","#ef3b2c","#662506","#a6cee3","#fb9a99","#984ea3","#ffff33")), ...)
  
}

scale_colour_Publication <- function(...){
  library(scales)
  discrete_scale("colour","Publication",manual_pal(values = c("#386cb0","#fdb462","#7fc97f","#ef3b2c","#662506","#a6cee3","#fb9a99","#984ea3","#ffff33")), ...)
  
}

# ggplot2 library
library(ggplot2)
library(plyr)

merge <- read.delim("C:/Users/Abiskar Gyawali/Desktop/merged.txt", header = T)

### Phenotypic distribution
p <- ggplot(merge, aes(merge$PlantHt)) + geom_density(fill=merge$Taxa)+facet_wrap(~Taxa, ncol = 4)
mu <- ddply(merge, "Taxa",summarise, grp.mean=mean(x = PlantHt, na.rm = T))



s0_1 <- merge[which(merge$Taxa=="Cycle-0-Short1"),] 
s0_2 <- merge[which(merge$Taxa=="Cycle-0-Short2"),]
s1_1 <- merge[which(merge$Taxa=="Cycle-1-Short1"),]
s1_2 <- merge[which(merge$Taxa=="Cycle-1-Short2"),] 
t0_1 <- merge[which(merge$Taxa=="Cycle-0-Tall1"),] 
t0_2 <- merge[which(merge$Taxa=="Cycle-0-Tall2"),] 
t1_1 <- merge[which(merge$Taxa=="Cycle-1-Tall1"),] 
t1_2 <- merge[which(merge$Taxa=="Cycle-1-Tall2"),] 

short0_1 <- quantile(merge$PlantHt[which(merge$Taxa == "Cycle-0-Short1")],c(0.05), na.rm=T)
short1_1 <- quantile(merge$PlantHt[which(merge$Taxa == "Cycle-1-Short1")],c(0.05), na.rm=T)
short0_2 <- quantile(merge$PlantHt[which(merge$Taxa == "Cycle-0-Short2")],c(0.05), na.rm=T)
short1_2 <- quantile(merge$PlantHt[which(merge$Taxa == "Cycle-1-Short2")],c(0.05), na.rm=T)
tall0_1 <- quantile(merge$PlantHt[which(merge$Taxa == "Cycle-0-Tall1")],c(0.95), na.rm=T)
tall0_2 <- quantile(merge$PlantHt[which(merge$Taxa == "Cycle-0-Tall2")],c(0.95), na.rm=T)
tall1_1 <- quantile(merge$PlantHt[which(merge$Taxa == "Cycle-1-Tall1")],c(0.95), na.rm=T)
tall1_2 <- quantile(merge$PlantHt[which(merge$Taxa == "Cycle-1-Tall2")],c(0.95), na.rm=T)


ggplot(merge, aes(x=PlantHt))+ facet_wrap(~Taxa, ncol = 4)+geom_density(color="darkblue", fill="yellow", alpha=0.9 )+geom_vline(data = mu, aes(xintercept=grp.mean), color="blue", linetype="dashed", size=2)+theme_classic()+ 
  geom_vline(data=s0_1, aes(xintercept=short0_1), size=2)+
  geom_vline(data=s0_2, aes(xintercept=short0_2), size=2)+
  #geom_vline(data=s1_1, aes(xintercept=short1_1))+
  #geom_vline(data=s1_2, aes(xintercept=short1_2))+
  geom_vline(data=t0_1, aes(xintercept=tall0_1), size=2)+
  #geom_vline(data=t1_1, aes(xintercept=tall1_1))+
  geom_vline(data=t0_2, aes(xintercept=tall0_2), size=2)+
  #geom_vline(data=t1_2, aes(xintercept=tall1_2))+
  theme_Publication()

d <- data.frame(ggplot_build(p)$data[[1]])

p + geom_area(data = s0_2, aes(d1$x, d1$y), fill="red")


### Manhattan plot and BSA

## Load the manhattan function from BSA_Fig.Rmd
library(gridExtra)
library(qqman)

df1 <- read.csv("C:/Users/Abiskar Gyawali/Desktop/BSA_Tall_short/farmcpu_fdr.csv", header = T)
df2 <- read.delim("C:/Users/Abiskar Gyawali/Desktop/BSA_Tall_short/BSA/ztest_fdr.txt", header = T)
df3 <- read.csv("C:/Abiskar_misc/BeagleImpute/filter/GAPIT..PlantHt.GWAS.Results.csv", header = T)
##p1 <- manhattan.plot(GWAS$CHR, GWAS$BP,pvalue =GWAS$P, col= c("blue4", "orange3"), cex=1.5, sig.level = 1E-05)

##p2 <- manhattan.plot(df$chr, df$Pos,pvalue =df$P_value, col= c("blue4", "orange3"), cex=1.5, sig.level = 1.35E-05)

p1 <- manhattan(df1, main= "A", cex=1.5, cex.axis=0.9, col=c("blue4","orange3"), suggestiveline=F, genomewideline=-log10(1E-05))
p2 <- manhattan(df2, df2$chr, df2$Pos, df2$P_value, main= "B", cex=1.5, cex.axis=0.9, col=c("blue4","orange3"), suggestiveline=F, genomewideline=-log10(0.00423146))
p3 <- manhattan(df3, main="C", cex=1.5, cex.axis=1.7, col=c("blue4","orange3"), suggestiveline=F, genomewideline=-log10(1E-05))
tiff("qqplot.tiff", width = 8, height = 4, units = 'in', res = 300)

grid.arrange(p1, p2, nrow=2)

dev.off()

p3 <- 

##### PCA plot
  

##Do the PCA analysis using pca_script.Rmd

g1 <- ggplot(pca1$scores, aes(pca1$scores[,1], pca1$scores[,2], colour=pop(snp1))) + geom_point()+theme + stat_ellipse() + labs(title="A", x="PC1", y="PC2") + theme(legend.title=element_blank()) + scale_colour_Publication() + theme_Publication()

g2 <- ggplot(pca$scores, aes(pca$scores[,1], pca$scores[,2], colour=pop(snp))) + geom_point()+theme + stat_ellipse() + labs(title="B", x="PC1", y="PC2") + theme(legend.title=element_blank()) + scale_colour_Publication() + theme_Publication()

##save figure
tiff("Plot3.tiff", width = 8, height = 4, units = 'in', res = 300)
grid.arrange(g1, g2, nrow=1)
dev.off()


#### Normal plot
xvalues <- data.frame(x = c(-3, 3))
plot <- ggplot(xvalues, aes(x = xvalues))
plot + stat_function(fun = dnorm) + xlim(c(-4, 4))+ geom_vline(xintercept = -2, linetype="solid", colour="red")



normal_prob_area_plot <- function(lb, ub, mean = 0, sd = 1, limits = c(mean - 3 * sd, mean + 3 * sd)) {
x <- seq(limits[1], limits[2], length.out = 100)
xmin <- max(lb, limits[1])
xmax <- min(ub, limits[2])
areax <- seq(xmin, xmax, length.out = 100)
area <- data.frame(x = areax, ymin = 0, ymax = dnorm(areax, mean = mean, sd = sd))(ggplot() + geom_line(data.frame(x = x, y = dnorm(x, mean = mean, sd = sd)),mapping = aes(x = x, y = y))+ geom_ribbon(data = area, mapping = aes(x = x, ymin = ymin, ymax = ymax)) + scale_x_continuous(limits = limits))
  }



