#' diet.clean
#' Flags nutrient outliers using cutpoints from 5th and 95th percentile of intakes from NHANES data
#'
#

diet.clean <-function(x,to.rem=TRUE) {
    x$Gender<-toupper(x$Gender)
    LL<-list()
    #KCAL outliers
    LL$kcal.outlier<-c(which((x$KCAL< 600 | x$KCAL > 4400) & x$Gender=="F"),
                       which((x$KCAL < 650 | x$KCAL > 5700) & x$Gender=="M"))
    #PROT outliers
    LL$prot.outlier<-c(which((x$PROT< 10 | x$PROT > 180) & x$Gender=="F"),
                       which((x$PROT < 25 | x$PROT > 240) & x$Gender=="M"))
    #TFAT outliers
    LL$tfat.outlier<-c(which((x$TFAT< 15 | x$TFAT > 185) & x$Gender=="F"),
                       which((x$TFAT < 25 | x$TFAT > 230) & x$Gender=="M"))
    #VC outliers
    LL$vc.outlier<-c(which((x$VC< 5 | x$VC > 350) & x$Gender=="F"),
                     which((x$VC < 5 | x$VC > 400) & x$Gender=="M"))
    #BCAR outliers
    LL$bcar.outlier<-c(which((x$BCAR< 15 | x$BCAR > 7100) & x$Gender=="F"),
                       which((x$BCAR < 15 | x$BCAR > 8200) & x$Gender=="M"))
    
    if(to.rem==TRUE){
      x.clean<-x[-to.rem$tfat.outlier,] #removing total fat outliers
    }
    return(LL)
}




  