source('~/dev/delicious-pear/fetch_data.r')
read.csv('~/Documents/trading/active_nasdaq_370.csv')->nas
lapply(nas$x,function(x) dim(tryCatch({fetch_historical_data(days = 5,ticker = x)}, error=function(e){}))[1])->nrow_nas
lapply(nrow_nas,function(x) x[[1]])->pp
as.numeric(as.character(pp))->pp
nas$nrow<-pp

##nyse
read.csv('~/Documents/trading/active_nyse_380.csv')->nyse
lapply(nyse$x,function(x) dim(tryCatch({fetch_historical_data(days = 5,ticker = x)}, error=function(e){}))[1])->nrow_nyse
lapply(nrow_nyse,function(x) x[[1]])->nn
as.numeric(as.character(nn))->nn
nyse$nrow<-nn


write.csv(nyse$x[which(nyse$nrow>1900)],'~/Documents/trading/active_nyse_380_5d.csv',row.names=F,col.names=FALSE)

write.csv(nas$x[which(nas$nrow>1900)],'~/Documents/trading/active_nas_380_5d.csv',row.names=F,col.names=FALSE)
