# Making Encounter Histories
setwd("~/RMark")
library(reshape)
dat <- read.csv('direct_recoveries_cago_ar_banded_2002_2011_metal_only.csv',header=T)
dat <- dat[,c("band","b_year","r_year","b_month","r_month","live_dead")]
dat$b_new_year <- ifelse(dat$b_month>=6,dat$b_year, dat$b_year+1)
dat$r_new_year <- ifelse(dat$r_month>=6,dat$r_year, dat$r_year+1)
b <- dat[,c("band","b_new_year","live_dead")]
colnames(b) <- c("band","year","live_dead")
r <- dat[,c("band","r_new_year","live_dead")]
colnames(r) <- c("band","year","live_dead")
rat <- rbind(b,r)
rat$num <- 1

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

