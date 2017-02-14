#Assigns taxonomy based on user-specified rank
#Returns an otu file with taxa as rownames
#http://statweb.stanford.edu/~susan/Summer11/Labs/Lab1ngs_data_manipulation.pdf

#Inputs
#x: BIOM object with observation metadata
#otu.level: taxonomic rank to annotate OTU file. Options are "genus","family","order","class","phylum". Default is "genus"
assign.taxonomy <- function(x,otu.level){
  taxa<-observation_metadata(x)
  if(is.null(taxa)){
    taxa = colnames(x)
  }
  if (dim(taxa)[1]!=dim(biom_data(x))[1]){
    print ("ERROR: taxonomy should have the same length as the number of columns in the OTU table")
    return;
  }
  
  if(otu.level=="genus"){
    n<-6
  }
  else if(otu.level=="family"){
    n<-5
  }
  else if(otu.level=="order"){
    n<-4
  }
  else if(otu.level=="class"){
    n<-3
  }
  else if(otu.level=="phylum"){
    n<-2
  }
  
  #vec<-vector(length=dim(taxa)[1])
  vec<-taxa[,n]
  

  vec.nam<-gsub(paste0(substr(otu.level,1,1),"__"),replacement = "",x=vec)
  fixNames <- function(x){
    if(x == ""){
      x <- "Unassigned"
    }
    else{
      x
    }
  }
  
  vec.f<-as.vector(unlist(sapply(vec.nam,fixNames)))
  otu<-as.matrix(biom_data(x))
  rownames(otu)<-vec.f
  rownames(otu)<-make.names(vec.f,unique=TRUE)
  return (otu)
}

