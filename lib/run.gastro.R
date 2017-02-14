#Wrapper function that runs gastro
#
#Inputs:
#otufile: otu file path
#mapfile: mapping file path
#otu.level:
#otu.normalize:
#diet.collapse:
#diet.normalize:
#
#Outputs:
#list containing a grid of heatmaps and a vector of taxa name
#
#
run.gastro<-function(otufile,mapfile,dictfile,
                     otu.level,
                     otu.collapse,
                     otu.normalize,
                     diet.collapse,
                     diet.normalize) {
  #Read in otu file
  source(paste(Sys.getenv("gastro"),"lib","load.data.r",sep="/"))
  otu<-load.data(otufile,minOTUInSamples = .001, otu.normalize=otu.normalize, otu.level)
  if(otu.collapse==TRUE){
    source(paste(Sys.getenv("gastro"),"lib","collapse.features.r",sep="/"))
    ret <- collapse.by.correlation(otu, .90)
    otu <- otu[, ret$reps]
  }
 
  map<-read.table(mapfile,sep='\t',head=T,comment='',stringsAsFactors=FALSE)
  dict <- read.table(dictfile,sep='\t',head=T,comment='',stringsAsFactors=FALSE)
  
  #Label diet variables by category
  source(paste(Sys.getenv("gastro"),"lib","diet.clust.r",sep="/"))
  res<-diet.clust(map,dict)
  map.t<-res$map[rownames(res$map) %in% rownames(otu),]

  if(diet.normalize==TRUE){
    #diet.clean(map.t)
    #map.t<-scale(map.t)
  }
 
  if (diet.collapse==TRUE){


    #Calculate Spearman correlation between taxa and diet
    source(paste(Sys.getenv("gastro"),"lib","diet.corr.r",sep="/"))
    dat<-diet.corr.long(otu,map.t,method="spearman")
    
    #Appends a column for food category
    dat$Category <- dat$Diet
    for(i in 1:dim(res$key)[1]){
      dat$Category<-gsub(pattern = as.character(res$key$label)[i],
           replacement = as.character(res$key$category)[i],
           x = dat$Category)
    }
  #}
  }
  else if (diet.collapse==FALSE){
    
    #Calculate Spearman correlation between taxa and diet
    source(paste(Sys.getenv("gastro"),"lib","diet.corr.r",sep="/"))
    dat<-diet.corr.long(otu,map.t,method="spearman")
  }

  
  #Reshape the data frame to wide format
  dat.s<-dat[order(dat$AdjPvalue,decreasing = F),c(1,2,3)]
  dat.wide<-reshape(data=dat.s,idvar="Diet",timevar="Taxa",direction="wide") #make wide df
  rownames(dat.wide)<-dat.wide$Diet #make rownames diet variables
  dat.w<-data.frame(dat.wide[complete.cases(dat.wide),2:dim(dat.wide)[2]]) #trim the diet column

  
  #Set col names
  colnames(dat.w)<-gsub("Correlation.","",colnames(dat.w)) 
  #taxavec<-unique(gsub("\\.", "",colnames(dat.w)))
  #taxavec<-unique(gsub("\\[|\\]", "",colnames(dat.w)))
  #taxavec<-taxavec[taxavec!="Unassigned"]
  #dat.f<-as.matrix(dat.w[,colnames(dat.w) %in% taxavec])
  dat.f<-as.matrix(dat.w)
  
  return(list(long=dat,wide=dat.f))
}








