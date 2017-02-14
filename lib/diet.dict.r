
ffqkeyfile<-"data/keys/VioScreen Export Definition v2 10.pdf"
ffqkey<-pdf_text(ffqkeyfile)
#diet.map<-read.table("data/COMBO/Wu_COMBO_mapping_file.txt",sep = "\t",header=TRUE,comment='',stringsAsFactors=FALSE)
diet.map<-openxlsx::read.xlsx("data/IBS/161006 VioFFQ deidentified.xlsx",sheet = 1)

ffq.categ<-list()
for(i in 1:6){
  x<-ffqkey[i+5]
  x.n<-strsplit(x,"\n")
  x.s<-str_trim(x.n[[1]],side="both")
  x.m<-as.character(unlist(strsplit(x.s,"([ ]{2,})")))
  #x.a<-grep("mg",x.m,ignore.case = TRUE,value = TRUE)
  ffq.categ[[i]]<-list(category=x.m[which(x.m %in% colnames(diet.map))-1],
                       label=x.m[x.m %in% colnames(diet.map)],
                       unit=x.m[which(x.m %in% colnames(diet.map))+2],
                       type=x.m[which(x.m %in% colnames(diet.map))+3])
}


ffq.l<-lapply(ffq.categ,data.frame)
ffq.dat<-data.frame(ffq.l[[1]])

for(i in 2:length(ffq.l)[1]){
  ffq.dat<-rbind(ffq.dat,ffq.l[[i]])
}

#custom label editing
ffq.dat$category<-gsub("Sources","Energy",ffq.dat$category)
ffq.dat$category<-gsub("and Similar","Isoflavones",ffq.dat$category)
ffq.dat$category<-gsub("(polyvols)","Polyvols",ffq.dat$category,fixed=TRUE)
write.table(ffq.dat,"diet.dict.txt",quote = FALSE,sep = "\t",row.names = FALSE,col.names=TRUE)
