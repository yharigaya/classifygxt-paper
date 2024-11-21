suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(classifygxt))

args <- commandArgs(TRUE)
in.dir <- args[1]
out.file <- args[2]
fig.file <- args[3]

method.vec <- c("nl", "lm", "rint")
param.vec <- c("b1", "b2", "b3")

# read in the data
file.vec <- file.path(
    in.dir, method.vec, "res.rds")
d <- file.vec %>%
    map(readRDS) %>%
    bind_rows

# add the method column
n.data <- nrow(d) / 3
method.fct <- rep(method.vec, each=n.data) %>%
    factor(levels=method.vec)
d <- d %>%
    mutate(method=method.fct) %>%
    mutate(param=factor(param, levels=param.vec))

saveRDS(d, file=out.file)

# plot
map.method <- c("log-NL", "log-LM", "RINT-LM") %>%
    `names<-`(method.vec)
map.param <- c("Genotype", "Treatment", "GxT") %>%
    `names<-`(param.vec)

p <- ggplot() +
    geom_point(
        mapping=aes(x=truth, y=est),
        data=d,
        size=0.01)
p <- p +
    xlab("Truth") +
    ylab("MAP estimates")
# p <- p +
#     scale_x_continuous(
#         breaks=c(0, 0.5, 1),
#         labels=c("0.0", "0.5", "1.0"))
# p <- p +
#     scale_y_continuous(
#         breaks=c(0, 0.5, 1),
#         labels=c("0.0", "0.5", "1.0"))
p <- p +
        facet_grid(
            vars(param), vars(method),
            labeller=labeller(
                param=map.param,
                method=map.method))
p <- p + coord_equal()

ggsave(filename=fig.file, plot=p, width=7, height=7)
