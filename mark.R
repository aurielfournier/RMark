# first shot at analyzing
setwd("~/RMark")
library(RMark)
options(scipen=999)
dat <- read.csv("enhist.csv",header=T,colClasses=c(NA,NA,"character"))
dat$cdat.cap <- as.character(dat$cdat.cap)
colnames(dat) <- c("x","band","ch")
model <- mark(dat)