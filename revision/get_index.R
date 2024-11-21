# get indices for nan for each scenario across methods
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(classifygxt))

args <- commandArgs(TRUE)
in.dir <- as.character(args[1])
out.file <- as.character(args[2])

method.vec <- c("nl", "lm", "rint")
file.vec <- file.path(in.dir, method.vec, "opt", "pp.rds")

pp.list <- file.vec %>% map(readRDS)

index.vec <- pp.list %>%
    map(\(x) apply(x, 1, function(y) any(is.na(y))) %>% which) %>%
    list_c

saveRDS(index.vec, file=out.file)
