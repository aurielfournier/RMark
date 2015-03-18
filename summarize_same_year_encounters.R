setwd("~/GitHub/RMark")

band <- read.csv("Fournier_bnds_CAGO_AR_201412180839.csv")
band <- band[band$BANDING_YEAR>=2006,]
band <- band[band$AGE_CODE==1,]
band$year <- as.factor(band$BANDING_YEAR)

tabb <- table(band$year)

cago <- as.data.frame(matrix(ncol=2, nrow=9))

cago[,1] <- tabb

enc <- read.csv("Fournier_encs_from_AR_2000_201412180934.csv")

encs <- enc[enc$BANDING_YEAR == enc$ENCOUNTER_YEAR,]
encs <- encs[encs$ENCOUNTER_MONTH==9,]
encs$year <- as.factor(encs$ENCOUNTER_YEAR)
tage <- table(encs$year)
cago$year <- seq(2006,2014,1)



en <- read.csv("Fournier_encs_to_AR_201412181101.csv")
en <- en[en$B.AGE.CODE==1,]
ens <- en[en$BANDING.YEAR == en$ENCOUNTER.YEAR,]
ens
ens <- ens[ens$ENCOUNTER.MONTH==9,]
ens$year <- as.factor(ens$ENCOUNTER.YEAR)
tage <- table(ens$year)
cago$year <- seq(2006,2014,1)
cago[,2] <- tage[2:10]
colnames(cago) <- c("band","enc","year")
write.csv(cago, "same_year_encounter_adult.csv", row.names=F)
