#Run file for COMBO diet + microbiome data (Wu et al., 2011, Science)
#Serina Robinson
#Last modified February 14, 2017

#Install necessary packages
packs<-c("biom","ggplot2","RColorBrewer","ggthemes")
#lapply(packs, install.packages, character.only = TRUE)
lapply(packs, require, character.only = TRUE) 

#Set environment variable to gastro directory
setwd("~/Documents/gastro/")
Sys.setenv(gastro=getwd())

#Inputs
otufile<-paste(Sys.getenv("gastro"),"data","COMBO","Wu_COMBO.biom",sep="/")
mapfile<-paste(Sys.getenv("gastro"),"data","COMBO","Wu_COMBO_mapping_file.txt",sep="/")
dictfile<-paste(Sys.getenv("gastro"),"data","keys","ffq_dict.txt",sep="/")

#Runs gastro pipeline
#Note...computing correlations for large files may take several minutes
#Will receive the following warning: Cannot compute exact p-value with ties
#Indicates there are "ties" in the 
source(paste(Sys.getenv("gastro"),"lib","run.gastro.r",sep="/"))
res<-run.gastro(otufile,mapfile,dictfile,
                otu.level="genus",
                otu.collapse=TRUE,
                otu.normalize=TRUE,
                diet.collapse=TRUE,
                diet.normalize=TRUE)


#Heatmap
source(paste(Sys.getenv("gastro"),"lib","diet.heatmap.r",sep="/"))
diet.heatmap(res,type="heatmap")

#Bubble map
source(paste(Sys.getenv("gastro"),"lib","diet.heatmap.r",sep="/"))
diet.heatmap(res,type="bubble")


