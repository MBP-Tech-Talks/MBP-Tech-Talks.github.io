---
---
# Workshop

## Installation

```shell
# using Anaconda environments
conda install cooler matplotlib

# using pip
pip install cooler matplotlib
```

## Data

| File                                                                                                                                                       | Description                                                                             |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------- |
| [`22Rv1.hg19.40kbp.txt.gz`](https://github.com/MBP-Tech-Talks/MBP-Tech-Talks.github.io/raw/master/2019-2020/08-3d-genome/workshop/22Rv1.hg19.40kbp.txt.gz) | Raw contact counts for chr6 and chr7 of [GSE118629](https://ncbi.nln.gov/geo/GSE118629) |
| [`hg19.40kbp.bed`](https://github.com/MBP-Tech-Talks/MBP-Tech-Talks.github.io/raw/master/2019-2020/08-3d-genome/workshop/hg19.40kbp.bed)                   | hg19 genome binned into 40kbp bins                                                      |

The contact matrix data is stored in a sparse matrix coordinate (COO) format where $M_{i,j} = v$ for each row whose columns are $(i, j, v)$.

## Steps

### Convert raw counts to cooler format

```shell
cooler load --assembly hg19 -f coo --one-based hg19.40kbp.bed 22Rv1.hg19.40kbp.txt.gz 22Rv1.cool
```

### Balance using ICE

```shell
cooler balance 22Rv1.cool
```

### Plot

```shell
cooler show -o chr6.raw.png 22Rv1.cool chr6
cooler show -b -o chr6.balanced.png 22Rv1.cool chr6
```

Raw chr6 contact matrix

![Raw contact matrix](22Rv1.chr6.raw.png)

Balanced chr6 contact matrix

![Balanced contact matrix](22Rv1.chr6.balanced.png)

## Interactive exploration with Higlass

[Higlass](http://higlass.io) is a tool to interactively view HiC and other genomic data in a web browser.

You can see and interact with some [example Higlass data here](http://higlass.io/l/?d=YE8GZYBBSsaBErYopy8_9g).
