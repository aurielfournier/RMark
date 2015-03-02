# known fate models input files
library(reshape)
dat <- read.csv("2004_telemetry_logs.csv")

dat <- dat[,c("DD","MM","Status","Frequency")]

dat$num <- 1

mdat <- melt(dat, id=c("DD","MM","Status","Frequency"))

mdat$Status <- ifelse(mdat$Status==1,0,1)

zero <- data.frame(DD=mdat$DD, MM=mdat$MM, Status=1, Frequency=NA, variable="num",value=1)

mdat <- rbind(mdat, zero)

cdat <- cast(data=mdat, Frequency ~ MM+DD+Status)

cdat[2:ncol(cdat)] <- ifelse(cdat[2:ncol(cdat)]>=1,1,0)

name <- colnames(cdat[2:ncol(cdat)])

cdat$ch <- do.call(paste, c(cdat[name], list(sep="")))


ch <- as.data.frame(cdat$ch)
colnames(ch) <- "ch"
ch$ch <- as.character(ch$ch)

pd <- process.data(data=ch, begin.time=1, model="Known")

dd <- make.design.data(pd)
