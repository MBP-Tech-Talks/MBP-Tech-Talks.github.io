# References summary

The only file missing from this directory is `hg19_sub.fa`, a reduced reference genome consisting of `chr1`, `chr11`, and `chr17`, because it is too large for version control.
This can be created by downloading the hg19 reference chromosomes from [UCSC](https://hgdownload.soe.ucsc.edu/goldenPath/hg19/chromosomes/), and concatenating these three chromosomes into `hg19_sub.fa`.

```shell
curl -O https://hgdownload.soe.ucsc.edu/goldenPath/hg19/chromosomes/chr1.fa.gz
curl -O https://hgdownload.soe.ucsc.edu/goldenPath/hg19/chromosomes/chr11.fa.gz
curl -O https://hgdownload.soe.ucsc.edu/goldenPath/hg19/chromosomes/chr17.fa.gz

zcat chr{1,11,17}.fa.gz > hg19_sub.fa
```
