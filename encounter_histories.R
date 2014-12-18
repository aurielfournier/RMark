# Making Encounter Histories
library(reshape)
setwd("/Users/AurielFournier/Documents/RMark")
dat <- read.csv("canada_geese_arkansas.csv",header=T)
dat$b_new_year <- ifelse(dat$banding_month>=6,dat$banding_year, dat$banding_year-1)
dat$e_new_year <- ifelse(dat$encounter_month>=6,dat$encounter_year, dat$encounter_year-1)
b <- dat[,c("band_id","b_new_year","l_d","b_age_code","b_sex_code")]
colnames(b) <- c("band_id","year","l_d","age","sex")
e <- dat[,c("band_id","e_new_year","l_d","b_age_code","b_sex_code")]
colnames(e) <- c("band_id","year","l_d","age","sex")
rat <- rbind(b,e)
rat$num <- 1
rat <- rat[rat$year>=2000,]
cdat <- cast(data=rat, band_id ~ year)

# ----------
cdat[2:ncol(cdat)] <- ifelse(cdat[2:ncol(cdat)]>=1, 1,0)

cdat$cap <- paste(cdat$"2002", cdat$"2003",cdat$"2004",cdat$"2005",cdat$"2006",cdat$"2007",cdat$"2008",cdat$"2009",cdat$"2010",cdat$"2011",cdat$"2012", sep="")

enhist <- data.frame(cdat$band, cdat$cap)
enhist$cdat.cap <- as.character(enhist$cdat.cap)
write.csv(enhist, 'enhist.csv')
