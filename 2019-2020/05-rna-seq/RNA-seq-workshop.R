
# About -------------------------------------------------------------------
#MBP Tech Talk
#Topic: RNA-seq analysis using R
#Instructor: Musa Ahmed
#Email: musaddeque.ahmed@gmail.com
#R versions tested: 3.3.1 and 3.3.2
#Rstudio versions tested: 0.99 and 1.0.136


# Load Libraries ---------------------------------------------------------------
#Try loading these libraries to check if they installed properly.
#If any library fails to load, please try to install that library from above.

library(Rsubread)
library(DESeq2)
library("ReportingTools")
#library("GOstats")
#library("org.Hs.eg.db")
library("pcaExplorer")
library("pheatmap")
library("RColorBrewer")

# Alignment ---------------------------------------------------------------
setwd("./")

#build index for the reference fasta file. Needs to be done just once.
#Replace chr19.fa with your whole genome fasta file, e.g., hg19.fa and 
#change the basename accordingly
buildindex(basename="chr19",reference="chr19.fa")

#alignment
#for paired end sample, the two pairs are given readfile1 and 2.
#for single end, do not use readfile2.
subjunc(index="chr19",
      readfile1="adrenal_rep1_1.fastq.gz", 
      readfile2 = "adrenal_rep1_2.fastq.gz", 
      input_format="gzFASTQ",
      output_format="BAM",
      output_file="adrenal_rep1.bam",
      unique=TRUE,
      indels=5,
      maxMismatches = 3,
      nthreads = 1,
      reportAllJunctions = TRUE)
subjunc(index="chr19",
        readfile1="adrenal_rep2.fastq.gz",
        input_format="gzFASTQ",
        output_format="BAM",
        output_file="adrenal_rep2.bam",
        unique=TRUE,
        indels=5,
        maxMismatches = 3,
        nthreads = 1,
        reportAllJunctions = TRUE)
subjunc(index="chr19",
        readfile1="brain_rep1_1.fastq.gz", 
        readfile2 = "brain_rep1_2.fastq.gz", 
        input_format="gzFASTQ",
        output_format="BAM",
        output_file="brain_rep1.bam",
        unique=TRUE,
        indels=5,
        maxMismatches = 3,
        nthreads = 1,
        reportAllJunctions = TRUE)
subjunc(index="chr19",
        readfile1="brain_rep2.fastq.gz", 
        input_format="gzFASTQ",
        output_format="BAM",
        output_file="brain_rep2.bam",
        unique=TRUE,
        indels=5,
        maxMismatches = 3,
        nthreads = 1,
        reportAllJunctions = TRUE)


#make a list of the bam files.
#You can also use bam files produced by other aligners.
bams <- c("adrenal_rep1.bam","adrenal_rep2.bam","brain_rep1.bam","brain_rep2.bam")
#You can also save the list of input (fastq) and outputs (bams) in a file and load the file:
#samples <- read.csv("samples.csv", header=T)

# Feature counting --------------------------------------------------------

#featureCounts will count the number of reads on the features (e.g., genes)
#from the annotation file. This is same as htseq-count.
#annot.inbuilt will use the RefSeq annotations.
#There are four genomes currently available for annot.inbuilt: hg19, hg38, mm9 and mm10.
#?featureCounts
#Check allowMultiOverlap (for lncRNA analysis), useMetaFeatures,
#strandSpecific (for stranded RNA-seq), isPairedEnd, nthreads
fc <- featureCounts(files=bams,annot.inbuilt="hg19")

#In certain situations, you may want to use your own annotation file.
#For example, when you are working with noncoding RNAs, you may want to
#use Gencode or ENSEMBL annotation. In that case, you can provide your own
#annotation file by annot.ext parameter. Make sure your annotation file is gtf
#which you can download from the Table Browser of UCSC browser.
fc <- featureCounts(files=bams, annot.ext = "refflat_chr19.gtf", isGTFAnnotationFile = TRUE)

#check basic statistics. If you have large number of unmapped reads,
#you may want to check your fastQC.
fc$targets <- c("adrenal_rep1","adrenal_rep2","brain_rep1","brain_rep2")
colnames(fc$counts) <- fc$targets
colnames(fc$stat) <- fc$targets

#save fc object
save(fc, file="fc.Rdata")

#Before moving on to use DESeq2, you need to create a dataframe with
#sample information. Row names of this dataframe should be your input bam files.
colData <- data.frame(bam = fc$targets, Tissue=c(rep("Adrenal",2), rep("Brain", 2)), row.names = 1)

#Now you are ready to create your DESeq dataset! At this stage, you can use
#any count matrix outputted by any other quantification method, e.g., htseq-count, RSEM etc.
#The design parameter indicates the contrast to calculate the differential expression.
dds <- DESeqDataSetFromMatrix(countData = fc$counts, colData = colData, design = ~ Tissue)
#The raw counts are still saved in your dds object, which can be retrieved by
#counts(dds)
#colData(dds)

