suppressPackageStartupMessages(library(tidyverse))

args <- commandArgs(TRUE)
ctrl.file <- as.character(args[1])
trt.file <- as.character(args[2])
out.file <- as.character(args[3])

ctrl.mat <- ctrl.file %>% readRDS
trt.mat <- trt.file %>% readRDS

combined.mat <- cbind(ctrl.mat, trt.mat)

saveRDS(combined.mat, file=out.file)

