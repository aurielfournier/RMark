# RMark


I am working on using RMark to script analysis through Program Mark to analyze population growth of Canada Geese (*Branta canadensis*) in Arkansas. 

Some of these scripts are going over examples from the RMark documentation. 
> Dipper.R  
RMark_Workshop.R

### Generating Capture Histories

This was something I struggled with intially, esp since I wasn't able to understand how RMark wants you to do it within the package. 

encounter_histories.R goes through how to make 'regular' and 'live dead recovory' encounter histories for RMark

if you want to generate inputs for Program Mark you'll want the 'encounter_histories_for_program_mark.R" there are some differences. 

### Lincoln Estimator

lincoln_cago.R goes over a basic lincoln model for these data, more as exploratory data analysis then anything else. 


### Live-Dead Mark Recapture Analysis
The three files beginning with "Fournier" (my last name) are the raw files of data from the Bird Banding Lab.   
> Fournier_bnds_CAGO_AR_2014.csv is all Canada Geese banded in Arkansas as of December 2014  
Fournier_encs_from_AR_2000_2014.csv is all Canada Geese encountered outside of Arkansas which were banded in Arkansas from 2000-2014  
Fournier_encs_to_AR_2014.csv is all Canada Geese encountered in Arkansas that were banded outside of Arkansas. 

The pdfs (I know, I know, data in pdfs) is just me archiving stuff from when this project was handed over to me, I wouldn't pay any attention to them, but they are here if you want them for whatever reason. I'm not entirely sure what data they contain, since this project did not arrive in my hands with good documentation. 

canada_geese_arkansas.csv is the master file of Canada Geese which were either banded in Arkansas or banded elsewhre and recovered here. It is a very slimmed down version of the above files. It was created with 
formatting_raw_data.R

### Known-fate Analysis 

There are also some files in here from some known-fate modeling I am doing on Sora (*Porzana carolina*). That project, is evolving, and will hopefully be better documented soon. 

I'm still stumbling through much of this myself, but if you have questions, email, submit an issue or pull request. (aurielfournier@gmail.com, @Rallidaerule - twitter)
