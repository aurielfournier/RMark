# Manipulating Raw Data Files from the BBL 

setwd("~/Documents/RMark")
dat1 <- read.csv('Fournier_bnds_CAGO_AR_201412180839.csv',header=T)
#dat2 <- read.csv('Fournier_encs_from_AR_2000_201412180934.csv',header=T)
dat3 <- read.csv('Fournier_encs_to_AR_201412181101.csv',header=T)

dat1$state <- "AR"
dat1 <- dat1[dat1$SPECIES_ID==1720,] #removes the cackling geese. 
dat1 <- dat1[,c("BAND_NUM","AGE_CODE","SEX_CODE","BANDING_DATE","BANDING_DAY","BANDING_MONTH","BANDING_YEAR","state")]
dat1$e_date <- NA
dat1$e_day <- NA
dat1$e_month <- NA
dat1$e_year <- NA
dat1$e_present_code <- 7

#dat2 <- dat2[,c("BAND_NUM","B_AGE_CODE","B_SEX_CODE","BANDING_DATE","BANDING_DAY","BANDING_MONTH","BANDING_YEAR","E_PLACE_NAME","ENCOUNTER_DATE","ENCOUNTER_DAY","ENCOUNTER_MONTH","ENCOUNTER_YEAR","E_PRESENT_CONDITION_CODE")]

dat3 <- dat3[dat3$E.HOW.OBTAINED.CODE==50|dat3$E.HOW.OBTAINED.CODE==56|dat3$E.HOW.OBTAINED.CODE==70|dat3$E.HOW.OBTAINED.CODE==98,]
dat3 <- dat3[dat3$ENCOUNTER.DAY<=31,]
dat3 <- dat3[dat3$B.AREA.CODE==7,]
dat3$state <- "AR"
dat3 <- dat3[,c("BAND.ID","B.AGE.CODE","B.SEX.CODE","BANDING.DATE","BANDING.DAY","BANDING.MONTH","BANDING.YEAR","state","ENCOUNTER.DATE","ENCOUNTER.DAY","ENCOUNTER.MONTH","ENCOUNTER.YEAR","E.PRESENT.CONDITION.CODE")]
colnames(dat3) <- tolower(colnames(dat3))
namesdat3 <- colnames(dat3)
namesdat3 <- gsub(".", '_', namesdat3, fixed = T)
colnames(dat3) <- namesdat3

colnames(dat1) <- colnames(dat3)
#colnames(dat2) <- colnames(dat3)

dat1_2 <- rbind(dat1, dat3)
#dat1_2 <- rbind(dat1_1, dat3)

dat1_2$l_d <- ifelse(dat1_2$e_present_condition_code==1|dat1_2$e_present_condition_code==2|dat1_2$e_present_condition_code==3,"unknown",
                  ifelse(dat1_2$e_present_condition_code==4|dat1_2$e_present_condition_code==5|dat1_2$e_present_condition_code==6,"dead",
                        ifelse(dat1_2$e_present_condition_code==7|dat1_2$e_present_condition_code==8|dat1_2$e_present_condition_code==9|dat1_2$e_present_condition_code==10|dat1_2$e_present_condition_code==11|dat1_2$e_present_condition_code==12|dat1_2$e_present_condition_code==13|dat1_2$e_present_condition_code==14|dat1_2$e_present_condition_code==15|dat1_2$e_present_condition_code==16,"alive",NA)))

dat1_2 <- dat1_2[dat1_2$banding_year>=2000,]
write.csv(dat1_2, "canada_geese_arkansas.csv")
