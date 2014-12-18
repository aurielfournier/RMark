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

# Regular Encounter History ---------------------------------------------------

cdat <- cast(data=rat, band_id + age + sex ~ year)
cdat[4:ncol(cdat)] <- ifelse(cdat[4:ncol(cdat)]>=1, 1,0)
cdat$cap <- paste(cdat$"2000",cdat$"2001",cdat$"2002", cdat$"2003",cdat$"2004",cdat$"2005",cdat$"2006",cdat$"2007",cdat$"2008",cdat$"2009",cdat$"2010",cdat$"2011",cdat$"2012",cdat$"2013",cdat$"2014", sep="")
enhist <- data.frame(cdat$band_id, cdat$sex , cdat$age, cdat$cap)
enhist$cdat.cap <- as.character(enhist$cdat.cap)
colnames(enhist) <- c("band","sex","age","ch")
write.csv(enhist, 'enhist.csv')

# live/dead recover encouter history ------------------------------
rat <- rat[rat$l_d != "unknown",] #remove the unknowns
rat <- rat[!(is.na(rat$l_d)),] # remove the NA's
cdat <- cast(data=rat, band_id + sex + age ~ year + l_d)
cdat$cap <- paste(cdat$"2000_alive",cdat$"2000_dead",cdat$"2001_alive",cdat$"2001_dead",cdat$"2002_alive",cdat$"2002_dead",cdat$"2003_alive", cdat$"2003_dead",cdat$"2004_alive",cdat$"2004_dead",cdat$"2005_alive",cdat$"2005_dead",cdat$"2006_alive",cdat$"2006_dead",cdat$"2007_alive",cdat$"2007_dead",cdat$"2008_alive",cdat$"2008_dead",cdat$"2009_alive",cdat$"2009_dead",cdat$"2010_alive",cdat$"2010_dead",cdat$"2011_alive",cdat$"2011_dead",cdat$"2012_alive",cdat$"2012_dead",cdat$"2013_alive",cdat$"2013_dead",cdat$"2014_alive",cdat$"2014_dead", sep="")
enhist <- data.frame(cdat$band_id, cdat$sex , cdat$age, cdat$cap)
enhist$cdat.cap <- as.character(enhist$cdat.cap)
colnames(enhist) <- c("band","sex","age","ch")
write.csv(enhist, 'live_dead_enhist.csv')