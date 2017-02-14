#Run file for COMBO diet + microbiome data (Wu et al., 2011, Science)
#Serina Robinson
#Last modified November 11, 2016

#Install necessary packages
#source("https://bioconductor.org/biocLite.R")
#biocLite("phyloseq")
packs <- c("ggthemes","Hmisc","RColorBrewer","ggplot2","openxlsx",
           "phyloseq","pdftools","biom","stringr","reshape2","data.table") 
#lapply(packs, install.packages, character.only = TRUE) 
lapply(packs, require, character.only = TRUE) 

#Set environment variable to gastro bin directory
#setwd("~/Dropbox/University_of_Minnesota/Knights_Lab/gastro/")
Sys.setenv(gastro=getwd())

#Inputs
otufile<-paste(Sys.getenv("gastro"),"data","COMBO","Wu_COMBO.biom",sep="/")
mapfile<-paste(Sys.getenv("gastro"),"data","COMBO","Wu_COMBO_mapping_file.txt",sep="/")
dictfile<-paste(Sys.getenv("gastro"),"data","keys","diet.dict.txt",sep="/")

#Runs gastro pipeline
#Note...computing correlations for large files may take several minutes
source(paste(Sys.getenv("gastro"),"lib","run.gastro.r",sep="/"))
res<-run.gastro(otufile,mapfile,dictfile,
                otu.level="phylum",
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

#Phylogenetic tree + heatmap
#Outputs Interactive Tree of Life (iTOL) annotation file format

#Taxonomy file which can be uploaded to phyloT tree (http://phylot.biobyte.de/)
#Click the "Visualization in iTOL" link to be taken to iTOL site
#source(paste(Sys.getenv("gastro"),"lib","phylo.tree.r",sep="/"))
#phylo.tree(res) #writes taxonomy to a output file "taxonomy.txt"

#Heatmap annotation file for visualization in iTOL
#source(paste(Sys.getenv("gastro"),"lib","diet.itol.r",sep="/"))
#diet.itol(res)

