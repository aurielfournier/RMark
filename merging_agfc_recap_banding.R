dat2 <- read.csv('agfc_banding_00_11.csv')
dat3<- read.csv('agfc_recaps.csv')

merged <- merge(dat2, dat3, by="band_id", all=TRUE)
merged$value <- 1
cast(data=merged, year ~ encounter_year, value="value")





