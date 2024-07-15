suppressPackageStartupMessages(library(tidyverse))

args <- commandArgs(TRUE)
in.dir <- as.character(args[1])
fig.dir <- as.character(args[2])
fig.file <- as.character(args[3])
data.file <- as.character(args[4])

if (!dir.exists(fig.dir)) dir.create(fig.dir, recursive=TRUE)

method.vec <- c("nl", "lm", "rint")
method.name <- c("log-NL", "log-LM", "RINT-LM")
n.method <- length(method.vec)

file.vec <- file.path(in.dir, method.vec, "rocc.co.rds")

cols <- c(rgb(230/255, 159/255, 0/255),
          rgb(86/255, 180/255, 233/255),
          rgb(0/255, 158/255, 115/255))

# create a data frame
rocc.list <- lapply(file.vec, readRDS)
rocc <- rocc.list %>%
    map(function(x) x$roc) %>%
    do.call("rbind", .)
n.pt <- nrow(rocc) / length(file.vec)

method.fact <-
    rep(method.name, each=n.pt) %>%
    factor(levels=method.name)
rocc <- rocc %>%
    mutate(method=method.fact)

saveRDS(rocc, file=data.file)

# plot
p <- ggplot() +
    geom_line(
        mapping=aes(x=fpr, y=recall, colour=method),
        data=rocc)
p <- p + geom_abline(intercept=0, slope=1, linetype=2)
p <- p + xlab("FPR") + ylab("TPR")

# modify scales
p <- p + scale_color_manual(values=cols)
# p <- p + scale_x_continuous(
#              labels=scales::number_format(accuracy=0.1))
# p <- p + scale_y_continuous(
#              labels=scales::number_format(accuracy=0.1))
p <- p + scale_x_continuous(
             limits=c(0, 1),
             breaks=c(0, 0.5, 1),
             labels=c("0.0", "0.5", "1.0"))
p <- p + scale_y_continuous(
             limits=c(0, 1),
             breaks=c(0, 0.5, 1),
             labels=c("0.0", "0.5", "1.0"))

# modify themes
p <- p + theme(aspect.ratio=1)
p <- p + theme(legend.position="bottom")
p <- p + theme(legend.title=element_blank())
# p <- p + theme(panel.grid.major=element_blank())
# p <- p + theme(panel.grid.minor=element_blank())
p <- p + theme(panel.grid.major=element_line(
                   colour="gray", linewidth=rel(0.6)))
p <- p + theme(panel.grid.minor=element_line(
                   colour="gray", linewidth=rel(0.6)))
p <- p + theme(panel.background=element_blank())
p <- p + theme(panel.border=element_rect(
                   colour="gray", fill=NA, linewidth=1))

# pdf(fig.file, width=5, height=5)
# p
# dev.off()

ggsave(filename=fig.file, plot=p, width=5, height=5)

# get aoc
# aoc.vec <- rocc.list %>%
#     map_dbl(function(x) x$aoc)
