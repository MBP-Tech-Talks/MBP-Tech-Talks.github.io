#!/bin/bash
#
#$ -cwd
#$ -S /bin/bash
#

## This script will run Strelka on a Tumour/Normal pair in a specified
## region of the genome.

module load strelka/1.0.14

## Replace "=/xx/xx/xxx" with paths to input/ouput files specific to
## your working directory:

T_BAM=/path/to/ATumour.bam
N_BAM=/path/to/ANormal.bam
OUT_DIR=/path/and/prefix/to/output/dir
BED_FILE=/path/to/regions.bed
REF=/path/to/hg19_sub.fa
CONFIG_FILE=/path/to/Strelka_config.ini


## make the output directory if it does not already exist
mkdir -p $OUT_DIR

## cd to output dir and run configuration script there
cd $OUT_DIR

configureStrelkaWorkflow.pl \
--normal=$N_BAM \
--tumor=$T_BAM \
--ref=$REF \
--config=$CONFIG_FILE \
--output-dir=$OUT_DIR/myAnalysis

## cd to analysis directory and execute Strelka workflow
cd $OUT_DIR/myAnalysis

make