# GastRo
R scripts for visualization and exploratory data analysis of diet/microbiome data


#Dependencies
The following packages are required. Packages can be installed and loaded using the following commands:

``` 
source("https://bioconductor.org/biocLite.R")
biocLite("phyloseq")
packs <- c("ggthemes","Hmisc","RColorBrewer","ggplot2","openxlsx",
           "phyloseq","pdftools","biom","stringr","reshape2","data.table") 
lapply(packs, install.packages, character.only = TRUE) 
lapply(packs, library, character.only = TRUE) 

``` 

#Example Data

The data used in this example comes from a long-term diet and microbiome study published in late 2011:

Wu, Gary D. Jun Chen, Christian Hoffmann, Kyle Bittinger, Ying-Yu Chen, Sue A. Keilbaugh, Meenakshi Bewtra, Dan Knights, William A. Walters, Rob Knight, Rohini Sinha, Erin Gilroy, Kernika Gupta, Robert Baldassano, Lisa Nessel, Hongzhe Li, Frederic D. Bushman, James D. Lewis. (2011) *Linking Long-Term Dietary Patterns with Gut Microbial Enterotypes* ***Science***, 334 (6052), 105–108. 

For convenience and stability I downloaded these data files and saved the uncompressed files locally within the GastRo data repository. They are called by the executable `combo.gastro.r`

Thse datasets are publicly available on the open-source Qiita platformn (https://qiita.ucsd.edu/). As of 2016-November-11 they could be accessed at https://qiita.ucsd.edu/study/description/1011 under the name bushman_enterotypes_COMBO, with study_1011 as an alternative index. Qiita may require you to create a free log in account before you can download from this link. Since I am not affiliated with Qiita I cannot guarantee the future availability of these files.

#Usage

In R, set `gastro` to the root of this current directory

A sample executable `combo.gastro.r` is located in the `bin` directory

#Sample output

All results are written to the output directory

<img src="https://github.umn.edu/robi0916/GastRo/blob/master/output/heatmap.png" alt="gastro-heatmap">




