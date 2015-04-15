source('~/dev/delicious-pear/fetch_data.r')
read.csv('~/Downloads/companylist_nasdaq.csv')->nas
lapply(nas$Symbol,function(x) dim(tryCatch({fetch_historical_data(days = 1,ticker = x)}, error=function(e){}))[1])->nrow_nas
lapply(nrow_nas,function(x) x[[1]])->pp
as.numeric(as.character(pp))->pp
nas$nrow<-pp

write.csv(nas$Symbol[which(nas$nrow>370)],'~/Downloads/active_nasdaq_370.csv',row.names=F,col.names=FALSE)
