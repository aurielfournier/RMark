# first shot at analyzing
setwd("~/SourceTree/RMark")
library(RMark)
options(scipen=999)
dat <- read.csv("live_dead_enhist.csv",header=T,colClasses=c(NA,NA,NA,NA,"character"))
dat <- dat[,2:ncol(dat)]

#age structure, define groups (sex)
dat <- process.data(dat, begin.time=2000, model="Burnham",groups=c("sex","age"))

model <- mark(dat, model="Burnham")
