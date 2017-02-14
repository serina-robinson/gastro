diet.network<-function(dictfile){
  dict <- read.table(dictfile,sep='\t',head=T,comment='',stringsAsFactors=FALSE)
  diet.dend <- data.frame(dict[,1:2],stringsAsFactors=FALSE)
  diet.igraph<-graph.data.frame(diet.dend,directed = FALSE)
  ceb<-cluster_edge_betweenness(diet.igraph)
  #l <- layout_with_kk(diet.igraph)
  l<-layout_components(diet.igraph)
  #plot(ceb,diet.igraph,vertex.size=2,vertex.shape="none",edge.curved=.1,layout=l)
  
  pdf(file = "output/network.pdf",width=10,height = 10)
  plot(ceb,diet.igraph,vertex.size=0.25,vertex.shape="none",edge.curved=.1,
       layout=l)
  dev.off()
  
  #diet.dend$pathString<-paste("diet",diet.dend$category,diet.dend$label,sep="/")
  #diet.net<-data.tree::as.Node(diet.dend,pathDelimiter="/")
  #diet.igraph<-as.igraph(diet.net, directed = FALSE)
  #ceb<-cluster_edge_betweenness(diet.igraph)
 
  

  
  #plot(as.igraph(diet.net,direction=TRUE,directed="climb"))
  #plot(as.dendrogram(diet.net))
  #diet.network<-data.tree::ToDataFrameNetwork(diet.net)
  #simpleNetwork(diet.network[-3],fontSize=12)
  #plot(as.igraph(diet.net,direction=TRUE,directed="climb"))
  #net <- igraph::graph_from_data_frame(d=diet.network, vertices=diet.network$to, directed=T)
  #plot(net)
  #diet.igraph<-as.igraph(diet.net, directed = TRUE)
  #ceb<-cluster_edge_betweenness(diet.igraph)
  #l <- layout_with_kk(diet.igraph)
  #l<-layout_components(diet.igraph)
  #plot(ceb,diet.igraph,vertex.size=2,vertex.shape="none",edge.curved=.1,layout=l)
  #plot(diet.igraph,layout=l)
}