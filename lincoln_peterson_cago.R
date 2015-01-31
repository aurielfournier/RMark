#Cago
#Lincoln-Peterson

dat <- read.csv("cago_cap_history.csv")

Nhat <- as.data.frame(matrix(ncol=2, nrow=(2011-2005)))
Nhat[,1] <- seq(2006,2011)

for(i in 1:6){
    Nhat[i,2] <- sum(dat[,(i+3)])*sum(dat[,(i+4)])/sum(ifelse(dat[,(i+3)]&dat[,(i+4)]==1,1,0))
}


plot(Nhat)
write.csv(Nhat, "cago_nhat_lincoln_peterson.csv")
