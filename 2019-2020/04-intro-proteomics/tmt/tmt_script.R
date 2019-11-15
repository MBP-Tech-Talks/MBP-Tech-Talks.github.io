source("../source_file.R")

rawdata <- read.table("proteinGroups.txt", sep = "\t", header = T, stringsAsFactors = FALSE)

# filter data
df <- pgRemoveRev(rawdata)
df <- pgRemoveCon(df)
df <- pgRemoveIDbySite(df)
df <- pgMinPept(df)

# fractions
fraction_col <- grep("^Fraction.", names(df))

# number of spectra in each fraction
fraction_df <- df[,fraction_col]

# reporter ion intensities (MS2 level quantitation)
reporter_int <- df[, grep("^Reporter.intensity...FKH", names(df))]

reporter_int[reporter_int == 0] <- NA # impute 0 values with NA

reporter_int <- log(reporter_int, 2) # log2 transform

# add protein names
reporter_int$proteins <- df$Majority.protein.IDs
reporter_int$genes <- df$Gene.names

reporter_int <- select(reporter_int, c("proteins", "genes"), everything())

# rename columns
sample_names <- NULL

for (i in 1:10) {
  sample_names[i] <- paste("Sample_", i, sep = "")
}

names(reporter_int) <- c("proteins", "genes", sample_names)

# plot intensities for GAPDH protein
plot_data <- subset(reporter_int, genes == "GAPDH")

m_plot_data <- melt(plot_data, id.vars = c("genes", "proteins"))

ggplot(m_plot_data, aes(variable, value))+
  geom_bar(stat = "identity")+
  labs(title = m_plot_data$genes)

# MS1 peptide intensity (sum of all channels per set)
ms1_int <- df[, grep("^iBAQ", names(df))]

