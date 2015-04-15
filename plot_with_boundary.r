plot_with_boundary <- function(data,target_name=c("ratio"),date_name='d',ma_period=100, n_sd=1){

  if (!is.data.frame(data)) {
    stop("data must be a data frame")
  }
  
  data$date <- as.POSIXct(data[[date_name]],origin = '1970-01-01')
  
  data$std<-0
  data$mean<-0
  for(i in ma_period:(dim(data)[1]))
  {
    data$std[i]<-sd(data[[target_name]][(i-ma_period+1):(i-1)])
    data$mean[i]<-mean(data[[target_name]][(i-ma_period+1):(i-1)]) 
  }

  data$plus_std <- data$mean+data$std
  data$minus_std <- data$mean-data$std
  
  data$plus_2std <- data$mean+data$std*1.65
  data$minus_2std <- data$mean-data$std*1.65
  
  plot (x=data$date ,y=data[[target_name]], type='l')
  lines(x=data$date ,y=data$plus_std, type='l', col='red')
  lines(x=data$date ,y=data$plus_2std, type='l', col='red')
  lines(x=data$date ,y=data$minus_std, type='l', col='green')
  lines(x=data$date ,y=data$minus_2std, type='l', col='green')
  
}

