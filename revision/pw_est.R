suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(patchwork))
suppressPackageStartupMessages(library(classifygxt))

get_mse <- function(x, y, d) {
    xval <- d %>%
        filter(param == x & method == y) %>%
        pull(truth)
    yval <- d %>%
        filter(param == x & method == y) %>%
        pull(est)
    mean((xval - yval)^2) %>%
        sqrt %>%
        round(3) %>%
        format(nsmall=3)
}    

theme_scatter <- theme(aspect.ratio=1) +
    theme(legend.position="right") +
    theme(legend.box.spacing=unit(2, "pt")) +
    theme(legend.title=element_blank()) +
    theme(legend.key=element_rect(
              colour="transparent", fill="transparent")) +
    theme(panel.grid.major=element_line(
              colour="gray", linewidth=rel(0.6))) +
    theme(panel.grid.minor=element_line(
              colour="gray", linewidth=rel(0.6))) +
    theme(panel.background=element_blank()) +
    theme(panel.border=element_rect(
              colour="gray", fill=NA, linewidth=1))

make_scatter <- function(d, comp) {

    method.vec <- c("nl", "lm", "rint")
    param.vec <- c("b1", "b2", "b3")
    map.method <- c("log-NL", "log-LM", "RINT-LM") %>%
        `names<-`(method.vec)
    map.param <- c("Genotype", "Treatment", "GxT") %>%
        `names<-`(param.vec)

    if (comp == "map-lap") {
        ylab <- "MAP estimate"
    } else if (comp == "mcmc-bs") {
        ylab <- "Posterior mean"
    } else {
        stop("the comp argument is incorrect")
    }    
    
    d.label <- pmap_chr(
        list(
            rep(param.vec, each=3),
            rep(method.vec, times=3)), get_mse, d=d)
            # rep(method.vec, times=3)), format_cor, d=d)
    d.text <- data.frame(
        param=factor(rep(param.vec, each=3), levels=param.vec),
        method=factor(rep(method.vec, times=3), levels=method.vec),
        label=d.label)
    
    p <- ggplot() +
        geom_point(
            mapping=aes(x=truth, y=est),
            data=d, size=0.01, alpha=0.2)
    p <- p +
        xlab("Truth") +
        ylab(ylab)
    p <- p + scale_x_continuous(
                 limits=c(-8, 8),
                 breaks=c(-8, -4, 0, 4, 8),
                 labels=c("-8", "-4", "0", "4", "8"))
    p <- p + scale_y_continuous(
                 limits=c(-8, 8),
                 breaks=c(-8, -4, 0, 4, 8),
                 labels=c("-8", "-4", "0", "4", "8"))
    p <- p +
        facet_grid(
            vars(param), vars(method),
            labeller=labeller(
                param=map.param,
                method=map.method))
    p <- p + coord_equal()
    p <- p +
        geom_abline(
            intercept=0, slope=1, color="dodgerblue", size=0.2)
    p <- p + theme_scatter
    p <- p + geom_text(
                 data=d.text,
                 mapping=aes(x=-5.5, y=7, label=label))
    p
}

args <- commandArgs(TRUE)
in.dir <- args[1]
comp <- args[2] 
fig.file <- args[3]

type.vec <- c(
    "noranef-noranef", "noranef-ranef",
    "ranef-noranef", "ranef-ranef")

# read in the data
file.vec <- file.path(
    in.dir, type.vec, "combined.rds")

# read in the data into a list
df.list <- file.vec %>% map(readRDS)

# plot
p.list <- df.list %>%
    map(make_scatter, comp=comp)

pw <- (p.list[[1]] | p.list[[2]]) /
    (p.list[[3]] | p.list[[4]]) &
    plot_annotation(tag_levels="A")

ggsave(filename=fig.file, plot=pw, width=11, height=11)
