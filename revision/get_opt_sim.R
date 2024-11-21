# for simulation and experimental data
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(classifygxt))

in.dir <- "../derived_data/revision/optim"
out.file <- "../derived_data/revision/summary/sim_opt.csv"

type.vec <- c(
    "noranef-noranef", "noranef-ranef",
    "ranef-noranef", "ranef-ranef")
n.type <- length(type.vec)
method.vec <- c("nl", "lm", "rint")
n.method <- length(method.vec)

file.vec <- file.path(
    in.dir, rep(type.vec, each=n.method),
    rep(method.vec, times=n.type), "ln.p.y.rds")

method.name <- c("log-NL", "log-LM", "RINT-LM")
gen.name <- c("-", "-", "+", "+")
fit.name <- c("-", "+", "-", "+")

output <- file.vec %>%
    map(readRDS) %>%
    map(function(x) x[which.max(x$ln.p.y), ]) %>%
    do.call("rbind", .) %>%
    mutate(method=rep(method.name, times=n.type)) %>%
    mutate(gen=rep(gen.name, each=n.method)) %>%
    mutate(fit=rep(fit.name, each=n.method)) %>%
    `rownames<-`(NULL)
    
output <- output[, c(5:7, 1:3)]
colnames(output) <- c(
    "Method", "Generation", "BMS",
    "Genotype", "Treatment", "Interaction")

write.table(
    output, file=out.file,
    row.names=FALSE, sep=",", quote=FALSE)
