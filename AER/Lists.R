mylist <- list(sample = rnorm(5),
               family = "normal distribution",
               parameters = list(mean = 0, sd = 1))
mylist
#equivalence
mylist[[1]]
mylist[["sample"]]
mylist$sample
#extraction
mylist[[3]]$sd
