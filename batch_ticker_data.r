batch_ticker_data <- function (days,dir = '~/Documents/trading/'){
  
  stock_list<- read.csv(paste0(dir,'active_nasdaq_370.csv'))
  stock_list<-rbind(stock_list,read.csv(paste0(dir,'active_nyse_380.csv')))
  
  names(stock_list) <- c('ticker')
  
  invisible( lapply(stock_list3,function(x) 
    write.csv(fetch_historical_data(days = days,real_flag = F,ticker = x),
              paste0(dir,x,'.csv'),row.names=F)))
  
  
}

