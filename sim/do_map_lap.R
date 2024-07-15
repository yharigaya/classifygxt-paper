suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(classifygxt))

args <- commandArgs(TRUE)
file.data <- as.character(args[1])
file.tu.lambda <- as.character(args[2])
file.fit <- as.character(args[3])
seed <- as.integer(args[4])
method <- as.character(args[5])
ranef <- as.character(args[6])
hp <- as.character(args[7])
file.out <- as.character(args[8])

# read in the data
data.list <- file.data %>% readRDS
ln.p.y <- file.fit %>% readRDS

# specify model prior
p.m <- rep(1/8, 8)

# get phi values
opt <- ln.p.y[which.max(ln.p.y$ln.p.y), 1:3] %>%
    as.numeric

if (hp == "opt")
    phi <- opt
if (hp == "rest") {
    phi <- opt * 0.5
} else if (hp == "perm") {
    phi <- opt * 2
}

computation <- "map.lap"

if (ranef == "ranef") {
    ranef <- TRUE
    tu.lambda <- file.tu.lambda %>% readRDS
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

res.list <- lapply(
    X=data.list,
    FUN=do_bms,
    p.m=p.m, phi=phi,
    fn=fn, rint=rint, method=computation,
    tu.lambda=tu.lambda)

saveRDS(res.list, file=file.out)
