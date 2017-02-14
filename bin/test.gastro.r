#Run gastro for test files: diet.csv, species.csv
#Serina Robinson
#Last modified February 13, 2017

#Install necessary packages
#source("https://bioconductor.org/biocLite.R")
#biocLite("phyloseq")
#lapply(packs, require, character.only = TRUE)
source("https://bioconductor.org/biocLite.R")
biocLite("phyloseq")
packs<-c("data.table","RColorBrewer","ggplot2","biom","reshape2")
#lapply(packs, install.packages, character.only = TRUE) 
lapply(packs, require, character.only = TRUE) 


#Set environment variable to gastro directory
#setwd("~/Documents/University_of_Minnesota/Knights_Lab/gastro/")
Sys.setenv(gastro=getwd())

#Inputs
otufile<-paste(Sys.getenv("gastro"),"data","test","species.csv",sep="/")
mapfile<-paste(Sys.getenv("gastro"),"data","test","diet.csv",sep="/")
dictfile<-paste(Sys.getenv("gastro"),"data","keys","asa_dict.txt",sep="/")


#Runs gastro pipeline
#Note...computing correlations for large files may take several minutes
source(paste(Sys.getenv("gastro"),"lib","run.gastro.r",sep="/"))
res<-run.gastro(otufile,mapfile,dictfile,
                otu.level="phylum",
                otu.collapse=FALSE,
                otu.normalize=FALSE,
                diet.collapse=FALSE,
                diet.normalize=FALSE)
        
           
#Draw heatmap
source(paste(Sys.getenv("gastro"),"lib","diet.heatmap.r",sep="/"))
diet.heatmap(res,type="heatmap")





