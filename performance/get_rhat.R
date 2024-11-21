suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(rstan))
    
# define functions
get_rhat <- function(file, summary) {
    if (summary) {
        rhat <- file %>%
            readRDS %>%
            pluck("stan.list") %>%
            map(\(x) x %>%
                         as.data.frame %>%
                         pull(Rhat)) %>%
            combine %>%
            max
    } else {
        rhat <- file %>%
            readRDS %>%
            pluck("stan.list") %>%
            map(\(x) x %>%
                         summary %>%
                         pluck("summary") %>%
                         as.data.frame %>%
                         pull(Rhat)) %>%
            combine %>%
            max
    }
    rhat
}

args <- commandArgs(TRUE)
in.dir <- args[1]
rstan <- args[2]
out.file <- args[3]

file.vec <- in.dir %>%
    list.files(pattern="rds", full.names=TRUE) %>%
    grep("res", ., value=TRUE)

if (rstan == "summary") {
    summary <- TRUE
} else if (rstan == "sample") {
    summary <- FALSE
}    

# get max rhat values across feature-snp pairs
max.rhat <- file.vec %>%
    map_dbl(\(x) get_rhat(x, summary)) %>%
    max

saveRDS(max.rhat, file=out.file)
