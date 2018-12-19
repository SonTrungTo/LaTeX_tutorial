#mean wage of California
CAData <- subset(Parade2005, Parade2005$state == "CA")
attach(CAData)
mean(earnings)
plot(earnings ~ celebrity)
hist(earnings, freq = FALSE)
# Celebrities' wages heavily inflate the average wage. The distribution of wage is very skewed.

#number of individuals in Idaho (ID)
ID <- subset(Parade2005, Parade2005$state == "ID")
nrow(ID)
# data set is small, skewed and does not represent true earnings of ID.

#mean and median earnings of celebrity.
celeb  <- subset(Parade2005, Parade2005$celebrity == "yes")
normal <- subset(Parade2005, Parade2005$celebrity == "no")
mean(celeb$earnings)
mean(normal$earnings)
median(celeb$earnings)
median(normal$earnings)
#celebrity masssively earns more than normal citizens, distribution heavily skewed, as suggested in boxplot in d)

#botplot(log(earnings) ~ celebrity)
attach(Parade2005)
plot(log(earnings) ~ celebrity)
detach(Parade2005)
