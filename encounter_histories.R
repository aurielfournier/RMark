# Making Encounter Histories
library(reshape)

dat <- read.csv("C:/Users/avanderlaar/Documents/GitHub/RMark/canada_geese_arkansas.csv",header=T)
dat$b_new_year <- ifelse(dat$banding_month>=6,dat$banding_year, dat$banding_year-1)
dat$e_new_year <- ifelse(dat$encounter_month>=6,dat$encounter_year, dat$encounter_year-1)
b <- dat[,c("band_id","b_new_year","l_d","b_age_code","b_sex_code")]
colnames(b) <- c("band_id","year","l_d","age","sex")
e <- dat[,c("band_id","e_new_year","l_d","b_age_code","b_sex_code")]
colnames(e) <- c("band_id","year","l_d","age","sex")
rat <- rbind(b,e)
rat$num <- 1
rat <- rat[rat$year>=2006,]
rat <- rat[rat$year<=2011,]



# Regular Encounter History ---------------------------------------------------

cdat <- cast(data=rat, band_id + age + sex ~ year)
cdat[4:ncol(cdat)] <- ifelse(cdat[4:ncol(cdat)]>=1, 1,0)
cdat$cap <- paste(cdat$"2000",cdat$"2001",cdat$"2002", cdat$"2003",cdat$"2004",cdat$"2005",cdat$"2006",cdat$"2007",cdat$"2008",cdat$"2009",cdat$"2010",cdat$"2011",cdat$"2012",cdat$"2013",cdat$"2014", sep="")
enhist <- data.frame(cdat$band_id, cdat$sex , cdat$age, cdat$cap)
enhist$cdat.cap <- as.character(enhist$cdat.cap)
colnames(enhist) <- c("band","sex","age","ch")
write.csv(enhist, 'enhist.csv')
write.csv(cdat, 'cago_cap_history.csv', row.names=F)
# live/dead recover encouter history ------------------------------
rat <- rat[rat$l_d != "unknown",] #remove the unknowns
rat <- rat[rat$sex != 0,] #removes unknown sex
rat <- rat[rat$age != 0,] #removes unknown age
rat <- rat[!(is.na(rat$l_d)),] # remove the NA's
cdat <- cast(data=rat, band_id + sex + age ~ year + l_d)
sex <- cast(data=rat, band_id ~ sex)
age <- cast(data=rat, band_id ~ age)

cdat[4:ncol(cdat)] <- ifelse(cdat[4:ncol(cdat)]>=1, 1,0)


cdat[,6:ncol(cdat)][cdat$"2006_dead"==1,]<-0
cdat[,8:ncol(cdat)][cdat$"2007_dead"==1,]<-0
cdat[,10:ncol(cdat)][cdat$"2008_dead"==1,]<-0
cdat[,12:ncol(cdat)][cdat$"2009_dead"==1,]<-0
cdat[,14:ncol(cdat)][cdat$"2010_dead"==1,]<-0


cdat[4:ncol(cdat)] <- ifelse(cdat[4:ncol(cdat)]>=1, 1,0)



colnames(cdat) <- c("band_id","sex","age","2006_alive","2006_dead","2007_alive","2007_dead","2008_alive","2008_dead","2009_alive","2009_dead","2010_alive","2010_dead","2011_alive","2011_dead")
#create capture history
cdat$cap <- paste(cdat$"2006_alive",cdat$"2006_dead",cdat$"2007_alive",cdat$"2007_dead",cdat$"2008_alive",cdat$"2008_dead",cdat$"2009_alive",cdat$"2009_dead",cdat$"2010_alive",cdat$"2010_dead",cdat$"2011_alive",cdat$"2011_dead", sep="")
# below removes birds banded before 2005 that were never recovered during the study period
cdat <- cdat[!(cdat$"2006_alive"==0&cdat$"2007_alive"==0&cdat$"2008_alive"==0&cdat$"2009_alive"==0&cdat$"2010_alive"==0&cdat$"2011_alive"==0),]


enhist <- cdat[,c("cap","sex","age")]
colnames(enhist) <- c("ch","sex","age")
write.csv(enhist, 'C:/Users/avanderlaar/Documents/GitHub/RMark/live_dead_enhist.csv', row.names=F)

