# AB-Testing-Email-Subject-Line-Analysis
 A/B Testing Email Subject Line Analysis


## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.


### Prerequisites
What R packages you need to install the software and how to install them
* R version 4.2.1
* library(dplyr)
* library(psych)
* library(gmodels)
* library(ggpubr)


### Built With
* [R](https://www.r-project.org/) - Programming Language
* [tidyverse](https://www.tidyverse.org/) - Data Manipulation and Visualization


# 1. Introduction
We take a look at the database of 275 customers who registered for the rewards program. 200 consumers among those are chosen in the promotional emails experiment with the new subject lines. Half of the group received an email with the subject line “Flash Sale” and the other half received an email with the subject line “One Day Sale.” Embedded in each email is a code for 50% off that corresponds with the subject line.  
In this project, my task is to draw useful insights while exploring interesting patterns. I develop hypothesis then use the statistical tests like t-test and chi-square to test.


## 1.1 Data Description
* PromoCode: 0 – no code was used, 1- Flashsale was used, 2 –OneDay was used, 3- Birthday was used (this is a code provided to consumers for their birthday and cannot be combined with any other offers)
* Sales: amount spent (in $) during the 24-hour period
* Items: number of items purchased during the 24-hour period
* Ship: 0- ship to store, 1-ship to home
* GiftCard: 0-no gift card used, 1- gift card used (for some or all of purchase)
* Accessories: number of items purchased that qualify as an accessory 
* Clothing: number of items purchased that qualify as clothing
* Shoes: number of items purchased that qualify as shoes
* Guest: 0 - the consumer checked out as a guest, 1- consumer checked as a returning user (i.e. they are part of the rewards program)
* Frequency: number of purchases made by consumer in the last 12 months
* Freq_promo: number of times consumer has made a purchase with a promotion code in the last 12 months
* Duration: number of months enrolled in the rewards program
* Online: number of online purchases made by consumer in the last 12 months

## 1.2 Importing the required libraries
* library(dplyr)
* library(psych)
* library(gmodels)
* library(ggpubr)

# 2. Analytical Questions
## 2.1 Assessing the effectiveness of 2 experiment subject lines
Step:
* Subset customers who experiment 2 promocode subject lines 
* Create average number of online purchases (Online), number of purchases by customer (frequency) and number of purchases with promo (freq-promo) in the last 12 months
* Create new variables, make a purchase versus not make a purchase
* Looking within those who made a purchase
* Creating subset with those purchase by promocode

### Run independent t-tests
#### IV = Promocode, DV = Average sales
Results suggest a significant relationship between Promocode and Sales (t(95) = 2.5, p < 0.05). On average, Sales for promocode Flash Sale (M = 102.08, sd = 71.95) was higher than promocode One Day Sale (M = 68.88, sd = 58.39).  

#### IV = Promocode, DV = Average Frequency (nb of purchase 12 month)
Results suggest there is no significant relationship between Promocode and number of purchases made by consumer in the last 12 months (p = 0.2)

#### IV = Promocode, DV = Average Freq_promo (nb of promo purchase 12 month)
Results suggest there is no significant relationship between Promocode and number of times consumer has made a purchase with a promotion code in the last 12 months (p = 0.4)

#### IV = Promocode, DV = Average Online (nb of online purchase 12 month)
Results suggest there is no significant relationship between Promocode and number of online purchases made by consumer in the last 12 months (p = 0.1)

### Run a correlation for the variables Freq_promo and Frequency
Results indicate a significantly moderate, strong positive relationship between Fre_Promo and Frequency to purchase r(198) = 0.82, p < 0.05. This may indicate the more promocodes are sent to consumers the more purchases are made. 

## 2.2 Examining the differences between those consumers who received the promotional email and made a purchase versus those consumers who received the email and did not make a purchase

* Looking at differences between between those who made a purchase and those who did not
* Testing proportion of purchase versus not purchase by promocode
### Run chi-square test
#### IV = Type of promo, DV = Purchase with promo
Results suggest a significant relationship between Promocode and Purchase with promo (χ2(1) = 5.8, p < 0.05). In detail, there is a significantly higher percentage of purchased with Promocode One Day (59%) than Flash Sale (41%). 

### Run independent t-tests
#### IV = Purchase made, DV = Average Frequency (nb of purchase 12 month)
Results suggest there is no significant relationship between number of purchase made vs their frequency to purchase (p = 0.9)

#### IV = Purchase made, DV = Averaqe Freq_promo (nb of promo purchase 12 month)
Results suggest there is no significant relationship between number of purchase made vs their frequency to purchase with promo (p = 0.9)

#### a z-test of proportion between groups for the click through rate
Results suggest a significant relationship between make a purchase / not make a purchase and click through rate (χ2(1) = 3.6, p < 0.05)
