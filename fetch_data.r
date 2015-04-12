


fetch_historical_data <- function(peroid=60, days, ticker, type=c('d,c')) 
  
  {
  url <- paste0('http://www.google.com/finance/getprices?i=',peroid,'&p=',days,'d&f=',type,'&df=cpct&q=',ticker)
  data <-read.table(url,skip=7,sep=",",col.names=strsplit(type,split=",")[[1]])
  if(grep('d',names(data))>0)
  {
  data$d<-as.character(data$d)
  for (i in 1:dim(data)[1]){
    if(grepl('[a-z]',data$d[i])){
      date <- as.numeric(substr(as.character(data$d[i]),2,nchar(as.character(data$d[i]))))
      data$d[i] <- date
    }else{ date+ 60*as.numeric(data$d[i])->data$d[i]}
  }
  data$d<-as.numeric(data$d)  
  data<-data[order(data$d),]
  }
  data
}


