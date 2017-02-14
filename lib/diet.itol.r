diet.itol<-function(res){
  dat<-res$long

  #Prune for significant taxa only (AdjPvalue<0.01)
  dat.c<-dat[complete.cases(dat),]
  taxkeep<-unique(dat.c$Taxa[dat.c$AdjPvalue<0.01])
  taxassign<-taxkeep[-grep(pattern="Unassigned",taxkeep)] #Remove Unassigned taxa
  dat.w<-dat.c[dat.c$Taxa %in% taxassign,] 
  
  #Get spearman correlation with diet categories using data.table package
  dat.f<-data.table(dat.w)
  dat.g<-dat.f[,Average_Corr:=mean(Correlation),by=list(Taxa,Category)]
  dat.g$Average_Corr<-round(dat.g$Average_Corr,3)
  dat.g<-data.frame(dat.g)
  dat.h<-t(data.frame(reshape(data=dat.g[,c(1,7,8)],idvar="Category",timevar="Taxa",direction="wide")))
  
  #dat.g$Taxa<-shorten.taxonomy(dat.g$Taxa)
  #dat.h<-t(data.frame(reshape(data=dat.g,idvar="Category",timevar="Taxa",direction="wide")))
  
  #Shorten taxonomy
  source(paste(Sys.getenv("gastro"),"lib","shorten.taxonomy.r",sep="/"))
  dat.tax<-shorten.taxonomy(gsub("Average_Corr.",replacement = "",rownames(dat.h)))
  dat.write<-cbind(dat.tax,dat.h)
  print(head(dat.write))
  dat.write[1,1]<-"#ID1"

  #read in iTOL file
  itolfile<-paste(Sys.getenv("gastro"),"data","keys","tol_heatmap_template.txt",sep="/")
  tf <- itolfile; tf2 <- paste(Sys.getenv("gastro"),"output","tol_heatmap_annot.txt",sep="/")

  fr <- file(tf, open="rt") #open file connection to read

  text<-readLines(fr)
  stopfields<-grep("FIELD_LABELS",text,fixed=TRUE)
  stopdat<-grep("Actual data follows after",text,fixed=TRUE) #detect the row for data
  close(fr)
  
  fr <- file(tf, open="rt")
  fw <- file(tf2, open="wt") #open file connection to write 
  text1<-readLines(fr,n=stopfields)
  writeLines(text1,fw)
  writeLines(paste(dat.write[1,],collapse="\t"),fw)
  text2<-readLines(fr,n=stopdat)
  writeLines(text2,fw)
  writeLines("#=================================================================#",fw)
  writeLines("DATA",fw)
  for(i in 1:ncol(dat.write)){
    tow<-paste(dat.write[i,],sep="\n",collapse="\t")
    writeLines(tow,fw)
  }
  close(fr);close(fw) 
}

