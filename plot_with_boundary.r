plot_with_boundary <- function(data,target_name=c("ratio"),date_name='d',ma_period=100, n_sd=1, display=5){

  if (!is.data.frame(data)) {
    stop("data must be a data frame")
  }
  
  name1<-names(data)[2]
  name2<-names(data)[3]
  
  
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
    
    
  data$DATE<-format(data$date,'%Y/%m/%d')
  DATE <- unique(data$DATE)
  length(DATE)->num_days
  days_flag<- seq(from = num_days,to=1,by = -1)
  as.data.frame(cbind(DATE,days_flag))-> unique_date
  merge(data,unique_date,by='DATE')->data
  

  ylabb<-paste0(name1,' over ',name2)
  par(mfrow=c(ceiling(display/2),2))
  
  for(i in display:1)
  {
    plot (x=data$date[which(data$days_flag==i)] ,y=data[[target_name]][which(data$days_flag==i)], type='l',ylab =ylabb,xlab = unique_date$DATE[which(unique_date$days_flag==i)] )
    lines(x=data$date[which(data$days_flag==i)] ,y=data$plus_std[which(data$days_flag==i)], type='l', col='red')
    lines(x=data$date[which(data$days_flag==i)] ,y=data$plus_2std[which(data$days_flag==i)], type='l', col='red')
    lines(x=data$date[which(data$days_flag==i)] ,y=data$minus_std[which(data$days_flag==i)], type='l', col='green')
    lines(x=data$date[which(data$days_flag==i)] ,y=data$minus_2std[which(data$days_flag==i)], type='l', col='green')
   
    par(new=TRUE)
    plot(x=data$date[which(data$days_flag==i)] ,y=data$std[which(data$days_flag==i)], type='l', col='purple',ylab ='',xlab='',xaxt="n",yaxt="n")
    axis(4)
    mtext("std",side=4,line=3)
  }

  
}

