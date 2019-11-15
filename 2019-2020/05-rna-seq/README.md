# RNA-seq analysis

`RNA-seq-workshop.R` contains the code to align RNA sequencing data to the human genome (using `Rsubread`) and perform differential expression analysis (using `DESeq2`).
`pcaExplorer` is used to provide an interactive web interface for exploring samples in principal component space, and `clusterProfiler` is used to perform gene set enrichment analysis (GSEA).

The `featureCounts` function for assigning reads to genes requires a genome annotation file.
In the script, it uses `refflat_chr19.gtf` as an example.
In general, one would use a reference annotation for their species of interest that tailors to their subject.

You can download your own reference annotations from the [UCSC Table Browser](https://genome.ucsc.edu/cgi-bin/hgTables), [GENCODE](https://www.gencodegenes.org/), and [RefSeq](https://www.ncbi.nlm.nih.gov/refseq/), as suits your needs.
