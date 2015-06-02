# M Arrays
library(reshape)
dat <- read.csv("canada_geese_arkansas.csv")
dat <- dat[dat$b_age_code!=0,]

ahy <- dat[dat$b_age_code==1,]
hy <- dat[dat$b_age_code==2,]
loc <- dat[dat$b_age_code==4,]

ahy <- cast(data=ahy, banding_year ~ encounter_year)
hy <- cast(data=hy, banding_year ~ encounter_year)
loc <- cast(data=loc, banding_year ~ encounter_year)

ahy$total <- rowSums(ahy[,2:16])
ahy[16,2:17] <- colSums(ahy[,2:17])
ahy[16,1] <- "total"

hy$total <- rowSums(hy[,2:16])
hy[10,2:17] <- colSums(hy[,2:17])
hy[10,1] <- "total"

loc$total <- rowSums(loc[,2:15])
loc[13,2:16] <- colSums(loc[,2:16])
loc[13,1] <- "total"

write.csv(ahy, row.names=FALSE, "ahy_array.csv")

write.csv(hy, row.names=FALSE, "hy_array.csv")

write.csv(loc, row.names=FALSE, "loc_array.csv")