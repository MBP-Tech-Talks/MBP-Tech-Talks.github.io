# set working directory
setwd("D:/Other_projects/MBP_tech_talks/lfq/")

# Load source file
source("D:/Other_projects/MBP_tech_talks/source_file.R")

# read in proteinGroups.txt file
rawdata <- read.table("proteinGroups.txt", stringsAsFactors = FALSE, sep = "\t", header = TRUE)

# view dimensions
dim(rawdata)

# view column name
names(rawdata)

# remove false hits

df <- pgRemoveRev(rawdata)
df <- pgRemoveCon(df)
df <- pgRemoveIDbySite(df)

# set minimum 2 peptide threshold
df <- pgMinPept(df)

# get lfq intensity
lfq <- pgGetLFQ(df)

# impute 0 with NA
lfq[lfq == 0] <- NA

# add protein names
lfq$proteins <- df$Majority.protein.IDs

lfq <- select(lfq, "proteins", everything()) # move proteins column to the first column

# plot histogram of intensities

m_lfq <- melt(lfq, id.vars = "proteins")

ggplot(m_lfq, aes(value, color = variable))+
  geom_density()

# log-2 transform data
lfq[-1] <- log(lfq[-1], 2)

#'------------------ DATA QUALITY CHECK --------------------------------#

rsq_annot <- summary(lm(lfq$WCL_22Rv1_1 ~ lfq$WCL_22Rv1_2))$r.sq
rsq_round <- paste("R-squared = ", round(rsq_annot, 2), sep = "")

ggplot(lfq, aes(lfq$WCL_22Rv1_1, lfq$WCL_22Rv1_2))+
  geom_point(shape = 1, alpha = 0.5)+
  annotate("text", x = 20, y = 35, label = rsq_round, size = 5)
