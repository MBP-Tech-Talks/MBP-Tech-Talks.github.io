#!/bin/bash
#
#$ -cwd
#$ -S /bin/bash
#

## This script will run Mutect2 on a Tumour/Normal pair in a specified
## region of the genome. 

module load gatk/4.0.5.1
module load vcftools/0.1.15

## Replace "=/xx/xx/xxx" with paths to input/ouput files specific to
## your working directory:

T_BAM=/path/to/ATumour.bam
N_BAM=/path/to/ANormal.bam
OUT_DIR=/path/and/prefix/to/output/dir
BED_FILE=/path/to/regions.bed
REF=/path/to/hg19_sub.fa

## make the output directory if it does not already exist
mkdir -p $OUT_DIR/tmp

## run mutect2
gatk --java-options "-Xmx8g" Mutect2 \
   -R $REF \
   -I $T_BAM \
   -I $N_BAM \
   -L $BED_FILE \
   -tumor ATumour \
   -normal ANormal \
   -O $OUT_DIR/ATumour_vs_ANormal_mutect2.vcf

## add default filters to mutect2 vcf
 gatk FilterMutectCalls \
   -V $OUT_DIR/ATumour_vs_ANormal_mutect2.vcf \
   -O $OUT_DIR/ATumour_vs_ANormal_mutect2_marked.vcf
 
## remove any variants that failed one or more filters
 vcftools --vcf $OUT_DIR/ATumour_vs_ANormal_mutect2_marked.vcf \
 --recode --recode-INFO-all --remove-filtered-all --out \
 $OUT_DIR/ATumour_vs_ANormal_mutect2_filtered