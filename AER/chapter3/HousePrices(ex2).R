library("AER")
data("HousePrices")
head(HousePrices)
reg_lm <- lm(log(price) ~ lotsize + bedrooms + bathrooms + stories + driveway + recreation + fullbase + gasheat
             + aircon + garage + prefer, data = HousePrices)
summary(reg_lm)
