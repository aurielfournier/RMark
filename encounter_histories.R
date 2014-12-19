# Making Encounter Histories
library(reshape)
<<<<<<< HEAD
dat <- read.csv('direct_recoveries_cago_ar_banded_2002_2011_metal_only.csv',header=T)
dat <- dat[,c("band","b_year","r_year","b_month","r_month","live_dead")]
dat$b_new_year <- ifelse(dat$b_month>=6,dat$b_year, dat$b_year+1)
dat$r_new_year <- ifelse(dat$r_month>=6,dat$r_year, dat$r_year+1)
b <- dat[,c("band","b_new_year","live_dead")]
colnames(b) <- c("band","year","live_dead")
r <- dat[,c("band","r_new_year","live_dead")]
colnames(r) <- c("band","year","live_dead")
rat <- rbind(b,r)
=======
setwd("/Users/AurielFournier/Documents/RMark")
dat <- read.csv("canada_geese_arkansas.csv",header=T)
dat$b_new_year <- ifelse(dat$banding_month>=6,dat$banding_year, dat$banding_year-1)
dat$e_new_year <- ifelse(dat$encounter_month>=6,dat$encounter_year, dat$encounter_year-1)
b <- dat[,c("band_id","b_new_year","l_d","b_age_code","b_sex_code")]
colnames(b) <- c("band_id","year","l_d","age","sex")
e <- dat[,c("band_id","e_new_year","l_d","b_age_code","b_sex_code")]
colnames(e) <- c("band_id","year","l_d","age","sex")
rat <- rbind(b,e)
>>>>>>> dd6eb33faf24a07f045255f5a6215f69ac2b106f
rat$num <- 1
rat <- rat[rat$year>=2000,]

<<<<<<< HEAD
allcols <- data.frame(band=seq(1:24),year=rep(seq(from=2002,to=2013),each=2),live_dead=rep(c("alive","dead"),times=12),num=0)
rat <- rbind(rat, allcols)

cdat <- cast(data=rat, band ~ year + live_dead)
cdat[2:ncol(cdat)] <- ifelse(cdat[2:ncol(cdat)]>=1, 1,0)

cdat$cap <- paste(cdat$"2002_alive", cdat$"2002_dead",cdat$"2003_alive", cdat$"2003_dead",cdat$"2004_alive",cdat$"2004_dead",cdat$"2005_alive",cdat$"2005_dead",cdat$"2006_alive",cdat$"2006_dead",cdat$"2007_alive",cdat$"2007_dead",cdat$"2008_alive",cdat$"2008_dead",cdat$"2009_alive",cdat$"2009_dead",cdat$"2010_alive",cdat$"2010_dead",cdat$"2011_alive",cdat$"2011_dead",cdat$"2012_alive",cdat$"2012_dead", sep="")
cdat <- cdat[25:nrow(cdat),]
enhist <- data.frame(cdat$band, cdat$cap)
enhist$cdat.cap <- as.character(enhist$cdat.cap)
colnames(enhist) <- c("band","ch")
write.csv(enhist, 'enhist.csv')

=======
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
>>>>>>> dd6eb33faf24a07f045255f5a6215f69ac2b106f
