source("D:/Other_projects/MBP_tech_talks/source_file.R")

setwd("D:/Other_projects/MBP_tech_talks/glyco/")

# read in Asn-_AspSites.txt file

rawdata <- pgRead("Asn-_AspSites.txt")

# Filter data
df <- subset(rawdata, Reverse != "+") # remove reversed proteins

# remove glycosites with localization probability < 80%
df <- subset(df, Localization.prob >= 0.8)

# remove glycosites that do not follow consensus sequence - deamidated Asp followed by Ser or Thr in +2 site & Asp cannot be followed by Pro 

head(df$Sequence.window) # sequence containing deamidation, centered around Asp, +/- 15 amino acids
head(df$Asn..Asp.Probabilities) # actual tryptic peptide

deamid <- grep("([N][^P][S|T])", df$Sequence.window)

df <- df[deamid,]

# Grab useful information
glycosites <- df[,c("Sequence.window", "Asn..Asp.Probabilities", "Protein", "Gene.names", "Intensity.glyco1", "Intensity.glyco2")]

glycosites$Gene.names <- toupper(glycosites$Gene.names)

glycosites <- glycosites[order(glycosites$Gene.names),] # order by gene name

head(glycosites)

# get peptides
glycosites$Peptides <- gsub("\\(.+\\)", "", glycosites$Asn..Asp.Probabilities)

# rearrange columns
glycosites <- glycosites[,c("Sequence.window", "Asn..Asp.Probabilities", "Peptides", "Protein", "Gene.names", "Intensity.glyco1", "Intensity.glyco2")]

# get anpep protein
subset(glycosites, Gene.names == "ANPEP")