##parallel for larger sample size (>100)
##installation
#install.packages("BiocParallel")
#library("BiocParallel")
#register(MulticoreParam(4))


# Prefiltering the data ---------------------------------------------------

#It is often important to prefilter your data before performing the DE analysis.
#For example, you should remove the very lowly expressed genes.
dds <- dds[ rowSums(counts(dds)) > 1, ]


# Differential expression -------------------------------------------------
#DESeq combines multiple steps to calculate the differential expression analysis.
#?DEseq
dds <- DESeq(dds)
#save the normalized counts
write.csv(counts(dds, normalized=T), file="exp_normalized.csv", quote = F)

#The results can be obtained by results function. alpha is the FDR cutoff.
res <- results(dds, alpha = 0.1)
resOrdered <- res[order(res$padj),]
summary(res)
#to check significantly differentiated genes
resSig <- subset(resOrdered, padj < 0.1)
#Saving the result in a file that can be opened in excel
write.csv(as.data.frame(resOrdered), file="DE_result.csv", quote = F)

#transofmration of the data is preferred for visualization and other anlaysis
#of the data, e.g., clusterization. Regularized log (rlog) is a good choice:
rld <- rlog(dds, blind=FALSE)
#?rlog and check the parameter blind.
#The other method is varianceStabilizingTransformation
#saving transformed value:
write.csv(assay(rld), file="exp_transformed.csv", quote = F)



# Reporting the analysis --------------------------------------------------
pcaExplorer(dds = dds, dst = rld)
#or reportingTools
des2Report <- HTMLReport(shortName = 'RNAseq_analysis_with_DESeq2',
                         title = 'RNA-seq analysis of differential expression using DESeq2',
                         reportDirectory = "./reports")
publish(dds,des2Report, pvalueCutoff=0.05,
          annotation.db=NULL, factor = colData(dds)$Tissue,
          reportDir="./reports")
finish(des2Report)


####Exploring data####

# MA plot -----------------------------------------------------------------
#MA plot is a popular method to visualize differential expression analysis.
#M stands for log fold change and A for mean expression.

plotMA(res, main="MA Plot")
#limit Y-axis range to see the data better
plotMA(res, main="MA Plot", ylim=c(-2,2))
#Increase the point size
plotMA(res, main="MA Plot", ylim=c(-2,2), cex = 1.5)
#To select a gene from the plot, we can use the function identify
idx <- identify(res$baseMean, res$log2FoldChange)
#and get gene name
rownames(res)[idx]


# Sample clustering -------------------------------------------------------

sampleDists <- dist(t(assay(rld)))
sampleDistMatrix <- as.matrix(sampleDists)
rownames(sampleDistMatrix) <- rld$Tissue
colnames(sampleDistMatrix) <- NULL
colors <- colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)
pheatmap(sampleDistMatrix,
         clustering_distance_rows=sampleDists,
         clustering_distance_cols=sampleDists,
         col=colors)

# PCA ---------------------------------------------------------------------

plotPCA(rld, intgroup = "Tissue")


# GSEA analysis -------------------------------------------------------------

#library(XML)
#library(GSEABase)
library(clusterProfiler)

#make a list of genes to use for geneset enrichment analysis
#the genes need to be sorted by some value, e.g., fold change, p value etc
gene_list <- res[res$pvalue<=0.05, 'log2FoldChange']
names(gene_list) <- row.names(res[res$pvalue<=0.05, ])
gene_list <- gene_list[order(gene_list, decreasing = T)]

#download gene sets from mSigDb
#http://software.broadinstitute.org/gsea/msigdb/collections.jsp
h <- read.gmt("~/Documents/DB/c5.all.v6.2.symbols.gmt")
h <- read.gmt("~/Documents/DB/c5.bp.v6.2.symbols.gmt")
h <- read.gmt("~/DB/h.all.v6.1.symbols.gmt")
enr <- enricher(names(gene_list), TERM2GENE=h, universe = row.names(res), pvalueCutoff = 1, qvalueCutoff = 1, minGSSize = 2)

write.csv(enr@result, file = "GSEA.c5.all.csv", quote = F, row.names = F)
barplot(enr, showCategory = 10, cex.main = 1, cex.axis = 0.8, cex.lab = 1,
        main = "sgPromoter downregulated genes")

# Heatmap of gene counts --------------------------------------------------

df <- as.data.frame(colData(dds)[,"Tissue"], row.names = row.names(colData(dds)))
colnames(df) <- "Tissue"
pheatmap(assay(rld)[names(gene_list),], cluster_rows=FALSE, show_rownames=TRUE,
         cluster_cols=FALSE, annotation_col=df)
