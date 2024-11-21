suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(patchwork))

args <- commandArgs(TRUE)
in.dir <- as.character(args[1])
# fig.dir <- as.character(args[2])
fig.file <- as.character(args[2])

# if (!dir.exists(fig.dir)) dir.create(fig.dir, recursive=TRUE)

type.vec <- c(
    "noranef-noranef", "noranef-ranef",
    "ranef-noranef", "ranef-ranef")
hp.vec <- c("rest", "opt", "perm")
hp.name <- c("Restrictive", "Optimal", "Permissive")

file.vec <- file.path(
   in.dir, rep(type.vec, each=3),
   rep(hp.vec, times=4), "rocc.rds")

n.file <- file.vec %>% length
n.type <- type.vec %>% length
n.hp <- hp.vec %>% length

input.list <- file.vec %>% map(readRDS)
d <- input.list %>% bind_rows()
n.data <- nrow(d) / n.file

hp.fct <- rep(hp.vec, each=n.data) %>%
    rep(times=n.type) %>%
    factor(levels=hp.vec)
type.fct <- rep(type.vec, each=n.data * n.hp) %>%
    factor(levels=type.vec)

d <- d %>%
    mutate(hp=hp.fct) %>%
    mutate(type=type.fct)
d.list <- type.vec %>%
    map(\(x) d %>% filter(type == x))

get_color <- function() {
    color.df <- data.frame(x=1:3, y=1:3, c=1:3)
    p <- ggplot() +
        geom_point(
            mapping=aes(x=x, y=y, fill=c),
            data=color.df)
    g <- p %>% ggplot_build
    color.vec <- unique(g$data[[1]][, "fill"])
    color.vec
}

# plot
plot_rocc <- function(rocc, cols) {

    p <- ggplot() +
        geom_line(
            mapping=aes(x=fpr, y=recall, colour=hp),
            data=rocc)
    p <- p + geom_abline(intercept=0, slope=1, linetype=2)
    p <- p + xlab("FPR") + ylab("TPR")
    # modify scales
    p <- p + scale_color_manual(
                 values=cols, labels=hp.name)
    p <- p + scale_x_continuous(
                 limits=c(0, 0.5),
                 breaks=c(0, 0.25, 0.5),
                 labels=c("0.0", "0.25", "0.5"))
    p <- p + scale_y_continuous(
                 breaks=c(0, 0.5, 1),
                 labels=c("0.0", "0.5", "1.0"))
    # modify themes
    p <- p + theme(aspect.ratio=1)
    p <- p + theme(legend.position="bottom")
    p <- p + theme(legend.title=element_blank())
    p <- p + theme(legend.box.spacing=unit(0.2, "cm"))
    p <- p + theme(legend.margin=margin(0, 0, 0, 0))
    p <- p + theme(legend.text=element_text(size=rel(1)))
    # p <- p + theme(legend.spacing.y=unit(0.2, "cm"))
    # p <- p + theme(panel.grid.major=element_blank())
    # p <- p + theme(panel.grid.minor=element_blank())
    p <- p + theme(legend.background=element_rect(
                       colour="transparent",
                       fill="transparent"))
    p <- p + theme(legend.key=element_rect(
                       colour="transparent",
                       fill="transparent"))
    p <- p + theme(panel.grid.major=element_line(
                       colour="gray", linewidth=rel(0.6)))
    p <- p + theme(panel.grid.minor=element_line(
                       colour="gray", linewidth=rel(0.6)))
    p <- p + theme(panel.background=element_blank())
    p <- p + theme(panel.border=element_rect(
                       colour="gray", fill=NA, linewidth=1))
    p <- p + facet_grid(vars(method), vars(cat))
    p

}

gg.list <- d.list %>%
    map(\(x) x %>% plot_rocc(cols=get_color() %>% rev))

pw <- ((gg.list[[1]] | gg.list[[2]]) /
       (gg.list[[3]] | gg.list[[4]])) &
    # plot_layout(guides="collect") &
    # theme(legend.position="bottom") &
    plot_annotation(tag_levels="A")

ggsave(filename=fig.file, plot=pw, width=11, height=12)
