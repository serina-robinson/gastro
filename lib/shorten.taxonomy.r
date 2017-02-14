shorten.taxonomy <- function(ids){
  newids <- ids
  ids <- strsplit(ids,".",fixed=TRUE)
  for(i in seq_along(ids)){
    n <- length(ids[[i]])
    if (n==1){
      newids[i]<-ids[[i]][1]
    }
    else if(n>2){
      newids[i]<-ids[[i]][n-2]
    }
    else{
      if(ids[[i]][n-1]=="X"){
        newids[i] <- ids[[i]][n]
      }
      else{
        newids[i] <- ids[[i]][n-1]
      }
    }
  }
  return(newids)
}


