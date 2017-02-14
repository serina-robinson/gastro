phylo.tree<-function(res){
  #Get phylogenetic information
  dat<-res$long

  #Prune for significant taxa only (AdjPvalue<0.01)
  dat.c<-dat[complete.cases(dat),]
  taxkeep<-unique(dat.c$Taxa[dat.c$AdjPvalue<0.01])
  taxassign<-taxkeep[-grep(pattern="Unassigned",taxkeep)] #Remove Unassigned taxa
  dat.w<-dat.c[dat.c$Taxa %in% taxassign,] 
  
  #Get order of significant taxa
  #taxaord<-sort(sapply(taxassign, function(x) { sum(dat.w$Correlation[dat.w$Taxa==x]) }),decreasing=T)
  #dat.w$Taxa<-factor(dat.w$Taxa, ordered = T, levels = names(taxaord))
  
  #Shorten taxonomy
  source(paste(Sys.getenv("gastro"),"lib","shorten.taxonomy.r",sep="/"))
  taxa.vec<-shorten.taxonomy(names(taxassign))
  
  write.table(taxa.vec,file = "output/taxonomy.txt",row.names = FALSE,col.names = FALSE,quote = FALSE)
}