diet.read<-function(dietfile,mapfile,mapkey){
  #Read in mapping file
  #map <- read.table(mapfile,sep='\t',head=T,row=1,comment='',stringsAsFactors=FALSE)
  map <- openxlsx::read.xlsx(mapfile,sheet = 1)
  
  #Read in diet file  
  dietfile<-ffqfile
  diet<-openxlsx::read.xlsx(dietfile,sheet = 1)
  
  #Read in key for merging
  key<-openxlsx::read.xlsx(mapkey,sheet=1)

  #Merge key with mapping file
  colnames(key)[which(colnames(key)=="Subject.ID")]<-"study_id" #TODO: 
  map.key<-merge(map,key,by="study_id")
  
  #Merge nutrition with mapping file
  map.key$ID_time<-paste(map.key$study_id,"_",map.key$Timepoint,sep="")
  #colnames(diet)<-paste("diet.",colnames(diet),sep="")
  #diet$ID_time<-paste(diet$diet.Study.ID,"_",diet$diet.Timepoint,sep="") #creating a unique variable per sample combining ID and timepoint
  diet$ID_time<-paste(diet$Study.ID,"_",diet$Timepoint,sep="")
  
  diet.map<-merge(map.key,diet,by="ID_time")
  return(diet.map)
}