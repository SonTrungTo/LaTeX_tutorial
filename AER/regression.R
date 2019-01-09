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
plot(log(wage) ~ jitter(experience, factor = 3), pch = 19, col = rgb(0.5, 0.5, 0.5, 0.02), data = CPS1988)
lines(cps$yhat1 ~ experience, data = cps, lty = 2)
lines(cps$yhat2 ~ experience, data = cps)
legend("topleft", c("quadratic", "splines"), lty = c(2, 1), bty = "n")

#factors, interactions and weights
summary(cps_lm)
summary(cps_noeth)
cps_int <- lm(log(wage) ~ experience + I(experience^2) + education*ethnicity, data = CPS1988)
coeftest(cps_int)
cps_sep <- lm(log(wage) ~ ethnicity / (experience + I(experience^2) + education) - 1 , data = CPS1988)
cps_sep_cf <- matrix(coef(cps_sep), nrow = 2)
rownames(cps_sep_cf) <- levels(CPS1988$ethnicity)
colnames(cps_sep_cf) <- names(coef(cps_lm))[1:4]
cps_sep_cf
anova(cps_sep, cps_lm)
CPS1988$region <- relevel(CPS1988$region, ref = "south")
cps_region <- lm(log(wage) ~ ethnicity + education + experience + I(experience^2) + region, data = CPS1988)
coef(cps_region)
# WLS to alleviate the problem of heteroskedasticity
jour_wls1 <- lm(log(subs) ~ log(citeprice), data = journals, weights = 1 / citeprice^2)
jour_wls2 <- lm(log(subs) ~ log(citeprice), data = journals, weights = 1 / citeprice)
abline(jour_wls1, lwd = 2, lty = 2)
abline(jour_wls2, lwd = 2, lty = 3)
legend("bottomleft", c("OLS", "WLS1", "WLS2"), lty = 1:3, lwd = 2, bty = "n")
# FGLS to use appropriate WLS from the data
auxreg <- lm(log(residuals(jour_lm)^2) ~ log(citeprice), data = journals)
jour_fgls1 <- lm(log(subs) ~ log(citeprice), weights = 1 / exp(fitted(auxreg)), data = journals)
abline(jour_fgls1, lwd = 2, lty = 4)
# Iterated FGLS
gamma2i <- coef(auxreg)[2]
gamma2  <- 0
while(abs((gamma2i - gamma2)/gamma2) > 1e-7) {
  gamma2  <- gamma2i
  fglsi   <- lm(log(subs) ~ log(citeprice), data = journals, weights = 1 / citeprice^gamma2)
  gamma2i <- coef(lm(log(residuals(fglsi)^2) ~ log(citeprice), data = journals))[2]
}
jour_fgls2 <- lm(log(subs) ~ log(citeprice), data = journals, weights = 1 / citeprice^gamma2)
coef(jour_fgls2)
abline(jour_fgls2, lwd = 3, lty = 5)
# Time Series Analysis
data("USMacroG")
plot(USMacroG[,c("dpi", "consumption")], lty = c(3, 1), plot.type = "single", ylab = "")
legend("topleft", legend = c("income", "consumption"), lty = c(3, 1), bty = "n")
library("dynlm")
cons_lm1 <- dynlm(consumption ~ dpi + L(dpi), data = USMacroG)
cons_lm2 <- dynlm(consumption ~ dpi + L(consumption), data = USMacroG)
summary(cons_lm1)
summary(cons_lm2)
deviance(cons_lm1)  # Obtain RSS
deviance(cons_lm2)
plot(merge(as.zoo(USMacroG[,"consumption"]), fitted(cons_lm1), fitted(cons_lm2), 0, residuals(cons_lm1), residuals(cons_lm2)),
     screens = rep(1:2, c(3,3)), lty = rep(1:3, 2), ylab = c("Fitted values", "Residuals"), xlab = "Time", main = "")
legend(0.05, 0.95, c("observed", "cons_lm1", "cons_lm2"), lty = 1:3, bty = "n")
# Encompassing model
cons_lmE <- dynlm(consumption ~ dpi + L(dpi) + L(consumption), data = USMacroG)
anova(cons_lm1, cons_lmE, cons_lm2)
encomptest(cons_lm1, cons_lm2)
library("zoo")
library("lmtest")
# Panel data
data("Grunfeld", package = "AER")
library("plm")
gr      <- subset(Grunfeld, firm %in% c("General Electric",
                                   "General Motors", "IBM"))
pgr     <- pdata.frame(gr, index = c("firm", "year"))
gr_pool <- plm(invest ~ value + capital, data = pgr, model = "pooling") 
summary(gr_pool)
gr_fe   <- plm(invest ~ value + capital, data = pgr, model = "within")
summary(gr_fe)
fixef(gr_fe)
pFtest(gr_fe, gr_pool)
gr_re   <- plm(invest ~ value + capital, data = pgr, model = "random", random.method = "walhus")
summary(gr_re)
plmtest(gr_pool)
phtest(gr_fe, gr_re)
# Dynamic linear models
data("EmplUK", package = "plm")
form    <- log(emp) ~ log(wage) + log(capital) + log(output)
empl_ab <- pgmm(log(emp) ~ lag(log(emp), 0:2) + lag(log(wage), 0:1) + lag(log(capital), 0) 
                + lag(log(output), 0:1)|lag(log(emp), 2:99),
                data = EmplUK, index = c("firm","year"),
                effect = "twoways", model = "twosteps")  #not fully understood due to dynformula being depricated!
summary(empl_ab)
# SUR
library("systemfit")
gr2 <- subset(Grunfeld, firm %in% c("Chrysler", "IBM"))
pgr2 <- pdata.frame(gr2, index = c("firm", "year"))
gr_sur <- systemfit(invest ~ value + capital, method = "SUR", data = pgr2)
summary(gr_sur, residCov = FALSE, equations = FALSE)