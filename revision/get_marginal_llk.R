suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(classifygxt))

check_hom <- function(x) {
    g <- x$g
    sum(g == 2) == 0
}

args <- commandArgs(TRUE)
dir.prefix <- as.character(args[1])
data.file <- as.character(args[2]) 
lb <- as.integer(args[3])
ub <- as.integer(args[4])
step <- as.integer(args[5])
out.file <- as.character(args[6])

phi <- seq(lb / 100, ub / 100, step / 100) %>%
    round(2) %>%
    format(nsmall=2)
phi.matrix <- cbind(
    phi1=rep(phi, times=10^2),
    phi2=rep(rep(phi, each=10), times=10),
    phi3=rep(phi, each=10^2))
phi.name <- apply(phi.matrix, 1, paste, collapse="_") %>%
    sapply(function(x) paste0("phi", x)) %>%
    unname

data.list <- data.file %>% readRDS 
hom <- data.list %>%
    map_lgl(check_hom)

# covert the characger matrix to numeric
phi.matrix <- apply(phi.matrix, 2, as.numeric)

ln.p.y <- phi.name %>% sapply(function(x)
    dir.prefix %>%
    file.path(x, "fit.rds") %>%
    readRDS %>%
    sapply(function(x) x$ln.p.y) %>%
    `[`(!hom) %>%
    sum
    ) %>%
    `names<-`(phi.name) %>%
    cbind(phi.matrix, ln.p.y=.) %>%
    as.data.frame

saveRDS(ln.p.y, file=out.file)


