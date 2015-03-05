#Cago
#Lincoln-Peterson

dat <- read.csv("cago_cap_history.csv")

Nhat <- as.data.frame(matrix(ncol=2, nrow=(2011-2005)))
Nhat[,1] <- seq(2006,2011)

for(i in 1:6){
    Nhat[i,2] <- sum(dat[,(i+3)])* # captures in year i + 3
                  sum(dat[,(i+4)])/ # captures in year i + 4
                    sum(ifelse(dat[,(i+3)]&dat[,(i+4)]==1,1,0)) # captures which were captured in both years
}

# resulting equation is captures in year i times captures in year i+1 divided by the number of birds captured in both years

plot(Nhat)

write.csv(Nhat, "cago_nhat_lincoln_peterson.csv")
