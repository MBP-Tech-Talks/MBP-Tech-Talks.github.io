---
---
# Instructions for 2019-11-22 DNA methylation analysis workshop

## Software to install

### General software

* `R`
* `Rstudio`

### Command line tools

* samtools
* bedtools
* bwa
* bwameth
* metilene
* fastqc
* methyldackel
* fetchChromSizes
* bedGraphToBigWig
* deeptools

### R packages

* `xaringan`
* `DiagrammeR`
* `knitr`
* `kableExtra`

```R
install.packages(c("xaringan", "DiagrammeR", "knitr", "kableExtra"))
```

### Quick installation using Anaconda

[Anaconda](https://docs.anaconda.com/anaconda/install/) is a software tool to create software environments for Python and R, and to easily install packages.
You can install most of these tools through `bioconda`.
First install a distribution of [Anaconda](https://docs.anaconda.com/anaconda/install/).

Then, create an environment for this workshop by typing in the terminal on of the following, depending on your operating system:

```shell
curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe
curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.pkg
curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```

Run the downloaded file to install Anaconda.
Then, create an environment for this workshop:

```shell
conda create --name bio1
conda activate bio1
conda config --add channels bioconda
conda config --add channels conda-forge
```

Install all the packages by running

```shell
conda install \
    samtools \
    bedtools \
    bwa \
    bwameth \
    metilene \
    fastqc \
    methyldackel \
    fetchChromSizes \
    bedGraphToBigWig \
    deeptools \
    r-xaringan \
    r-diagrammer \
    r-knitr \
    r-kableextra
```

### Windows users

If you only have a Windows machine, you can install a Linux distribution such as Ubuntu on a virtual machine on Windows.
See [here for details](https://www.quora.com/How-do-I-install-Ubuntu-using-VMware-on-Windows-10)

## Data

You can download the zip folder of the workshop slides [here](https://drive.google.com/open?id=1NTfysa8eZ3YE_3kidPvVX2KhxDDIh44c).

In this workshop we won’t have enough time to perform all of the steps, but we will learn about the tools that perform each step of the pipeline.
