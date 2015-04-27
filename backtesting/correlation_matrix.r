dir = '~/Documents/trading/'
stock_list<- read.csv(paste0(dir,'active_nyse_380_5d.csv'))
stock_list<-rbind(stock_list,read.csv(paste0(dir,'active_nas_380_5d.csv')))
names(stock_list) <- 'ticker'

giant_matrix<- as.data.frame(read.csv(paste0(dir,stock_list$ticker[1],'.csv')))
giant_matrix<-giant_matrix[,which(names(giant_matrix) %in% c('d','c'))]
names(giant_matrix)[which(names(giant_matrix)=='c')] <- as.character(stock_list$ticker[1])



for(i in 2:dim(stock_list)[1])
{
  bla <- read.csv(paste0(dir,stock_list$ticker[i],'.csv'))
  bla<-bla[,which(names(bla) %in% c('d','c'))]
  names(bla)[which(names(bla)=='c')] <- as.character(stock_list$ticker[i])
  giant_matrix<-merge(giant_matrix,bla,by='d')
  
}


giant_matrix2<-giant_matrix[,-1]
giant_matrix2<-giant_matrix2[-1,]
giant_matrix3<-giant_matrix[-dim(giant_matrix)[1],-1]
giant_matrix_final <- giant_matrix2/giant_matrix3


giant_col<- cor(giant_matrix_final)

names(giant_col[,1])->dudes
summary_cor <- as.data.frame(t(combn(dudes,2)))
iii <- apply(summary_cor,1,function(z) giant_col[x=z[1],y=z[2]] )
lll <- apply(summary_cor,1,function(z) var(giant_matrix[[z[1]]]/giant_matrix[[z[2]]]) )

summary_cor$corr<-iii
summary_cor$varr<-lll

