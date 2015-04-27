dir = '~/Documents/trading/'
stock_list<- read.csv(paste0(dir,'active_nyse_380_5d.csv'))
stock_list<-rbind(stock_list,read.csv(paste0(dir,'active_nas_380_5d.csv')))


sapply(stock_list$x,function(x) dim(read.csv(paste0(dir,x,'.csv')))[1]) -> length_each_stock
stock_list$dim1 <- length_each_stock
