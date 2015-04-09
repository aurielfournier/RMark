setwd("~/GitHub/RMark")
dat <- read.csv("to_ar.csv")
bbl <- read.csv("BBL.B.AREA.CODE.csv")
dat <- dat[dat$ENCOUNTER.YEAR>=2000,]

bat <- merge(bbl, dat, by="B.AREA.CODE")
cdat <- cast(bat, name ~ E.AREA.CODE)
colnames(cdat) <- c("area","number")
cdat <- cdat[cdat$area!="Arkansas",]
write.csv(cdat, "cago_from_outside_arkansas.csv")
