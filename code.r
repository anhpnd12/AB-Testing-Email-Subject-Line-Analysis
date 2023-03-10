CustomerData <- read.csv("Module1Data.csv")
View(CustomerData)

# subset customers who experiment 2 promocode subject lines 
Experiment <- subset (CustomerData, CustomerData$PromoCode ==1 | CustomerData$PromoCode ==2)
Experiment[is.na(Experiment)] <- 0

# create average number of online purchases (Online), number of purchases by customer (frequency) and number of purchases with promo (freq-promo) in the last 12 months
Experiment$Online1 <- Experiment$Online/12
Experiment$Frequency1 <-Experiment$Frequency/12
Experiment$Freq_promo1 <-Experiment$Freq_promo/12

## creating new variables, make a purchase versus not make a purchase
library (dplyr)
Experiment$Purchase <- ifelse(Experiment$Sales >1, 1,0)

#### looking within those who made a purchase

## creating subset with those purchase by promocode
PromoPurchase <- subset (Experiment, Experiment$Purchase ==1)

# descriptive stats
library (psych)
describe (PromoPurchase)
describeBy (PromoPurchase, PromoPurchase$PromoCode)

## independent t-tests

# IV = Promocode, DV = Average sales
t.test (PromoPurchase$Sales ~ PromoPurchase$PromoCode, var.equal=TRUE, alternative = "greater", data = PromoPurchase)
# IV = Promocode, DV = Average Frequency (nb of purchase 12 month)
t.test (PromoPurchase$Frequency1 ~ PromoPurchase$PromoCode, var.equal=TRUE, alternative = "greater", data = PromoPurchase)
# IV = Promocode, DV = Average Freq_promo (nb of promo purchase 12 month)
t.test (PromoPurchase$Freq_promo ~ PromoPurchase$PromoCode, var.equal=TRUE, alternative = "greater", data = PromoPurchase)
# IV = Promocode, DV = Average Online (nb of online purchase 12 month)
t.test (PromoPurchase$Online1 ~ PromoPurchase$PromoCode, var.equal=TRUE, alternative = "greater", data = PromoPurchase)

### Run a correlation for the variables Freq_promo and Frequency
library(ggpubr)
ggscatter(Experiment, x = "Freq_promo", y = "Frequency", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Freq_promo", ylab = "Frequency")

res <- cor.test(Experiment$Freq_promo, Experiment$Frequency, 
                method = "pearson")

res

#### looking at differences between between those who made a purchase and those who did not

## testing proportion of purchase versus not purchase by promocode
library(gmodels)
CrossTable (Experiment$Purchase , Experiment$PromoCode)
# IV = Type of promo, DV = Purchase with promo
test <- chisq.test (table (Experiment$Purchase, Experiment$PromoCode), correct=FALSE)
test


## independent t-tests

# IV = Purchase made, DV = Average Frequency (nb of purchase 12 month)
t.test (Experiment$Frequency ~ Experiment$Purchase, var.equal=TRUE, alternative = "greater", data = Experiment)
# IV = Purchase made, DV = Averaqe Freq_promo (nb of promo purchase 12 month)
t.test (Experiment$Freq_promo ~ Experiment$Purchase, var.equal=TRUE, alternative = "greater", data = Experiment)

## a z-test of proportion between groups for the click through rate
prop.test (x=60, n=100, p = NULL, alternative = "greater", correct = TRUE)
