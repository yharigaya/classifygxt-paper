suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(patchwork))
suppressPackageStartupMessages(library(classifygxt))

source("utils.R")

data.file <- "../derived_data/wntrna/pre/rsd/pc10/data.list.rds"
in.dir <- "../derived_data/wntrna/post/kin/pc10/nl/fit"
fig.dir <- "../figures/vis"
fig.file <- file.path(fig.dir, "wntrna_gp_co.pdf")

if (!dir.exists(fig.dir)) dir.create(fig.dir, recursive=TRUE)

# read in the input data
data.list <- data.file %>% readRDS

data.list <- data.list %>%
    map(function(x)
        list(
            y=x$data$y, g=x$data$g,
            t=x$data$t, subject=x$data$dna,
            feat.id=x$feat.id, snp.id=x$snp.id))

feat.vec <- data.list %>%
    map_chr(pluck("feat.id"))
snp.vec <- data.list %>%
    map_chr(pluck("snp.id"))

feat.name <- c(
    "ENSG00000273611", 
    "ENSG00000287315", 
    "ENSG00000152078")
snp.name <- c(
    "chr17:36486677:G:A",
    "chr1:227988148:A:G",
    "chr1:95394387:C:T")
gene.name <- c(
    "ZNHIT3",
    "ENSG00000287315",
    "TLCD4")
rs.vec <- c(
    "rs4796224",
    "rs10157612",
    "rs7556223")    
geno.vec <- c("0|0", "0|0", "0|0")

# all(match(feat.name, feat.vec) ==
#     match(snp.name, snp.vec))
index.vec <- match(feat.name, feat.vec)

gp.list <- pp.list <-
    vector("list", length(index.vec))

for (i in seq_along(index.vec)) {
    
    # get index for the i-th rank
    index <- index.vec[i]

    # get info
    snp.id <- data.list[[index]]$snp.id
    rs.id <- rs.vec[i]
    title <- paste0(gene.name[i], "\n", rs.id)
    geno <- geno.vec[i]
    geno.label <- get_geno_label(
        snp.id=snp.id, geno=geno)

    fit.file <- file.path(
        in.dir,
        paste0(
            "res", str_pad(index, 4, pad="0"), ".rds"))
    fit <- fit.file %>% readRDS

    # for gp plots
    data <- data.list[[index]]
    gp <- format_gp(data=data, fit=fit)

    # create a ggplot2 object
    p1 <- make_gp_plot(gp=gp)
    p1 <- p1 + scale_x_continuous(
                   labels=geno.label,
                   breaks=c(0, 1, 2))
    p1 <- p1 + labs(title=title) +
        theme(plot.title=element_text(size=rel(1)))
    
    # for pp plots
    pp <- fit %>% format_pp(co=TRUE)
    p2 <- pp %>% make_pp_plot
    
    gp.list[[i]] <- p1
    pp.list[[i]] <- p2

}
    
((gp.list[[1]] / pp.list[[1]]) |
 (gp.list[[2]] / pp.list[[2]]) |
 (gp.list[[3]] / pp.list[[3]])) +
    plot_layout(guides="collect") &
    plot_annotation(tag_levels="A") &
    theme(
        legend.position="bottom",
        legend.title=element_blank(),
        legend.text=element_text(size=rel(1)))

ggsave(file=fig.file, width=8, height=6)


