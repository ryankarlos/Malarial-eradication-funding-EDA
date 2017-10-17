
rm(list = ls())
#.libPaths('C:/Users/ryank/OneDrive/Documents/R/win-library/3.3')# path to R packages uncomment if using Ryan's home comp
.libPaths('C:/Users/ryannazareth/Documents/R/win-library/3.4') ## path to R package - uncomment if on Manta Ray desktop
library('dplyr')
library('tidyr')
library('tidyverse')
library('caret')
library('ggplot2')
library('xlsx')
library('qdap')

df <- read_csv("data-export.csv")
options(warn=-1) 

head(df, 10)

#Encoding(df$Countries) <- "UTF-8"
#enc2utf8(df$Countries)
#Encoding(df$Countries)
df$Countries


df$Funding <- gsub("[[:space:]]", "", df$Funding)



df <- subset(df, select = -c(13) )

print(df$Funding)

c(df$Countries)

for(row in 1:NROW(df$Funding)){
    if(is.null(df$Funding[row])){
        df$Funding[row] <- 'NA'
        }        
   else{
       df$Funding[row] = substring(df$Funding[row],2)   ### removing dollar sign in values in funding column 
        }            
}




for(row in 1:NROW(df)){
    if(is.na(df$Funding_source[row])){
        df$Funding_source[row] <- 'Unknown'
        }    
    if(is.na(df$Funding_information[row])){
        df$Funding_information[row] <- 'Unknown'
        }        
    if(is.na(df$Partner[row])){
        df$Partner[row] <- 'Unknown'
        }
    if(is.na(df$Abstract[row])){
        df$Abstract[row] <- 'Not Listed'
        }
    if(is.na(df$Methodology[row])){
        df$Methodology[row] <- 'Unclassified'
        }
    if(is.na(df$Themes[row])){
        df$Themes[row] <- 'Unclassified'
        }   
    if(is.na(df$Principal_investigator[row])){
        df$Principal_investigator[row] <- 'Unknown'
        }   
    if(is.na(df$Start_date[row])){
        df$Start_date[row] <- 'Unknown'
        }   
    if(is.na(df$End_date[row])){
        df$End_date[row] <- 'Unknown'
        } 
    if(is.na(df$Countries[row])){
        df$Countries[row] <- 'Unknown'
        
    }
}

df$Themes <- beg2char(df$Themes, ",")
df$Methodology <- beg2char(df$Methodology, ",")


#df$Funding[df$Funding != 'NA'] <- strtoi(df$Funding[df$Funding != 'NA'])
#head(df,5)
df$Funding <- as.numeric(df$Funding)

#head(df,100)
sum(df$Funding, na.rm = TRUE)

df$Funding[df$PI_institution == 'IVCC']

#df <- df%>%mutate(Countries = strsplit(Countries,','))%>%unnest(Countries)

#df <- df[df$Countries !='United Republic of',] 
#df <- df[df$Countries !=  'the Democratic Republic of the',]
# df <- subset(df, Countries != "United Republic of" & Countries != "the Democratic Republic of the" )

df <- separate_rows(df, Countries, sep =",")


df$Funding[df$PI_institution == 'IVCC']


df$Countries <- gsub("[[:space:]]", "", df$Countries)

df <- df[df$Countries !=  'theDemocraticRepublicofthe',]
df <- df[df$Countries !='UnitedRepublicof',] 
df$Countries <- gsub("VietNam", "Vietnam", df$Countries)
df$Countries <- gsub("Congo", "DRC", df$Countries)

#write.csv(df, file = "data.csv")
write.xlsx(df, "dataexport_R.xlsx") 

IRdisplay::display_html('<iframe src="https://public.tableau.com/profile/ryan.nazareth#!/vizhome/MESA_v2/MESA_trackDashboard" width=1500, height=1000></iframe> ')


