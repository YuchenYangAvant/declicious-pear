


fetch_historical_data <- function(peroid=60, days, ticker, type=c('d,o,h,l,c,v'), real_flag=T) 
  
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
  
  ###add date index col
  source('~/dev/delicious-pear/get_fixed_timestamp.r')
  d_fixed<-get_fixed_timestamp(data$d)+60
  d_fixed[!duplicated(d_fixed)]->date_index
  
  new_data <- as.data.frame(matrix(ncol =dim(data)[2] , nrow = 390*length(date_index)))
  names(new_data)<-strsplit(type,split=",")[[1]]
  
  new_data$d <- unlist(lapply(date_index, function(x) seq(from = x, to = x + 60*389,by=60)))
  new_data$real_flag<-0
  for (j in 1:dim(new_data)[1]){
    if(new_data$d[j] %in% data$d ==F){
      if(j==1){new_data[j,-which(names(new_data) %in% c('d','real_flag'))] <-  data[,which(names(data) !='d')][j,]}
      else{new_data[j,-which(names(new_data) %in% c('d','real_flag'))] <-  new_data[,which(names(new_data) !='d')][(j-1),]}
      }else{
    new_data[j,-which(names(new_data) %in% c('d','real_flag'))] <- data[,which(names(data) !='d')][which(data$d==new_data$d[j]),]
    new_data$real_flag[j]<-1
    }
  }
  
  }
  new_data$time<-as.POSIXct(new_data$d,origin = '1970-01-01')
  if(real_flag){
    new_data[which(new_data$real_flag==1),]
  }else{
    new_data
  }
  
  
}


