### Data Prep 
library(rcarbon)
library(here)
load(here('data','c14data.RData'))

# Calibrate and Pre-Process Data ####
obs.caldates = calibrate(c14data$CRA,c14data$Error,calCurves = 'intcal20')
# Consider samples that have a probability mass over 0.8 within 3400 and 1850, ca. #Late Jomon to End of Middle Yayoi. (n=266)
obs.caldates = subset(obs.caldates,BP<3400&BP>1850,p=0.8)
# Extract relevant CRA and CRAErrors
CRA=obs.caldates$metadata$CRA
Errors=obs.caldates$metadata$Error
# Extract Median Calibrated Dates
medDates = medCal(obs.caldates)
# Save to R Image
save(obs.caldates,medDates,CRA,Errors,file=here('R_images','cleaned_data.RData'))

