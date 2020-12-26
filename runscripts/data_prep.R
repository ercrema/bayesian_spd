### Data Prep 
library(rcarbon)
library(here)
load(here('data','c14data.RData'))

# Calibrate and Pre-Process Data ####
obs.caldates = calibrate(c14data$CRA,c14data$Error,calCurves = 'intcal20')
# Consider samples that have a probability mass over 0.8 within 3400 and 1850, ca. #Late Jomon to End of Middle Yayoi. (n=266)
index = which.CalDates(obs.caldates,BP<3400&BP>1850,p=0.8)
obs.caldates = obs.caldates[index]
# Extract relevant CRA and CRAErrors
CRA=c14data$CRA[index]
Errors=c14data$Error[index]
SiteID = c14data$SiteID[index]
LabCode = c14data$LabCode[index]
# Extract Median Calibrated Dates
medDates = medCal(obs.caldates)
# Save to R Image
obs.data = data.frame(LabCode=LabCode,CRA=CRA,Error=Errors,MedCalDate=medDates,SiteID=SiteID)
save(obs.data,obs.caldates,file=here('R_images','cleaned_data.RData'))

