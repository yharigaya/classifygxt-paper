suppressPackageStartupMessages(library(tidyverse))

args <- commandArgs(TRUE)
file.in <- as.character(args[1])
file.out <- as.character(args[2])

m.vst <- file.in %>% readRDS

pca <- m.vst %>%
    t %>%
    prcomp

saveRDS(pca, file=file.out)

