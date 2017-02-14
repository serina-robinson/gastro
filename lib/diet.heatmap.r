diet.heatmap<-function(res,type){
  dat<-res$long
  dat2<-res$wide
  
  #Prune for significant taxa only (AdjPvalue<0.01)
  dat.c<-dat[complete.cases(dat),]
  taxkeep<-unique(dat.c$Taxa[dat.c$AdjPvalue<0.01])
  #taxassign<-taxkeep[-grep(pattern="Unassigned",taxkeep)] #Remove Unassigned taxa
  taxassign<-taxkeep
  dat.w<-dat.c[dat.c$Taxa %in% taxassign,] 
  
  #Get order of significant taxa
  taxaord<-sort(sapply(taxassign, function(x) { sum(dat.w$Correlation[dat.w$Taxa==x]) }),decreasing=T)
  dat.w$Taxa<-factor(dat.w$Taxa, ordered = T, levels = names(taxaord))
  
  #Shorten taxonomy
  source(paste(Sys.getenv("gastro"),"lib","shorten.taxonomy.r",sep="/"))
  taxa.vec<-shorten.taxonomy(names(taxaord))

  #Make the base heatmap
  source(paste(Sys.getenv("gastro"),"lib","theme.publication.r",sep="/"))
  p <- ggplot(data=dat.w,aes(x=Taxa,y=as.character(Diet))) +
    facet_grid(Category~., drop=TRUE, scales="free_y",space="free",shrink=TRUE,switch="y") +
    theme.publication(taxa.vec) +
    theme(strip.text.y = element_text(size=12, angle = 180, color="black",
                                      face="bold.italic"))+
    labs(x= "Taxa", 
         y= "Diet")
  
  
  if (type=="heatmap") {
    pheat<- p + geom_tile(data = dat.w, aes(fill=Correlation)) +
      scale_fill_gradient2(low="#2C7BB6", mid="white", high="#D7191C")
      #geom_text(data = dat.w, aes(label=Significance), color="black", size=5)
      
    pdf(file="output/heatmap.pdf", width=15, height=15)
    plot.new()
    par(mar=c(0.1,0.1,0.1,0.1))
    print(pheat)
    legend(x=0.9,y=1.0,legend=levels(as.factor(taxa.vec)), 
           #fill=c("#E41A1C","#FF7F00","#4DAF4A","#377EB8","#A65628","#6E6E6E"),
           #fill = colorRampPalette(rainbow(9))(length(levels(as.factor(taxa.vec)))),
           fill = colorRampPalette(brewer.pal(9,"Spectral"))(length(levels(as.factor(taxa.vec)))),
           border=FALSE, bty="n", title = "Taxa")
    dev.off()
  }
  
  if (type=="bubble") {
    pbubb<- p + geom_point(data = dat.w, aes(colour = Correlation,  size = abs(Correlation))) +
      scale_color_gradient2(low="#2C7BB6", mid="white", high="#D7191C") + 
      scale_size(range = c(3,5))
    
    pdf(file="output/bubble.pdf", width=15, height=15)
    plot.new()
    par(mar=c(0.1,0.1,0.1,0.1))
    print(pbubb)
    legend(x=0.9,y=1.0,legend=levels(as.factor(taxa.vec)), 
           #fill=c("#E41A1C","#FF7F00","#4DAF4A","#377EB8","#A65628","#6E6E6E"),
           fill = colorRampPalette(brewer.pal(8,"Spectral"))(length(levels(as.factor(taxa.vec)))),
           border=FALSE, bty="n", title = "Taxa")
    dev.off()
  } 
}
