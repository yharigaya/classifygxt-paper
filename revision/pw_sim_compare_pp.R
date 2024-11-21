suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(patchwork))
suppressPackageStartupMessages(library(classifygxt))

theme_scatter <- theme(aspect.ratio=1) +
    # theme(legend.position="right") +
    # theme(legend.box.spacing=unit(2, "pt")) +
    theme(legend.title=element_blank()) +
    # theme(legend.key=element_rect(
    #           colour="transparent", fill="transparent")) +
    theme(panel.grid.major=element_blank()) +
    theme(panel.grid.minor=element_blank()) +
    # theme(panel.grid.major=element_line(
    #           colour="gray", linewidth=rel(0.6))) +
    # theme(panel.grid.minor=element_line(
    #           colour="gray", linewidth=rel(0.6))) +
    theme(panel.background=element_blank()) +
    theme(panel.border=element_rect(
              colour="gray", fill=NA, linewidth=1))

plot_scatter <- function(df) {
    
    map.method <- c("log-NL", "log-LM", "RINT-LM") %>%
    `names<-`(method.level)
    map.hp <- c("Restrictive", "Optimal", "Permissive") %>%
    `names<-`(hp.level)

    p <- ggplot() +
        geom_point(
            mapping=aes(x=mcmc.bs, y=map.lap),
            data=df, size=0.01, alpha=1)
    p <- p +
        xlab("MCMC & bridge sampling") +
        ylab("MAP & Laplace")
    p <- p +
        scale_x_continuous(
            breaks=c(0, 0.5, 1),
            labels=c("0.0", "0.5", "1.0"))
    p <- p +
        scale_y_continuous(
            breaks=c(0, 0.5, 1),
            labels=c("0.0", "0.5", "1.0"))
    p <- p +
        facet_grid(
            vars(method), vars(hp),
            labeller=labeller(
                method=map.method,
                hp=map.hp))
    p <- p + coord_equal()
    # p <- p + scale_color_manual(values=cols)
    p <- p +
        geom_abline(
            intercept=0, slope=1, color="dodgerblue",
            size=0.2, alpha=1)
    p <- p + theme_scatter
    # p <- p + coord_equal(xlim=c(0, 1), ylim=c(0, 1))

}    

args <- commandArgs(TRUE)
file1 <- args[1]
file2 <- args[2]
fig.file <- args[3]

# read in the data
pp1 <- file1 %>% readRDS
pp2 <- file2 %>% readRDS

df1 <- pp1 %>% filter(hom == FALSE)
df2 <- pp1 %>% filter(hom == TRUE)
df3 <- pp2 %>% filter(hom == FALSE)
df4 <- pp2 %>% filter(hom == TRUE)

df.list <- list(df1, df2, df3, df4)

# plot
method.level <- c("nl", "lm", "rint")
hp.level <- c("rest", "opt", "perm")

p.list <- df.list %>% map(plot_scatter)

pw <- (p.list[[1]] | p.list[[2]]) /
    (p.list[[3]] | p.list[[4]]) &
    plot_annotation(tag_levels="A")
    
ggsave(filename=fig.file, plot=pw, width=11, height=11)

