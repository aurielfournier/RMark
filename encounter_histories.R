# Making Encounter Histories
setwd("~/Documents/RMark")
dat <- read.csv('direct_recoveries_cago_ar_banded_2002_2011_metal_only.csv',header=T)
dat <- dat[,c("band","b_year","r_year")]
b <- dat[,c("band","b_year")]
colnames(b) <- c("band","year")
r <- dat[,c("band","r_year")]
colnames(r) <- c("band","year")
rat <- rbind(b,r)
rat$num <- 1

cdat <- cast(data=rat, band ~ year)

cdat[2:ncol(cdat)] <- ifelse(cdat[2:ncol(cdat)]>=1, 1,0)

cdat$cap <- paste(cdat$"2002", cdat$"2003",cdat$"2004",cdat$"2005",cdat$"2006",cdat$"2007",cdat$"2008",cdat$"2009",cdat$"2010",cdat$"2011",cdat$"2012", sep="")

