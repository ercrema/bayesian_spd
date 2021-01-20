# Data and R scripts for the manuscript  'A Bayesian approach for fitting and comparing demographic growth models of radiocarbon dates: a case study on the Jomon-Yayoi transition in Kyushu, Japan'

This repository contains an updated version of the data and scripts used in the following manuscript.

Crema, E.R. and Shoda, S. 2021. A Bayesian approach for fitting and comparing demographic growth models of radiocarbon dates: a case study on the Jomon-Yayoi transition in Kyushu, Japan.

The repository is organised into four main directories: [data](./data), [runscripts](./runscripts), [R_images](./R_images), and [manuscript](./manuscript). The [data](./data) directory contains the the raw data used for the case study, the [runscripts](./runscripts) contains all script for generating the simulated data as well as running the core Bayesian analyses, the [R_images](./R_images) directory includes all  R Image files of all outputs, and finally R scripts for generating figures and tables for the manuscript are included in [manuscript](./manuscript). 

## Case Study
### Data Sets and Data Preparation
All raw data used in the paper can be found in the [data](./data) directory. This contains the original CSV files of radiocarbon dates downloaded from the National Museum of Japanese History's [Database of radiocarbon dates published in Japanese archaeological research reports](https://www.rekihaku.ac.jp/up-cgi/login.pl?p=param/esrd/db_param), and R script file [bindC14csv.R](./data/bindC14csv.R) used pre-process the data with the output stored in the R image file [c14data.RData](./data/c14data.RData). The script file [data_prep.R](./runscripts/data_prep.R) provides an additional set of routine for calibrating and sub-setting dates for the main Bayesian analysis. Results are stored in the R image file  [cleaned_data.RData](./R_images/cleaned_data.RData).

### Bayesian Analysis
Scripts for the Bayesian Analyses of three growth models are contained in the files [mcmc_m1.R](./runscripts/mcmc_m1.R), [mcmc_m2.R](./runscripts/mcmc_m2.R), and [mcmc_m3.R](./runscripts/mcmc_m3.R). Resulting MCMC posterior samples are stored in the R image files [mmcmc.m1.samples.RData](./R_images/mcmc.m1.samples.RData), [mcmc.m2.samples.RData](./R_images/mcmc.m2.samples.RData), and [mcmc.m3.samples.RData](./R_images/mcmc.m3.samples.RData). Notice that given the large number of MCMC samples the processing time of each script is considerably long. R scripts for the MCMC diagnostics and posterior predictive check are included in the file [MCMC_diagnostic_and_ppcheck.R](./runscripts/MCMC_diagnostic_and_ppcheck.R).

## Simulation Experiments
Scripts for generating simulated data for each experiment as well as the associated Bayesian analyses are contained in the files: [experiment1.R](./runscripts/experiment1.R), [experiment2.R](./runscripts/experiment2.R), [experiment3a.R](./runscripts/experiment3a.R), [experiment3b.R](./runscripts/experiment3b.R), and [experiment4.R](./runscripts/experiment4.R). Results of each experiment are stored in the R image files: [experiment1_results.RData](./R_images/experiment1_results.RData), [experiment2_results.RData](./R_images/experiment2_results.RData), [experiment3a_results.RData](./R_images/experiment3a_results.RData), [experiment3b_results.RData](./R_images/experiment3b_results.RData), and [experiment4_results.RData](./R_images/experiment4_results.RData).

## Figures, Tables, and Supplementary Materials
Figures and raw data required for relevant tables, as well as R scripts required for generating them are contained in relevant sub-directory inside [manuscript](./manuscript). All figures and tables require the analyses output stored in 
the [R_images](./R_images) directory.

