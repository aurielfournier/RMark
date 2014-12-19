# first shot at analyzing
setwd("~/RMark")
library(RMark)
options(scipen=999)
dat <- read.csv("live_dead_enhist.csv",header=T,colClasses=c(NA,NA,NA,NA,"character"))
model <- mark(dat, model="Barker")

pd <-process.data(dat, model="Barker")
m1 <- mark(pd, model="Barker")
