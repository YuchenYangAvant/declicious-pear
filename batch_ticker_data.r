batch_ticker_data <- function (days,dir = '~/Documents/trading/',type='update', stocklist='all_stock', upload=F)
{
  if(stocklist == 'all_stock'){
  stock_list<- read.csv(paste0(dir,'active_nyse_380_5d.csv'))
  stock_list<-rbind(stock_list,read.csv(paste0(dir,'active_nas_380_5d.csv')))
  
  }else{
    stock_list<-as.data.frame(stocklist)
  }
  names(stock_list)<- c('ticker')
  
  source('~/dev/delicious-pear/fetch_data.r')
  
  if (type %in% c('update','create')==F)
  {stop('type should be either update or create')}
  
  if(upload==T){function_x <- source('~/dev/delicious-pear/update_csv_upload_dropbox.r')$value}
  else{function_x <- source('~/dev/delicious-pear/update_csv.r')$value}

  if(type=='update'){
    
  invisible(lapply(stock_list$ticker, function (x) function_x(x,days2 = days,dir2 = dir)))
  }else {
    invisible(lapply(as.character(stock_list$ticker), function (x) 
      write.csv(fetch_historical_data(days = days,real_flag = F,ticker = x),
                 paste0(dir,x,'.csv'),row.names=F)))
  }
}
  
  


