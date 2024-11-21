suppressPackageStartupMessages(library(tidyverse))

args <- commandArgs(TRUE)
in.dir <- as.character(args[1])
# fig.dir <- as.character(args[2])
fig.file <- as.character(args[2])

# if (!dir.exists(fig.dir)) dir.create(fig.dir, recursive=TRUE)

hp.vec <- c("rest", "opt", "perm")
hp.name <- c("Restrictive", "Optimal", "Permissive")

file.vec <- file.path(
   in.dir, hp.vec, "rocc.rds")

n.file <- file.vec %>% length
n.hp <- hp.vec %>% length

input.list <- file.vec %>% map(readRDS)
d <- input.list %>% bind_rows()
n.data <- nrow(d) / n.file

hp.fct <- rep(hp.vec, each=n.data) %>%
    factor(levels=hp.vec)
d <- d %>%
    mutate(hp=hp.fct)

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

gg <- d %>% plot_rocc(cols=get_color() %>% rev)

ggsave(filename=fig.file, plot=gg, width=7.5, height=8)
