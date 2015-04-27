fetch_pairs_data <- function(tickers,dir='~/Documents/trading/')
{
  if(length(tickers)!=2){stop('we need TWO stock tickers!!!')}
  bla1=read.csv(paste0(dir,tickers[1],'.csv'))
  bla1<-bla1[,which(names(bla1) %in% c('d','c'))]
  names(bla1)[which(names(bla1)=='c')] <- as.character(tickers[1])
  
  bla2=read.csv(paste0(dir,tickers[2],'.csv'))
  bla2<-bla2[,which(names(bla2) %in% c('d','c'))]
  names(bla2)[which(names(bla2)=='c')] <- as.character(tickers[2])
  blabla <- as.data.frame(merge(bla1,bla2,by='d'))
  blabla$ratio<-blabla[[tickers[1]]]/blabla[[tickers[2]]]
  
  blabla
}
