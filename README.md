# Data and R scripts for the paper  'A Bayesian approach for fitting and comparing demographic growth models of radiocarbon dates: a case study on the Jomon-Yayoi transition in Kyushu, Japan'

This repository contains an updated version of the data and scripts used in the following paper:

Crema, E. R., & Shoda, S. (2021). [A Bayesian approach for fitting and comparing demographic growth models of radiocarbon dates: a case study on the Jomon-Yayoi transition in Kyushu (Japan)](https://doi.org/10.1371/journal.pone.0251695). PLOS ONE, 16(5), e0251695.

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
 [1] oxcAAR_1.0.0        dplyr_1.0.2         latex2exp_0.4.0     coda_0.19-4        
 [5] sp_1.4-5            rnaturalearth_0.2.0 truncnorm_1.0-8     nimbleCarbon_0.1.0 
 [9] nimble_0.10.1       rcarbon_1.4.2       here_0.1           

loaded via a namespace (and not attached):
 [1] spatstat.linnet_2.0-0 tidyselect_1.1.0      xfun_0.22            
 [4] purrr_0.3.4           sf_0.9-6              splines_4.0.3        
 [7] lattice_0.20-41       spatstat.utils_2.1-0  vctrs_0.3.6          
[10] generics_0.1.0        doSNOW_1.0.19         snow_0.4-3           
[13] yaml_2.2.1            mgcv_1.8-31           rlang_0.4.10         
[16] pillar_1.4.7          startup_0.14.1        spatstat.data_2.1-0  
[19] e1071_1.7-4           spatstat_2.0-1        glue_1.4.2           
[22] DBI_1.1.0             foreach_1.5.1         lifecycle_1.0.0      
[25] stringr_1.4.0         spatstat.core_2.0-0   codetools_0.2-16     
[28] knitr_1.31            parallel_4.0.3        class_7.3-17         
[31] Rcpp_1.0.5            KernSmooth_2.23-17    tensor_1.5           
[34] classInt_0.4-3        jsonlite_1.7.2        abind_1.4-5          
[37] deldir_0.2-10         stringi_1.5.3         spatstat.sparse_2.0-0
[40] polyclip_1.10-0       grid_4.0.3            rprojroot_2.0.2      
[43] tools_4.0.3           magrittr_2.0.1        goftest_1.2-2        
[46] tibble_3.0.6          crayon_1.4.1          pkgconfig_2.0.3      
[49] ellipsis_0.3.1        Matrix_1.2-18         httr_1.4.2           
[52] iterators_1.0.13      R6_2.5.0              rpart_4.1-15         
[55] units_0.6-7           spatstat.geom_2.0-1   igraph_1.2.6         
[58] nlme_3.1-148          compiler_4.0.3     
```

### Note
The `nimbleCarbon` package includes the key function for all Bayesian analysis carried out in the manuscript. The package is currently on a github repo and the following command is required for installing the specific version used to generate results and figures:

```
library(devtools)
install_github('ercrema/nimbleCarbon@4706e8f')
```



# Funding
This research was funded by the ERC grant _Demography, Cultural Change, and the Diffusion of Rice and Millets during the Jomon-Yayoi transition in prehistoric Japan (ENCOUNTER)_ (Project N. 801953, PI: Enrico Crema) and by a Philip Leverhulme Prize (PLP-2019-304) in archaeology awarded to Enrico Crema.

# Licence
CC-BY 3.0

