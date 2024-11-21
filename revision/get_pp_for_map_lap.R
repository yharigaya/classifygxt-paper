suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(classifygxt))

args <- commandArgs(TRUE)
in.file <- as.character(args[1])
data.file <- as.character(args[2])
out.file <- as.character(args[3])

# read in and process the data
fit.list <- in.file %>% readRDS
data.list <- data.file %>% readRDS

pp <- fit.list %>%
    map(function(x) x$p.m.given.y) %>%
    t %>%
    do.call("rbind", .) %>%
    as.data.frame

index <- data.list %>%
    map_int(function(x) x$index)
model.name <- get_model_names()

pp <- pp %>%
    mutate(correct=model.name[index])

# save the result
saveRDS(pp, file=out.file)

