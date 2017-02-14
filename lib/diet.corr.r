diet.corr.long<-function(otu,map,method) {
  x<-as.matrix(otu)
  y<-as.matrix(map)
  
  dat<-NULL 
  for(i in colnames(x)){ #taxa
    for(j in colnames(y)){ #diet clusters
        a<-x[,i,drop=F] #drop=F keeps original object dimensions
        b<-y[,j,drop=F]
        tmp<-c(i,j,cor(a[complete.cases(b),],b[complete.cases(b),],use="everything",method=method),
               cor.test(a[complete.cases(b),],b[complete.cases(b),],method=method)$p.value)
        # creates a dat row: ["Taxa","Diet PC","Correlation","Pvalue"]
        if(is.null(dat)){
          dat<-tmp  
        }
        else{
          dat<-rbind(dat,tmp)
        }    
      }
    }
  
  dat<-data.frame(row.names=NULL,dat,stringsAsFactors=FALSE)
  colnames(dat)<-c("Taxa","Diet","Correlation","Pvalue")
  dat$Pvalue<-as.numeric(as.character(dat$Pvalue))
  dat$AdjPvalue<-rep(0,dim(dat)[1])
  dat$Correlation<-as.numeric(as.character(dat$Correlation))
  
  #Adjust the p-values for FDR (Benjamini & Hochberg, 1995):
  #Code adapted from R code for ecological data analysis by Umer Zeeshan Ijaz
  #http://userweb.eng.gla.ac.uk/umer.ijaz/bioinformatics/ecological.html
  #adjust Diet + Taxa
 
  adjustment_label<-c("AdjDietAndTaxa")
    for(i in unique(dat$Diet)){
      for(j in unique(dat$Taxa)){
        sel<-dat$Diet==i & dat$Taxa==j
        dat$AdjPvalue[sel]<-p.adjust(dat$Pvalue[sel],method="BH")
      }
    }

  #Generate the labels for significant values
  dat$Significance<-cut(dat$AdjPvalue, breaks=c(-Inf, 0.001, 0.01, 0.05, Inf), label=c("***", "**", "*", "")) #converts numeric p-values to factors based on significance level
  return(dat)
}


diet.corr.wide<-function(otu,map,method){
  #mat1<-as.matrix(mat1,dimnames=list(colnames(mat1),colnames(mat2)),rownames.force = TRUE)
  #mat2<-as.matrix(mat2,dimnames=list(colnames(mat1),colnames(mat2)),rownames.force = TRUE)
  mat1<-as.matrix(otu,rownames.force=TRUE)
  mat2<-as.matrix(map,rownames.force=TRUE)
  mat<-t(sapply(1:nrow(mat1), function(x) {
    sapply(1:nrow(mat2), function(y) {
      as.data.frame(rcorr(mat1[x,],mat2[y,],type=method)[[1]][1,2])
    })
  }))
  return(mat)
}
