suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(classifygxt))

args <- commandArgs(TRUE)
mcmc.bs.dir <- as.character(args[1])
map.lap.dir <- as.character(args[2])
out.file <- as.character(args[3])
fig.file <- as.character(args[4])

method.vec <-
    rep(c("nl", "lm", "rint"), each=3)
hp.vec <-
    rep(c("rest", "opt", "perm"), times=3)

mcmc.bs.list <-
    file.path(
        mcmc.bs.dir, method.vec, hp.vec, "lnpy.vec.rds")
map.lap.list <-
    file.path(
        map.lap.dir, method.vec, hp.vec, "lnpy.vec.rds")

df.list <- vector("list", length(mcmc.bs.list)) 

for (i in seq_along(mcmc.bs.list)) {

    mcmc.bs.file <- mcmc.bs.list[[i]]
    map.lap.file <- map.lap.list[[i]]
    mcmc.bs.vec <- mcmc.bs.file %>% readRDS
    map.lap.vec <- map.lap.file %>% readRDS

    if (length(mcmc.bs.vec) != length(map.lap.vec)) {
        # take the first 100 simulations for each model
        subset <- rep(
            seq(0, 7, 1) * 1e3, each=100) + 1:100
        map.lap.vec <- map.lap.vec[subset]
    }

    d <- data.frame(
        mcmc.bs=mcmc.bs.vec,
        map.lap=map.lap.vec,
        method=method.vec[i],
        hp=hp.vec[i])
    
    df.list[[i]] <- d
        
}

df <- df.list %>% bind_rows

# save the data frame
saveRDS(df, out.file)

# plot
p <- ggplot() +
    geom_point(
        mapping=aes(x=mcmc.bs, y=map.lap),
        data=df,
        size=0.1)
p <- p + facet_grid(hp ~ method)
p <- p + coord_equal()
# p <- p + coord_equal(xlim=c(0, 1), ylim=c(0, 1))

ggsave(filename=fig.file, plot=p, width=7, height=7)

