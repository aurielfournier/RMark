#Lincoln Cago population estimates
library(reshape)
options(scipen=999)
dat <- read.csv("canada_geese_arkansas.csv",header=T)
dat$b_new_year <- ifelse(dat$banding_month>=6,dat$banding_year, dat$banding_year-1)
dat$e_new_year <- ifelse(dat$encounter_month>=6,dat$encounter_year, dat$encounter_year-1)
b <- dat[,c("band_id","b_new_year","l_d","b_age_code","b_sex_code")]
colnames(b) <- c("band_id","year","l_d","age","sex")
e <- dat[,c("band_id","e_new_year","l_d","b_age_code","b_sex_code")]
colnames(e) <- c("band_id","year","l_d","age","sex")
rat <- rbind(b,e)
rat$num <- 1
rat <- rat[rat$year>=2005,]
rat <- rat[rat$year<=2011,]

cdat <- cast(data=rat, band_id ~ year)
cdat[2:ncol(cdat)] <- ifelse(cdat[2:ncol(cdat)]>=1, 1,0)
cdat$new2005 <- ifelse(cdat$"2005"==1,1,0)
cdat$new2006 <- ifelse(cdat$"2005"==0&cdat$"2006"==1,1,0)
cdat$new2007 <- ifelse(cdat$"2005"==0&cdat$"2006"==0&cdat$"2007"==1,1,0)
cdat$new2008 <- ifelse(cdat$"2005"==0&cdat$"2006"==0&cdat$"2007"==0&cdat$"2008"==1,1,0)
cdat$new2009 <- ifelse(cdat$"2005"==0&cdat$"2006"==0&cdat$"2007"==0&cdat$"2008"==0&cdat$"2009"==1,1,0)
cdat$new2010 <- ifelse(cdat$"2005"==0&cdat$"2006"==0&cdat$"2007"==0&cdat$"2008"==0&cdat$"2009"==0&cdat$"2010"==1,1,0)
cdat$new2011 <- ifelse(cdat$"2005"==0&cdat$"2006"==0&cdat$"2007"==0&cdat$"2008"==0&cdat$"2009"==0&cdat$"2010"==0&cdat$"2011"==1,1,0)
cdat$re2006 <- ifelse(cdat$"2005"&cdat$"2006"==1,1,0)
cdat$re2007 <- ifelse(cdat$"2005"&cdat$"2006"==1|cdat$"2005"&cdat$"2007"==1|cdat$"2006"&cdat$"2007"==1,1,0)
cdat$re2008 <- ifelse(cdat$"2005"&cdat$"2006"==1|cdat$"2005"&cdat$"2007"==1|cdat$"2006"&cdat$"2007"==1|cdat$"2005"&cdat$"2008"==1|cdat$"2006"&cdat$"2008"==1|cdat$"2007"&cdat$"2008"==1,1,0)
cdat$re2009 <- ifelse(cdat$"2005"&cdat$"2006"==1|cdat$"2005"&cdat$"2007"==1|cdat$"2006"&cdat$"2007"==1|cdat$"2005"&cdat$"2008"==1|cdat$"2006"&cdat$"2008"==1|cdat$"2007"&cdat$"2008"==1|cdat$"2005"&cdat$"2009"==1|cdat$"2006"&cdat$"2009"==1|cdat$"2007"&cdat$"2009"==1|cdat$"2008"&cdat$"2009"==1,1,0)
cdat$re2010 <- ifelse(cdat$"2005"&cdat$"2006"==1|cdat$"2005"&cdat$"2007"==1|cdat$"2006"&cdat$"2007"==1|cdat$"2005"&cdat$"2008"==1|cdat$"2006"&cdat$"2008"==1|cdat$"2007"&cdat$"2008"==1|cdat$"2005"&cdat$"2009"==1|cdat$"2006"&cdat$"2009"==1|cdat$"2007"&cdat$"2009"==1|cdat$"2008"&cdat$"2009"==1|cdat$"2005"&cdat$"2010"==1|cdat$"2006"&cdat$"2010"==1|cdat$"2007"&cdat$"2010"==1|cdat$"2008"&cdat$"2010"==1|cdat$"2009"&cdat$"2010"==1,1,0)
cdat$re2011 <- ifelse(cdat$"2005"&cdat$"2006"==1|cdat$"2005"&cdat$"2007"==1|cdat$"2006"&cdat$"2007"==1|cdat$"2005"&cdat$"2008"==1|cdat$"2006"&cdat$"2008"==1|cdat$"2007"&cdat$"2008"==1|cdat$"2005"&cdat$"2009"==1|cdat$"2006"&cdat$"2009"==1|cdat$"2007"&cdat$"2009"==1|cdat$"2008"&cdat$"2009"==1|cdat$"2005"&cdat$"2010"==1|cdat$"2006"&cdat$"2010"==1|cdat$"2007"&cdat$"2010"==1|cdat$"2008"&cdat$"2010"==1|cdat$"2009"&cdat$"2010"==1|cdat$"2005"&cdat$"2011"==1|cdat$"2006"&cdat$"2011"==1|cdat$"2007"&cdat$"2011"==1|cdat$"2008"&cdat$"2011"==1|cdat$"2009"&cdat$"2011"==1|cdat$"2010"&cdat$"2011"==1,1,0)


Nhat <- as.data.frame(matrix(ncol=10, nrow=6))
Nhat[,1] <- seq(2006,2011)
Nhat[,2] <- c(37408.80,15766.10,10740.92,24952.68,48740.46,14467.31)

for(i in 1:6){
  Nhat[i,3] <- sum(cdat[,(i+10)])
}
for(i in 1:6){
  Nhat[i,4] <- sum(cdat[,(i+11)])
}
for(i in 1:6){
  Nhat[i,5] <- sum(cdat[,(i+16)])
}


Nhat[,6] <- Nhat[,5]/Nhat[,4]
Nhat[,7] <- .736
Nhat[,8] <- Nhat[,6]/ Nhat[,7]
Nhat[,9] <- Nhat[,2]/Nhat[,8]
Nhat[,10] <-  (Nhat[,4]*Nhat[,3])/Nhat[,5]
colnames(Nhat) <- c("year","TN","new_prevyear","new_curyear","recap","direct band recovery rate","band report rate","harvest rate","Nhat","NewNhat")



Nhat$variance <- ((Nhat$new * Nhat$TN)/Nhat$recap)^2 * var(Nhat$"direct band recovery rate") + Nhat$"direct band recovery rate"^2 * var((Nhat$new * Nhat$TN)/Nhat$recap)

Nhat$variance <- ( (Nhat$new +1)*(Nhat$TN + 1)*(Nhat$new - Nhat$recap)*(Nhat$TN - Nhat$recap)) / ((Nhat$recap + 1)^2 * (Nhat$recap +2))

Nhat$variance <- var((Nhat$new * Nhat$TN * Nhat$"band report rate")/(Nhat$recap))

Nhat$se <- sqrt((Nhat$recap * Nhat$new)/Nhat$recap^3)

