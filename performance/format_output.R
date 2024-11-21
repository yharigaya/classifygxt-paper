suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(microbenchmark))

args <- commandArgs(TRUE)
mbm.dir <- args[1]
bm.dir <- args[2]
out.file <- args[3]

# read in the data
mbm.vec <- list.files(mbm.dir, pattern="rds", full.names=TRUE) 
mbm.list <- mbm.vec %>% map(readRDS) 
bm.vec <- list.files(bm.dir, pattern="txt", full.names=TRUE)
bm.list <- bm.vec %>% map(read.delim)

mean <- mbm.list %>%
    map_dbl(
        \(x) x %>%
                 pluck("mbm") %>%
                 pull(time) %>%
                 mean %>%
                 `*`(1e-9))

sd <- mbm.list %>%
    map_dbl(
        \(x) x %>%
                 pluck("mbm") %>%
                 pull(time) %>%
                 sd %>%
                 `*`(1e-9))

mem <- bm.list %>%
    map_dbl(
        \(x) x %>%
                 pull(max_rss))

output <- data.frame(mean=mean, sd=sd, mem=mem)
saveRDS(output, file=out.file)