# File Structure
```
.
├── data
│   ├── bindC14csv.R
│   ├── c14data.RData
│   ├── fukuoka_T_7000_to_0_14122020.csv
│   ├── kagoshima_T_7000_to_0_14122020.csv
│   ├── kumamoto_T_7000_to_0_14122020.csv
│   ├── miyazaki_T_7000_to_0_14122020.csv
│   ├── nagasaki_T_7000_to_0_14122020.csv
│   ├── ooita_T_7000_to_0_14122020.csv
│   └── saga_T_7000_to_0_14122020.csv
├── manuscript
│   ├── figures
│   │   ├── figure1.tiff
│   │   ├── figure2.tiff
│   │   ├── figure3.tiff
│   │   ├── figure4.tiff
│   │   ├── figure5.tiff
│   │   ├── figure6.tiff
│   │   ├── figure7.tiff
│   │   ├── figure8.tiff
│   │   ├── figure9.tiff
│   │   └── main_figures.R
│   ├── supplementary_figures
│   │   ├── figureS1.pdf
│   │   ├── figureS2.pdf
│   │   ├── figureS3.pdf
│   │   ├── figureS4.pdf
│   │   ├── figureS5.pdf
│   │   ├── figureS6.pdf
│   │   ├── figureS7.pdf
│   │   └── supplementary_figures.R
│   └── tables
│       ├── main_tables.R
│       ├── table2.csv
│       └── table3.csv
├── README.md
├── R_images
│   ├── cleaned_data.RData
│   ├── experiment1_results.RData
│   ├── experiment2_results.RData
│   ├── experiment3a_results.RData
│   ├── experiment3b_results.RData
│   ├── experiment4_results.RData
│   ├── mcmc_diagnostics_and_ppcheck.RData
│   ├── mcmc.m1.samples.RData
│   ├── mcmc.m2.samples.RData
│   └── mcmc.m3.samples.RData
└── runscripts
    ├── data_prep.R
    ├── experiment1.R
    ├── experiment2.R
    ├── experiment3a.R
    ├── experiment3b.R
    ├── experiment4.R
    ├── MCMC_diagnostic_and_ppcheck.R
    ├── mcmc_m1.R
    ├── mcmc_m2.R
    └── mcmc_m3.R

```
# Required R packages

```
attached base packages:
[1] stats     graphics  grDevices utils     methods   base     

other attached packages:
 [1] oxcAAR_1.0.0       coda_0.19-4        mapdata_2.3.0      GISTools_0.7-4     rgeos_0.5-3       
 [6] MASS_7.3-51.6      RColorBrewer_1.1-2 maps_3.3.0         maptools_1.0-1     rworldmap_1.3-6   
[11] sp_1.4-4           truncnorm_1.0-8    dplyr_1.0.2        latex2exp_0.4.0    nimbleCarbon_0.1.0
[16] nimble_0.10.1      rcarbon_1.4.1      here_0.1          

loaded via a namespace (and not attached):
 [1] spam_2.5-1            tidyselect_1.1.0      xfun_0.19             purrr_0.3.4          
 [5] splines_4.0.3         lattice_0.20-41       spatstat.utils_1.17-0 vctrs_0.3.5          
 [9] generics_0.1.0        doSNOW_1.0.19         htmltools_0.5.0       snow_0.4-3           
[13] yaml_2.2.1            mgcv_1.8-31           rlang_0.4.8           startup_0.14.1       
[17] spatstat.data_1.7-0   pillar_1.4.7          foreign_0.8-80        spatstat_1.64-1      
[21] glue_1.4.2            foreach_1.5.1         lifecycle_0.2.0       stringr_1.4.0        
[25] dotCall64_1.0-0       fields_10.3           codetools_0.2-16      evaluate_0.14        
[29] knitr_1.30            parallel_4.0.3        tensor_1.5            jsonlite_1.7.1       
[33] abind_1.4-5           deldir_0.2-3          digest_0.6.27         stringi_1.5.3        
[37] polyclip_1.10-0       grid_4.0.3            rprojroot_2.0.2       tools_4.0.3          
[41] magrittr_2.0.1        goftest_1.2-2         tibble_3.0.4          crayon_1.3.4         
[45] pkgconfig_2.0.3       ellipsis_0.3.1        Matrix_1.2-18         rmarkdown_2.3        
[49] rstudioapi_0.13       iterators_1.0.13      R6_2.5.0              rpart_4.1-15         
[53] igraph_1.2.6          nlme_3.1-148          compiler_4.0.3    
```

### Note
The `nimbleCarbon` package includes the key function for all Bayesian analysis carried out in the manuscript. The package is currently on a private repo and the following command is required for its installation:
```
library(devtools)
install_github('ercrema/nimbleCarbon@v0.1-beta.0')
```

# Funding
This research was funded by the ERC grant _Demography, Cultural Change, and the Diffusion of Rice and Millets during the Jomon-Yayoi transition in prehistoric Japan (ENCOUNTER)_ (Project N. 801953, PI: Enrico Crema) and by a Philip Leverhulme Prize in archaeology awarded to Enrico Crema.

# Licence
CC-BY 3.0

