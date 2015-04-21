source('~/dev/delicious-pear/fetch_data.r')
read.csv('~/Downloads/companylist_nasdaq.csv')->nas
lapply(nas$Symbol,function(x) dim(tryCatch({fetch_historical_data(days = 1,ticker = x)}, error=function(e){}))[1])->nrow_nas
lapply(nrow_nas,function(x) x[[1]])->pp
as.numeric(as.character(pp))->pp
nas$nrow<-pp

##nyse
read.csv('~/Downloads/companylist_nyse.csv')->nyse
lapply(nyse$Symbol,function(x) dim(tryCatch({fetch_historical_data(days = 1,ticker = x)}, error=function(e){}))[1])->nrow_nyse
lapply(nrow_nyse,function(x) x[[1]])->nn
as.numeric(as.character(nn))->nn
nyse$nrow<-nn


write.csv(nyse$Symbol[which(nyse$nrow>380)],'~/Downloads/active_nyse_380.csv',row.names=F,col.names=FALSE)

