suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(classifygxt))
suppressPackageStartupMessages(library(microbenchmark))

args <- commandArgs(TRUE)
in.file <- args[1]
tu.lambda.file <- args[2]
lnpy.file <- args[3]
index <- as.integer(args[4])
computation <- args[5]
n.rep <- as.integer(args[6])
n.cores <- as.integer(args[7])
seed <- as.integer(args[8])
out.file <- args[9]

# read in the data
# data.list <- file.data %>% readRDS
input.list <- in.file %>% readRDS
ln.p.y <- lnpy.file %>% readRDS
tu.lambda <- tu.lambda.file %>% readRDS

# format data
if (is.null(input.list[[1]]$g)) {
    input.list <- input.list %>%
        map(function(x)
            list(
                y=x$data$y, g=x$data$g,
                t=x$data$t, subject=x$data$dna))
}
    
# specify model prior
p.m <- rep(1/8, 8)

# extract data
input <- input.list[[index]]

# get the optimal phi values
phi <- ln.p.y[which.max(ln.p.y$ln.p.y), 1:3] %>%
    as.numeric

# specify other input arguments
fn <- "nonlinear"
rint <- FALSE
# computation <- "mcmc.bs"
summary <- FALSE

if (computation == "mcmc-bs") {
    method <- "mcmc.bs"
} else if (computation == "map-lap") {
    method <- "map.lap"
}    

# set seed
set.seed(seed)

mbm <- microbenchmark(
    "runtime"={
        bms <- do_bms(
            data=input, p.m=p.m, phi=phi,
            fn=fn, rint=rint, method=method,
            tu.lambda=tu.lambda, summary=summary,
            n.cores=n.cores)},
    times=n.rep)

res <- list(mbm=mbm, bms=bms, index=index)

saveRDS(res, file=out.file)
