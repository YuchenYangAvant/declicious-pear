
upload_to_dropbox <- function (dir = '~/Documents/trading/',dir_dest='/pairs_trading/raw_data',overwrite=T, stocklist='all_stock'){
  
  library(rdrop2)
  
  if(stocklist == 'all_stock'){
    stock_list<- read.csv(paste0(dir,'active_nyse_380_5d.csv'))
    stock_list<-rbind(stock_list,read.csv(paste0(dir,'active_nas_380_5d.csv')))
    
  }else{
    stock_list<-as.data.frame(stocklist)
  }
  names(stock_list)<- c('ticker')
  

  invisible(lapply(as.character(stock_list$ticker), function (x) drop_upload(file=paste0(dir,x,'.csv'),dest =dir_dest,overwrite = overwrite)))           
  
}




