# first shot at analyzing
setwd("~/SourceTree/RMark")
library(RMark)
options(scipen=999)
dat <- read.csv('live_dead_enhist.csv',header=T,colClasses=c("character","factor","factor"))

#age structure, define groups (sex)
pdat <- process.data(dat, begin.time=2005, model="Burnham",groups=c("sex","age"), time.intervals=c(1,1,1,1,1,1,1))

model <- mark(dat, model="Burnham")
model1 <- mark(dat, model="Burnham", model.parameters=group.covariates)
