# input for lincoln
library(reshape)
dat <- read.csv("~/GitHub/RMark/canada_geese_arkansas_bbl.csv")

cdat <- cast(data=dat, banding_year ~ encounter_year)
cdat$total <- rowSums(cdat)
