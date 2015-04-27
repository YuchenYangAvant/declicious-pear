update_csv_upload_dropbox <- function(ticker2, days2=days, dir2=dir,dir_test='/pairs_trading/raw_data') {
  read.csv(paste0(dir2,ticker2,'.csv'))->bla
  
  fetch_historical_data(days = days2,real_flag = F,ticker = ticker2)->bla2
  
  bla3<-rbind(bla2,bla)
  
  bla3<-bla3[!duplicated(bla3$d),]
  
  bla3<-bla3[order(as.numeric(bla3$d)),]
  
  write.csv(bla3,paste0(dir2,ticker2,'.csv'),row.names=F) 
 
  library(rdrop2)

  drop_upload(file=paste0(dir2,ticker2,'.csv'),dest=dir_test)

}
