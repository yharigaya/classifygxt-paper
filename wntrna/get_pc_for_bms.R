suppressPackageStartupMessages(library(tidyverse))

args <- commandArgs(TRUE)
in.file <- as.character(args[1])
pca.file <- as.character(args[2])

# read in the data
vst.mat <- in.file %>% readRDS

# get the treatment indicator
n <- ncol(vst.mat) / 2
t <- rep(c(0, 1), each=n)

# regress out the treatment indicator
rsd.mat <-
    apply(vst.mat, 1, function(x) residuals(lm(x ~ 1 + t)))

# perform pca
pca <- prcomp(rsd.mat)

saveRDS(pca, file=pca.file)
