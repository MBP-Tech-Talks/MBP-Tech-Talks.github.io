---
title: Chromatin conformation capture and the 3D genome
output:
    ioslides_presentation:
        incremental: true
        transition: faster
        css: ../style.css
author: James Hawley
date: 2019-12-06
autosize: true
---

```{r setup, include=FALSE}
options(htmltools.dir.version = FALSE)
```

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
  $('slide:not(.backdrop):not(.title-slide)').append('<div class=\"footnotes\">');

  $('footnote').each(function(index) {
    var text  = $(this).html();
    var fnNum = (index+1).toString();
    $(this).html(fnNum.sup());

    var footnote   = fnNum + '. ' + text + '<br/>';
    var oldContent = $(this).parents('slide').children('div.footnotes').html();
    var newContent = oldContent + footnote;
    $(this).parents('slide').children('div.footnotes').html(newContent);
  });
});
</script>

## Outline | Part 1: Chromatin conformation capture

* The physical role of chromatin organization in the central dogma
* Aberrations of chromatin organization in disease
* Chromatin conformation capture (3C)
* HiC: a genome-wide extension of 3C
* Analytical methods of HiC data

## Outline | Part 2: Workshop

* Quality control of raw HiC data
* Pre-processing HiC data
* Calling TADs

# Chromatin conformation capture

## DNA molecules are three dimensional

* DNA is a double-stranded, helical polymer
* Chromosomes are contiguous strands of DNA
* Long strands folded up to take up small space

## At small scales, DNA has a "beads-on-a-string" structure

Video or pictures from microscopy experiments showing the size of DNA

## Nucleosomes interfere with transcription

Find paper showing PolII needed to move around nucleosomes to transcribe the DNA
Showing that at small scales of ~ 100 bp, shape interferes with central dogma

## Regulation of gene expression is partially mediated by chromatin structure

PolII binds to promoter regions, which initiates transcription
Transcription factors bind to enhancer regions which recruit PolII
Enhancer regions can be 10 - 100 kbp apart from promoter regions
Promoter-enhancer loops brings these loci together to allow of transcription

# Break

# Workshop

# Summary

## Summary

* Spatial organization of chromatin within cells affects gene regulation
* Measurement by sequencing-based techniques
* Pre-processing tools for HiC data

## What I didn't cover

* Microscopy-based measurements
* Compartmentalization
* Inter-sample normalization
* Single-cell extensions
