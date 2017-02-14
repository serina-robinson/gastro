diet.clust<-function(map,dict){
  map.c<-tolower(colnames(map))
  dict.c<-tolower(dict$label)
  intersect(map.c,dict.c)
  map.ind<-(sapply(1:length(dict.c), function(x) grep(dict.c[x],map.c,fixed=FALSE)))
  matches<-which(lapply(map.ind,length)>0)
  categ<-dict$category[matches]

  list.filt<-map.ind[lapply(map.ind,length)>0]
  names(list.filt) <- categ
  map.el<-unlist(list.filt,use.names = TRUE)

  #get.categ<-dict$category[1:length(dict.c) %in% map.ind]
  #map.c[unlist(map.ind)]
  diet.df<-data.frame(cbind(map.c[unlist(map.ind)],names(map.el)),stringsAsFactors=FALSE)

  colnames(diet.df)<-c("label","category")
  diet.df$category<-gsub("\\d","",diet.df$category)  #remove numeric from category
  diet.df$category<-as.factor(tolower(diet.df$category))
  
  colnames(map)<-tolower(colnames(map))
  map.df<-map[,colnames(map) %in% diet.df$label]
  rownames(map.df)<-map$x.sampleid
  
  return(list(map=map.df,key=diet.df))
}


