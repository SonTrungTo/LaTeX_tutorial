data("Journals", package = "AER")
journals <- Journals[, c("subs", "price")]
journals$citeprice <- Journals$price/Journals$citations
summary(journals)

plot(log(subs) ~ log(citeprice), data = journals)
jour_lm <- lm(log(subs) ~ log(citeprice), data = journals)
abline(jour_lm)
class(jour_lm)
names(jour_lm)
str(jour_lm)
jour_lm$rank
summary(jour_lm)
jour_slm <- summary(jour_lm)
class(jour_slm)
names(jour_slm)
anova(jour_lm)
coef(jour_lm)
confint(jour_lm, level = 0.95)
predict(jour_lm, newdata = data.frame(citeprice = 2.11), interval = "confidence")
predict(jour_lm, newdata = data.frame(citeprice = 2.11), interval = "prediction")

#prediction range graph
lciteprice <- seq(from = -6, to = 4, by = 0.25)
jour_pred <- predict(jour_lm, newdata = data.frame(citeprice = exp(lciteprice)), interval = "prediction")
plot(log(subs) ~ log(citeprice), data = journals)
lines(jour_pred[, 1] ~ lciteprice, col = 1)
lines(jour_pred[, 2] ~ lciteprice, col = 1, lty = 2)
lines(jour_pred[, 3] ~ lciteprice, col = 1, lty = 3)

#plotting lm objects
par(mfrow = c(2, 2))
plot(jour_lm)
par(mfrow = c(1, 1))

#testing linear models
linearHypothesis(jour_lm, "log(citeprice) = -0.5")