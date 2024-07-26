suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(patchwork))

fig.file <- "../figures/vis/sim_compare_sum_lnpy.pdf"
fig.dir <- "../figures/vis"

if (!dir.exists(fig.dir)) dir.create(fig.dir, recursive=TRUE)

type.vec <- c(
    "noranef-noranef", "noranef-ranef",
    "ranef-noranef", "ranef-ranef")
file.vec <- file.path(
    "../derived_data/sim/comparison/",
    type.vec, "compare.sum.lnpy.rds")

method.level <- c("nl", "lm", "rint")
map.method <- c("log-NL", "log-LM", "RINT-LM") %>%
    `names<-`(method.level)

# read in the data
df.list <- file.vec %>% map(readRDS)

p.list <- vector("list", length(type.vec))

# iterate through the list
for (i in seq_along(df.list)) {

    df <- df.list[[i]]
    
    p <- ggplot() +
        geom_point(
            mapping=aes(x=mcmc.bs, y=map.lap),
            data=df,
            size=0.01)
    p <- p +
        xlab("MCMC & bridge sampling") +
        ylab("MAP & Laplace") 
    p <- p + theme(aspect.ratio=1)
    p <- p +
        facet_wrap(
            vars(method),
            labeller=labeller(
                method=map.method),
            scales="free")
    # p <- p + coord_equal()
    # p <- p + coord_equal(xlim=c(0, 1), ylim=c(0, 1))

    p.list[[i]] <- p 

}

(p.list[[1]] / p.list[[2]] /
 p.list[[3]] / p.list[[4]]) &
    plot_annotation(tag_levels="A")

ggsave(filename=fig.file, width=9, height=12)

# ggsave(filename=fig.file, width=9, height=3)









