suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(classifygxt))

check_hom <- function(x) {
    g <- x$g
    sum(g == 2) == 0
}

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

args <- commandArgs(TRUE)
data.file <- as.character(args[1])
mcmc.bs.dir <- as.character(args[2])
map.lap.dir <- as.character(args[3])
out.file <- as.character(args[4])
fig.file <- as.character(args[5])

data.list <- data.file %>% readRDS 

hom <- data.list %>%
    map_lgl(check_hom)

hom.level <- c(TRUE, FALSE)
method.level <- c("nl", "lm", "rint")
hp.level <- c("rest", "opt", "perm")
method.vec <-
    rep(c("nl", "lm", "rint"), each=3)
hp.vec <-
    rep(c("rest", "opt", "perm"), times=3)

mcmc.bs.list <-
    file.path(
        mcmc.bs.dir, method.vec, hp.vec, "pp.rds")
map.lap.list <-
    file.path(
        map.lap.dir, method.vec, hp.vec, "pp.rds")

df.list <- vector("list", length(mcmc.bs.list)) 

for (i in seq_along(mcmc.bs.list)) {

    mcmc.bs.file <- mcmc.bs.list[[i]]
    map.lap.file <- map.lap.list[[i]]
    mcmc.bs.mat <- mcmc.bs.file %>%
        readRDS %>%
        dplyr::select(-correct) %>%
        as.matrix
    map.lap.mat <- map.lap.file %>%
        readRDS %>%
        dplyr::select(-correct) %>%
        as.matrix
    hom.mat <- matrix(hom, nrow=length(hom), ncol=8)

    if (nrow(mcmc.bs.mat) != nrow(map.lap.mat)) {
        # take the first 100 simulations for each model
        subset <- rep(
            seq(0, 7, 1) * 1e3, each=100) + 1:100
        map.lap.mat <- map.lap.mat[subset, ]
        hom.mat <- hom.mat[subset, ]
    }

    mcmc.bs.vec <- mcmc.bs.mat %>% c
    map.lap.vec <- map.lap.mat %>% c
    hom.vec <- hom.mat %>% c
    
    d <- data.frame(
        mcmc.bs=mcmc.bs.vec,
        map.lap=map.lap.vec,
        hom=hom.vec,
        method=method.vec[i],
        hp=hp.vec[i])
    
    df.list[[i]] <- d
        
}

df <- df.list %>%
    bind_rows %>%
    mutate(hom=factor(hom, levels=hom.level)) %>%
    mutate(method=factor(method, levels=method.level)) %>%
    mutate(hp=factor(hp, levels=hp.level))

# save the data frame
saveRDS(df, out.file)

# make plot
map.method <- c("log-NL", "log-LM", "RINT-LM") %>%
    `names<-`(method.level)
map.hp <- c("Restrictive", "Optimal", "Permissive") %>%
    `names<-`(hp.level)

cols <- c("blue", "gray")

p <- ggplot() +
    geom_point(
        mapping=aes(x=mcmc.bs, y=map.lap, color=hom),
        data=df,
        size=0.4, alpha=0.4)
p <- p +
    xlab("MCMC & bridge sampling") +
    ylab("MAP & Laplace") 
p <- p +
    facet_grid(
        vars(method), vars(hp),
        labeller=labeller(
            method=map.method,
            hp=map.hp))
p <- p + coord_equal()
p <- p + scale_color_manual(values=cols)
p <- p + theme_scatter
# p <- p + coord_equal(xlim=c(0, 1), ylim=c(0, 1))

ggsave(filename=fig.file, plot=p, width=7, height=7)

