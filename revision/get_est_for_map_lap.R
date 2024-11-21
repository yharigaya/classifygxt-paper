suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(classifygxt))

args <- commandArgs(TRUE)
data.file <- as.character(args[1])
lnpy.file <- as.character(args[2])
in.dir <- as.character(args[3])
out.file <- as.character(args[4])

# read in the sum of the log marginal likelihood
ln.p.y <- lnpy.file %>% readRDS
opt <- rownames(ln.p.y)[which.max(ln.p.y$ln.p.y)]

fit.file <- file.path(in.dir, opt, "fit.rds") 
fit.list <- fit.file %>% readRDS

data.list <- data.file %>% readRDS

# get the true parameter values
# note that sigma equals 1
truth <- data.list %>%
    map(\(x) pluck(x, "beta")) %>%
    bind_rows %>%
    dplyr::select(c(b1, b2, b3)) %>%
    pivot_longer(everything()) %>%
    `colnames<-`(c("name1", "value1"))

# get parameter estimates for the MAP model
# relative to sigma
est <- fit.list %>%
    map(get_est) %>%
    bind_rows %>%
    mutate(b1=b1 / sigma) %>%
    mutate(b2=b2 / sigma) %>%
    mutate(b3=b3 / sigma) %>%
    dplyr::select(c(b1, b2, b3)) %>%
    pivot_longer(everything()) %>%
    `colnames<-`(c("name2", "value2"))

# all(pull(truth, name1) == pull(est, name2))

d <- bind_cols(truth, est) %>%
    dplyr::select(c(name1, value1, value2)) %>%
    `colnames<-`(c("param", "truth", "est"))

saveRDS(d, file=out.file)



