# Loads an otu file (taxa or pathway), normalizes the OTU table and returns it
#
#
#Inputs:
# otufile: OTU table in classic format
# normalize: normalizes, transforms, then collapses OTU table; set this to false when working with merged L1,..,L6 taxa files 
# minOTUInSamples: drop OTUs in less than this ratio of samples
# otu.level: taxonomic rank to annotate OTU file. Options are "genus","family","order","class","phylum". Default is "genus"
#
# Returns otu file
load.data<-function(otufile, minOTUInSamples, otu.normalize, otu.level)
{
  #Read in OTU file
  fnlength <- nchar(otufile)
  if(substr(otufile, fnlength-4, fnlength) == ".biom") {
    otu.r <- read_biom(otufile)
    source(paste(Sys.getenv("gastro"),"lib","assign.taxonomy.r",sep="/"))
    otu0 <- assign.taxonomy(x=otu.r, otu.level=otu.level)
  } else {
    line1 <-readLines(otufile,n=1)
    if(line1=="# Constructed from biom file") {
      otu0 <- read.table(otufile,sep='\t',head=T,row=1,comment='',quote="",skip=1)
    } else {
      otu0 <-read.table(otufile,sep='\t',head=T,row=1,comment='',quote="")
    }
  }
  otu <- t(otu0)
  
  if(otu.normalize==TRUE){
    otu <- sweep(otu, 1, rowSums(otu), '/')
    otu <- otu[, colMeans(otu) > minOTUInSamples, drop=FALSE]
    #otu <- asin(sqrt(otu)) #optional normalization 
    #ret <- collapse.by.correlation(otu, .95) #optional collapse of taxa
    #otu <- otu[, ret$reps]
    
  } 
  
  return(otu)
}