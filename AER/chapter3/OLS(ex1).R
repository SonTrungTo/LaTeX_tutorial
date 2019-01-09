x <- 1:20
y <- x + rnorm(20)
pseudo_reg <- lm(y ~ x)
summary(pseudo_reg)
plot(y ~ x)
abline(pseudo_reg)
# degree of 2 and above makes the direct calculation failed.