suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(classifygxt))

args <- commandArgs(TRUE)
data.file <- as.character(args[1])
tu.lambda.file <- as.character(args[2])
seed <- as.integer(args[3])
phi1 <- as.numeric(args[4])
phi2 <- as.numeric(args[5])
phi3 <- as.numeric(args[6])
method <- as.character(args[7])
ranef <- as.character(args[8])
out.file <- as.character(args[9])

# read in the data
data.list <- data.file %>% readRDS

# specify model prior
p.m <- rep(1/8, 8)

phi <- c(phi1, phi2, phi3)
computation <- "map.lap"

if (ranef == "ranef") {
    ranef <- TRUE
    tu.lambda <- tu.lambda.file %>% readRDS
} else if (ranef == "noranef") {
    ranef <- FALSE
    tu.lambda <- NULL
}    

if (method == "nl") {
    fn <- "nonlinear"
    rint <- FALSE
} else if (method == "lm") {
    fn <- "linear"
    rint <- FALSE
} else if (method == "rint") {    
    fn <- "linear"
    rint <- TRUE
}

data.list <- data.list %>%
    map(function(x)
        list(
            y=x$data$y, g=x$data$g,
            t=x$data$t, subject=x$data$dna))

res.list <- lapply(
    X=data.list,
    FUN=do_bms,
    p.m=p.m, phi=phi,
    fn=fn, rint=rint, method=computation,
    tu.lambda=tu.lambda)

saveRDS(res.list, file=out.file)
