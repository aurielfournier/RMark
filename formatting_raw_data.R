# Manipulating Raw Data Files from the BBL 


dat1 <- read.csv('C:/Users/avanderlaar/Documents/GitHub/RMark/Fournier_bnds_CAGO_AR_201412180839.csv',header=T)
#dat2 <- read.csv('Fournier_encs_from_AR_2000_201412180934.csv',header=T) #Birds banded in AR, recovered elsewhere
dat3 <- read.csv('C:/Users/avanderlaar/Documents/GitHub/RMark/Fournier_encs_to_AR_201412181101.csv',header=T) #birds recovered in AR, banded anywhere
dat2 <- read.csv('C:/Users/avanderlaar/Documents/GitHub/RMark/agfc_banding_00_11.csv')
dat4 <- read.csv('C:/Users/avanderlaar/Documents/GitHub/RMark/agfc_recaps.csv')

dat5 <- merge(dat2, dat4, by="band_id", all.x=TRUE)
dat5$value <- 1
cdat5 <- cast(data=dat5, year ~ encounter_year)

colnames(dat5) <- c("band_id","e_present_condition_code","spp","b_age_code","b_sex_code","banding_month","banding_day","banding_year","status","encounter_year")


dat5$b_sex_code <- ifelse(dat5$b_sex_code=="M",4,
                          ifelse(dat5$b_sex_code=="F",5,0))

dat5$b_age_code <- ifelse(dat5$b_age_code=="AHY",1,
                          ifelse(dat5$b_age_code=="HY",2,
                                 ifelse(dat5$b_age_code=="AA",1,
                                        ifelse(dat5$b_age_code=="L",2,
                                               ifelse(dat5$b_age_code=="A",1,NA)))))

dat5 <- dat5[!(is.na(dat5$b_age_code)),]


dat5 <- dat5[,c("band_id","b_age_code","b_sex_code","banding_day","banding_month","banding_year","encounter_year","e_present_condition_code")]



######################################################

dat1$state <- "AR"
dat1 <- dat1[dat1$SPECIES_ID==1720,] #removes the cackling geese. 
dat1 <- dat1[,c("BAND_NUM","AGE_CODE","SEX_CODE","BANDING_DATE","BANDING_DAY","BANDING_MONTH","BANDING_YEAR","state")]
dat1$e_date <- NA
dat1$e_day <- NA
dat1$e_month <- NA
dat1$e_year <- NA
dat1$e_present_code <- 7

#dat2 <- dat2[,c("BAND_NUM","B_AGE_CODE","B_SEX_CODE","BANDING_DATE","BANDING_DAY","BANDING_MONTH","BANDING_YEAR","E_PLACE_NAME","ENCOUNTER_DATE","ENCOUNTER_DAY","ENCOUNTER_MONTH","ENCOUNTER_YEAR","E_PRESENT_CONDITION_CODE")]

dat3 <- dat3[dat3$E.HOW.OBTAINED.CODE!=50&dat3$E.HOW.OBTAINED.CODE!=56&dat3$E.HOW.OBTAINED.CODE!=70&dat3$E.HOW.OBTAINED.CODE!=98,]
# those four codes were told not to be included by the BBL in survival analysis
dat3 <- dat3[dat3$ENCOUNTER.DAY<=31,] # removes impossible dates
dat3 <- dat3[dat3$B.AREA.CODE==7,] #7 == Arkansas
dat3$state <- "AR"
dat3 <- dat3[,c("BAND.ID","B.AGE.CODE","B.SEX.CODE","BANDING.DATE","BANDING.DAY","BANDING.MONTH","BANDING.YEAR","state","ENCOUNTER.DATE","ENCOUNTER.DAY","ENCOUNTER.MONTH","ENCOUNTER.YEAR","E.PRESENT.CONDITION.CODE")]
colnames(dat3) <- tolower(colnames(dat3))
namesdat3 <- colnames(dat3)
namesdat3 <- gsub(".", '_', namesdat3, fixed = T)
colnames(dat3) <- namesdat3

colnames(dat1) <- colnames(dat3)
#colnames(dat2) <- colnames(dat3)

dat1 <- dat1[,c("band_id","b_age_code","b_sex_code","banding_day","banding_month","banding_year","state","encounter_day","encounter_month","encounter_year","e_present_condition_code")]
dat3 <- dat3[,c("band_id","b_age_code","b_sex_code","banding_day","banding_month","banding_year","state","encounter_day","encounter_month","encounter_year","e_present_condition_code")]

dat1_2<- rbind(dat1, dat3)
#dat1_2 <- rbind(dat1_1, dat3)

dat5$l_d <- "alive"
dat1_2$l_d <- ifelse(dat1_2$e_present_condition_code==1|dat1_2$e_present_condition_code==2|dat1_2$e_present_condition_code==3,"unknown",
                  ifelse(dat1_2$e_present_condition_code==4|dat1_2$e_present_condition_code==5|dat1_2$e_present_condition_code==6,"dead",
                        ifelse(dat1_2$e_present_condition_code==7|dat1_2$e_present_condition_code==8|dat1_2$e_present_condition_code==9|dat1_2$e_present_condition_code==10|dat1_2$e_present_condition_code==11|dat1_2$e_present_condition_code==12|dat1_2$e_present_condition_code==13|dat1_2$e_present_condition_code==14|dat1_2$e_present_condition_code==15|dat1_2$e_present_condition_code==16,"alive",NA)))

dat1_2 <- dat1_2[dat1_2$banding_year>=2006,]

dat5$encounter_month <- NA

dat <- rbind(dat5, dat1_2[,c(1:6,10:12,9)])
write.csv(dat, "C:/Users/avanderlaar/Documents/GitHub/RMark/canada_geese_arkansas.csv", row.names=F)
write.csv(dat1_2, "C:/Users/avanderlaar/Documents/GitHub/RMark/canada_geese_arkansas_bbl.csv", row.names = F)
write.csv(dat5, "C:/Users/avanderlaar/Documents/GitHub/RMark/canada_geese_arkansas_agfc.csv", row.names=F)
