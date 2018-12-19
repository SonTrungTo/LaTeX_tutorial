?density
# kernel density of earnings for the full data set
attach(Parade2005)
hist(earnings, freq = FALSE)
hist(log(earnings), freq = FALSE)
lines(density(log(earnings), bw ), col = 4)
detach(Parade2005)
#A majority of the States belongs to the lower quartile of earnings.