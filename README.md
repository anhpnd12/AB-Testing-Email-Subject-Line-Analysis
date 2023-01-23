# AB-Testing-Email-Subject-Line-Analysis
 A/B Testing Email Subject Line Analysis

# 1. Introduction

We take a look at the database of 275 customers who registered for the rewards program. 200 consumers among those are chosen in the promotional emails experiment with the new subject lines. Half of the group received an email with the subject line “Flash Sale” and the other half received an email with the subject line “One Day Sale.” Embedded in each email is a code for 50% off that corresponds with the subject line.  

In this project, my task is to draw useful insights while exploring interesting patterns. I develop hypothesis then use the statistical tests like t-test and chi-square to test.


## 1.1 Data Description

PromoCode: 0 – no code was used, 1- Flash was used, 2 –OneDay was used, 3- Birthday was used (this is a code provided to consumers for their birthday and cannot be combined with any other offers)
Sales: amount spent (in $) during the 24-hour period
Items: number of items purchased during the 24-hour period
Ship: 0- ship to store, 1-ship to home
GiftCard: 0-no gift card used, 1- gift card used (for some or all of purchase)
Accessories: number of items purchased that qualify as an accessory 
Clothing: number of items purchased that qualify as clothing
Shoes: number of items purchased that qualify as shoes
Guest: 0 - the consumer checked out as a guest, 1- consumer checked as a returning user (i.e. they are part of the rewards program)
Frequency: number of purchases made by consumer in the last 12 months
Freq_promo: number of times consumer has made a purchase with a promotion code in the last 12 months
Duration: number of months enrolled in the rewards program
Online: number of online purchases made by consumer in the last 12 months

## 1.2 Importing the required libraries

library(dplyr)
library(psych)
library(gmodels)


# 2. Analytical Questions
## 2.1 Assessing the effectiveness of 2 experiment subject lines

CustomerData <- read.csv("Module1Data.csv")
View(CustomerData)

### subset customers who experiment 2 promocode subject lines 
Experiment <- subset (CustomerData, CustomerData$PromoCode ==1 | CustomerData$PromoCode ==2)
Experiment[is.na(Experiment)] <- 0

### create average number of online purchases (Online), number of purchases by customer (frequency) and number of purchases with promo (freq-promo) in the last 12 months
Experiment$Online1 <- Experiment$Online/12
Experiment$Frequency1 <-Experiment$Frequency/12
Experiment$Freq_promo1 <-Experiment$Freq_promo/12

### creating new variables, make a purchase versus not make a purchase
Experiment$Purchase <- ifelse(Experiment$Sales >1, 1,0)

### looking within those who made a purchase

### creating subset with those purchase by promocode
PromoPurchase <- subset (Experiment, Experiment$Purchase ==1)

### descriptive stats
describe (PromoPurchase)
describeBy (PromoPurchase, PromoPurchase$PromoCode)

### independent t-tests

# IV = Promocode, DV = Average sales
t.test (PromoPurchase$Sales ~ PromoPurchase$PromoCode, var.equal=TRUE, alternative = "greater", data = PromoPurchase)
# IV = Promocode, DV = Average Frequency (nb of purchase 12 month)
t.test (PromoPurchase$Frequency1 ~ PromoPurchase$PromoCode, var.equal=TRUE, alternative = "greater", data = PromoPurchase)
# IV = Promocode, DV = Average Freq_promo (nb of promo purchase 12 month)
t.test (PromoPurchase$Freq_promo ~ PromoPurchase$PromoCode, var.equal=TRUE, alternative = "greater", data = PromoPurchase)
# IV = Promocode, DV = Average Online (nb of online purchase 12 month)
t.test (PromoPurchase$Online1 ~ PromoPurchase$PromoCode, var.equal=TRUE, alternative = "greater", data = PromoPurchase)


## 2.2 Examining the differences between those consumers who received the promotional email and made a purchase versus those consumers who received the email and did not make a purchase

### looking at differences between between those who made a purchase and those who did not

### testing proportion of purchase versus not purchase by promocode
CrossTable (Experiment$Purchase , Experiment$PromoCode)
# IV = Type of promo, DV = Purchase with promo
test <- chisq.test (table (Experiment$Purchase, Experiment$PromoCode), correct=FALSE)
test

### independent t-tests

# IV = Purchase made, DV = Average Frequency (nb of purchase 12 month)
t.test (Experiment$Frequency ~ Experiment$Purchase, var.equal=TRUE, alternative = "greater", data = Experiment)
# IV = Purchase made, DV = Averaqe Freq_promo (nb of promo purchase 12 month)
t.test (Experiment$Freq_promo ~ Experiment$Purchase, var.equal=TRUE, alternative = "greater", data = Experiment)

## a z-test of proportion between groups for the click through rate
prop.test (x=60, n=100, p = NULL, alternative = "greater", correct = TRUE)
