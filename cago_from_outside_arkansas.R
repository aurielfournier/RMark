setwd("~/GitHub/RMark")
dat <- read.csv("to_ar.csv")
bbl <- read.csv("BBL.B.AREA.CODE.csv")
dat <- dat[dat$ENCOUNTER.YEAR>=2000,]
dat <- dat[!(dat$B.AGE.CODE==0|dat$B.AGE.CODE==2|dat$B.AGE.CODE==3|dat$B.AGE.CODE==4), ]
bat <- merge(bbl, dat, by="B.AREA.CODE")
bat <- bat[bat$ENCOUNTER.MONTH==9|bat$ENCOUNTER.MONTH==10|bat$ENCOUNTER.MONTH==11|bat$ENCOUNTER.MONTH==12|bat$ENCOUNTER.MONTH==1|bat$ENCOUNTER.MONTH==2,]
cdat <- cast(bat, name ~ ENCOUNTER.MONTH)
cdat <- cdat[cdat$name!="Arkansas",]
cdat <- cdat[,c(1,4:7,2:3)]
write.csv(cdat, "cago_from_outside_arkansas_by_month.csv", row.names=F)
