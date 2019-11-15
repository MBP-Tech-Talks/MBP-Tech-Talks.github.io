library("ggplot2")
library("reshape2")
library("data.table")

#'-------------------------------------------------------------------------------------------
#' Read ProteinGroup.txt file
#'-------------------------------------------------------------------------------------------
pgRead <- function(file) {
  pg <- data.frame(fread(file, sep="\t", header=T, stringsAsFactors=FALSE, integer64 = "numeric", data.table = FALSE))
  rownames(pg) <- pg$id
  return(pg)
} 

#'-------------------------------------------------------------------------------------------
#' Remove reversed protein
#'-------------------------------------------------------------------------------------------
pgRemoveRev <- function(pg) {
  if (sum(!is.na(pg$Reverse))==0 | sum(pg$Reverse=="+")==0) {
    print("No revesed protein to be removed ... ")
  } else {
    pg <- pg[(!pg$Reverse=="+"),]
  }
  return(pg)
}

#'-------------------------------------------------------------------------------------------
#' Remove potential contaminant
#'-------------------------------------------------------------------------------------------
pgRemoveCon <- function(pg) {
  if (sum(!is.na(pg$Potential.contaminant))==0 | sum(pg$Potential.contaminant=="+")==0) {
    print("No contaminant protein to be removed ... ")
  } else {
    pg <- pg[(!pg$Potential.contaminant=="+"),]
  }
  return(pg)
}

#'-------------------------------------------------------------------------------------------
#' Remove only identified by site
#'-------------------------------------------------------------------------------------------
pgRemoveIDbySite <- function(pg) {
  if (sum(!is.na(pg$Only.identified.by.site))==0 | sum(pg$Only.identified.by.site=="+")==0) {
    print("No Only.identified.by.site protein to be removed ... ")
  } else {
    pg <- pg[(!pg$Only.identified.by.site=="+"),]
  }
  return(pg)
}

#'-------------------------------------------------------------------------------------------
#' Filter by minimum number of peptides
#'-------------------------------------------------------------------------------------------
pgMinPept <- function(pg, n=2){
  ru <- pg[grep("Razor...unique.peptides.", colnames(pg))]
  pg <- pg[apply(ru>=n, 1, sum)>0,]
  return(pg)
}

#'-------------------------------------------------------------------------------------------
#' Get columns with LFQ Intensity from ProteinGroup dataframe
#'-------------------------------------------------------------------------------------------
pgGetLFQ <- function(pg) {
  lfq <- pg[grep("LFQ.intensity.", colnames(pg))]
  colnames(lfq) <- gsub("LFQ.intensity.", "", colnames(lfq)) 
  return(lfq)
}

#'-------------------------------------------------------------------------------------------
#' Get columns with iBAQ from ProteinGroup dataframe
#'-------------------------------------------------------------------------------------------
pgGetiBAQ <- function(pg) {
  ibaq <- pg[grep("iBAQ.", colnames(pg))]
  colnames(ibaq) <- gsub("iBAQ.", "", colnames(ibaq)) 
  return(ibaq)
}

#'-------------------------------------------------------------------------------------------
#' Impute from lower distribution (Perseus method)
#'-------------------------------------------------------------------------------------------
imputeLD <- function(data, shift=1.8, size=0.2) {
  set.seed(8)
  data[data==0]<-NA
  mdf <- melt(data, na.rm=T)
  n<-round(dim(mdf)[1])
  sdev <- sd(mdf$value)
  m <- mean(mdf$value) - (sdev * shift)
  d<-rnorm(n*size, mean=m, sd=sdev*size)
  data[is.na(data)] <- d[round(runif(sum(is.na(data)),1,n*size))]
 return(data)
}

#'-------------------------------------------------------------------------------------------
#' Transform data either Log2 or Log10
#'-------------------------------------------------------------------------------------------
transform <- function(data, base="log2", na=F) {
  data[data==0] <- NA
  if (base=="log2") {
    data <- log2(data)
  } else if (base=="log10") {
    data <- log10(data)
  }
  if (na==F) {
    data[is.na(data)]<-0
  }
  return(data)
}

getInfo <- function(x) {
  genes <- as.data.frame(str_split_fixed(x$Gene.names, ";", 2))$V1
  main.isoform <- as.data.frame(str_split_fixed(x$Majority.protein.IDs, ";", 2))$V1
  
  minor.isoforms <- as.data.frame(str_split_fixed(x$Majority.protein.IDs, ";", 2))$V2
  
  protein <- as.data.frame(str_split_fixed(main.isoform, "-", 2))$V1
  
  protein.names <- x$Protein.names
  
  rzr.uniq.pep <- grep("^Razor...unique.peptides", names(x))
  
  unique.peptides <- x[,rzr.uniq.pep]
  
  id <- cbind.data.frame(genes, protein, main.isoform, minor.isoforms, protein.names, unique.peptides)
  
  return(id)
}
