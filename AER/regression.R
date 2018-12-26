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

#multiple regressors
library("AER")
data("CPS1988")
summary(CPS1988)
cps_lm <- lm(log(wage) ~ experience + I(experience^2) + education + ethnicity, data = CPS1988)
summary(cps_lm)
cps_noeth <- update(cps_lm, formula. =  .~. - ethnicity)
anova(cps_lm,cps_noeth)
anova(cps_lm)
waldtest(cps_lm, .~.-ethnicity)
range(CPS1988$experience)

#partial linear model
library("AER")
library("splines")
data("CPS1988")
cps_bs <- lapply(3:10, function(i) lm(log(wage) ~ bs(experience, df = i) + education + ethnicity, data = CPS1988))
structure(sapply(cps_bs, AIC, k = log(nrow(CPS1988))), .Names = 3:10)
cps_plm <- lm(log(wage) ~ bs(experience, df = 5) + education + ethnicity, data = CPS1988)
cps <- data.frame(experience = -2:60, education = with(CPS1988, mean(education[ethnicity == "cauc"])), ethnicity = "cauc")
cps$yhat1 <- predict(cps_lm, newdata = cps)
cps$yhat2 <- predict(cps_plm, newdata = cps)