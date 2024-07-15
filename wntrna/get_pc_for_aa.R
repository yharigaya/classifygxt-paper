suppressPackageStartupMessages(library(tidyverse))

args <- commandArgs(TRUE)
file.in <- as.character(args[1])
file.out <- as.character(args[2])

vst.mat <- file.in %>% readRDS

pca <- vst.mat %>%
    t %>%
    prcomp

saveRDS(pca, file=file.out)

