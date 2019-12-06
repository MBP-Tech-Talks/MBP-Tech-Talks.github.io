# Installation

conda install cooler matplotlib

# Data

22Rv1.hg19.40kbp.txt.gz contains raw contact counts for chr6 and chr7

# Steps

## Convert raw counts to cooler format

cooler load --assembly hg19 -f coo --one-based hg19.40kbp.bed 22Rv1.hg19.40kbp.txt.gz 22Rv1.cool

## Balance using ICE

cooler balance 22Rv1.cool

## Plot

cooler show -o chr6.raw.png 22Rv1.cool chr6
cooler show -b -o chr6.balanced.png 22Rv1.cool chr6

