#### This scripts prepare the radiocarbon dates downloaded from the "Database of radiocarbon dates published in Japanese archaeological research reports) (URL: https://www.rekihaku.ac.jp/up-cgi/login.pl?p=param/esrd/db_param). 
#### Queries were carried out on the 14th of December 2020 by specifying the Prefectures (Fukuoka, Kagoshima, Miyazaki,Nagasaki, Ooita, and Saga), and by setting "試料分類" (Material Classification) to "T: 陸産物" (Terrestial), and a C14 age interval between 7000 and 0. 
#### Downloaded CSV files were originally encoded in Shift-JIS and re-encoded in UTF-8

#### Load Packages ####
library(dplyr)
library(here)

#### Read CSV Files ####
fukuokaC14 = read.csv(here('data','fukuoka_T_7000_to_0_14122020.csv'))
kagoshimaC14 = read.csv(here('data','kagoshima_T_7000_to_0_14122020.csv'))
kumamotoC14 = read.csv(here('data','kumamoto_T_7000_to_0_14122020.csv'))
miyazakiC14 = read.csv(here('data','miyazaki_T_7000_to_0_14122020.csv'))
nagasakiC14 = read.csv(here('data','nagasaki_T_7000_to_0_14122020.csv'))
ooitaC14 = read.csv(here('data','ooita_T_7000_to_0_14122020.csv'))
sagaC14 = read.csv(here('data','saga_T_7000_to_0_14122020.csv'))


#### Combine into a single data.frame
c14data = rbind.data.frame(fukuokaC14,kagoshimaC14,kumamotoC14,miyazakiC14,nagasakiC14,ooitaC14,sagaC14)

####Define Unique Site Identifier
## No sites unique identifier are provided, but some sites might have different names based on the excavation. 
## Use Address as Unique Identifier
c14data$SiteID = paste0("S",as.numeric(as.factor(c14data$所在地)))

## Eliminate Dates without a Labcode
c14data = subset(c14data,試料番号!="不明") #"不明" is unknown in Japanese

## Fix Errors
# Non numeric C14 Error
c14data=c14data[-which(c14data$C14年代.=='0.4pMC'),]
c14data$C14年代. = as.numeric(c14data$C14年代.)
# Eliminate Overly large C14 Error (>100 years)
c14data=c14data[-which(c14data$C14年代.>100),]

#### Eliminate Dates with the same Lab-Code
c14data$retain=TRUE
any(duplicated(c14data$試料番号)) # Presence of Duplicated Lab-Codes
duplicate.counts = table(c14data$試料番号)
duplicate.counts = duplicate.counts[which(duplicate.counts>1)]
duplicate.names = names(duplicate.counts)

for (i in 1:length(duplicate.names))
{
  tmp.index=which(c14data$試料番号==duplicate.names[i])
  # if dates have the same labcode but different CRA and/or CRA Error, eliminate the samples
  if (length(unique(c14data$C14年代[tmp.index]))>1 |
      length(unique(c14data$C14年代.[tmp.index]))>1 |
      length(unique(c14data$SiteID[tmp.index]))>1)
  {
    c14data$retain[tmp.index]=FALSE
  } else {
    c14data$retain[sample(tmp.index,size=length(tmp.index)-1)]=FALSE
  }
}

c14data = subset(c14data,retain==TRUE)


####Specify Prefecture
c14data$都道府県=recode(c14data$都道府県,"40：福岡県"="Fukuoka","41：佐賀県"="Saga","42：長崎県"="Nagasaki","43：熊本県"="Kumamoto","44：大分県"="Ooita","45：宮崎県"="Miyazaki","46：鹿児島県"="Kagoshima")

####Remove Dates on bones
length(grep("骨",as.character(c14data$試料の種類))) #43 cases
c14data=c14data[-grep("骨",as.character(c14data$試料の種類)),] #Remove Bones

####Determine clear Anthrophic Contexts
anthroContext = '住居|埋葬|竪穴建物|掘立柱|墓|包含層|土坑|ピット|土器|捨場|遺構|炉|人骨|木舟|住|柱|Pit|焼土|カマド|床面|溝中|溝底部|建物跡|木製品|埋土|水田|竪坑|羨道|集石|漆器'
c14data$anthropic=NA
c14data$anthropic[grepl(anthroContext,c14data$サンプル採取地点等)]=TRUE
c14data=subset(c14data,anthropic==TRUE)
####Select only relevant fields
c14data = select(c14data,都道府県,遺跡名,SiteID,試料番号,C14年代,C14年代.)
colnames(c14data) = c("Prefecture","SiteName","SiteID","LabCode","CRA","Error")  

####Save into R image File
save(c14data,file=here('data','c14data.RData'))








