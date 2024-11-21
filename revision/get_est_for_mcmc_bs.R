suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(classifygxt))

get_post <- function(model.index, fit) {
    model.mat <- classifygxt:::get_model_mat()
    m <- model.mat[model.index, ] %>% as.numeric
    stan.list <- fit$stan.list[[model.index]]
    post <- rstan::extract(stan.list, permute=TRUE)
    if (!is.null(post$sigma2)) {
        b1 <- mean(post$b1 / sqrt(post$sigma2))
        # b1 <- mean(post$b1)
        b2 <- mean(post$b2 / sqrt(post$sigma2))
        b3 <- mean(post$b3 / sqrt(post$sigma2))
    } else if (!is.null(post$sigma)) {
        b1 <- mean(post$b1 / post$sigma)
        # b1 <- mean(post$b1)
        b2 <- mean(post$b2 / post$sigma)
        b3 <- mean(post$b3 / post$sigma)
    } else {
        stop("the input does not have the correct format")
    }    
    c(b1, b2, b3) * m
}

do_bma <- function(fit) {
    post <- 1:8 %>%
        map(get_post, fit=fit) %>%
        do.call("rbind", .)
    p.m.given.y <- fit$p.m.given.y
    bma <- sweep(post, 1, p.m.given.y, "*") %>%
        colSums %>%
        `names<-`(c("b1", "b2", "b3")) 
    bma
}

args <- commandArgs(TRUE)
data.file <- as.character(args[1])
in.dir <- as.character(args[2])
out.file <- as.character(args[3])

data.list <- data.file %>% readRDS

# get the true parameter values
# note that sigma equals 1
truth <- data.list %>%
    map(\(x) pluck(x, "beta")) %>%
    bind_rows %>%
    dplyr::select(c(b1, b2, b3)) %>%
    pivot_longer(everything()) %>%
    `colnames<-`(c("name1", "value1"))

file.vec <- list.files(
    in.dir, pattern="^res", full.names=TRUE) %>%
    grep("rds$", ., value=TRUE)

est <- file.vec %>%
    map(
        function(x) readRDS(x) %>%
                    do_bma) %>%
    do.call("rbind", .) %>%
    as.data.frame %>%
    pivot_longer(everything()) %>%
    `colnames<-`(c("name2", "value2"))

# all(pull(truth, name1) == pull(est, name2))

d <- bind_cols(truth, est) %>%
    dplyr::select(c(name1, value1, value2)) %>%
    `colnames<-`(c("param", "truth", "est"))

saveRDS(d, file=out.file)





