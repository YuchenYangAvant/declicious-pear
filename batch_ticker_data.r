batch_ticker_data <- function (days,dir = '~/Documents/trading/',type='update'){
  
  stock_list<- read.csv(paste0(dir,'active_nyse_380_5d.csv'))
  stock_list<-rbind(stock_list,read.csv(paste0(dir,'active_nas_380_5d.csv')))
  
  names(stock_list) <- c('ticker')
  
  if (type %in% c('update','create')==F)
  {stop('type should be either update or create')}
  
  if(type=='update'){
  update_csv <- function(ticker2, days2=days, dir2=dir) {
    read.csv(paste0(dir2,ticker2,'.csv'))->bla
    
    fetch_historical_data(days = days2,real_flag = F,ticker = ticker2)->bla2
    
    bla3<-rbind(bla2,bla)
    
    bla3<-bla3[!duplicated(bla3$d),]
    
    write.csv(bla3,paste0(dir2,ticker2,'.csv'),row.names=F)
  }
  invisible(lapply(stock_list, function (x) update_csv(x,days2 = days,dir2 = dir)))
  }else {
    invisible(lapply(as.character(stock_list$ticker), function (x) 
      write.csv(fetch_historical_data(days = days,real_flag = F,ticker = x),
                 paste0(dir,x,'.csv'),row.names=F)))
  }
}
  
  


