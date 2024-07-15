suppressPackageStartupMessages(library(tidyverse))

args <- commandArgs(TRUE)
data.file <- as.character(args[1])
pca.file <- as.character(args[2])
num.pc <- as.integer(args[3])
out.file <- as.character(args[4]) 

data.list <- data.file %>% readRDS

pca <- pca.file %>% readRDS
pca.mat <- pca$x

for (i in seq_along(data.list)) {
    if (i %% 1000 == 0) cat(i, "\t")

    l <- data.list[[i]]
    d <- l$data %>%
        dplyr::select(c(y, g, t, dna))
    d <- merge(d, pca.mat[, seq_len(num.pc)], by.x=0, by.y=0)
    
    # get residuals
    frml <- paste0(
        "y ~ ",
        paste0(paste0("PC", seq_len(num.pc)), collapse=" + ")) 
    d$y <- residuals(lm(frml, data=d))
    
    # remove pcs
    d <- d[, 1:5]
    colnames(d) <- c("sample", "y", "g", "t", "dna")
    
    # replace the data
    l$data <- d
    data.list[[i]] <- l 

}

saveRDS(data.list, file=out.file)

