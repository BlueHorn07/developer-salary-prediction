library(mgcv)

train = read.csv("final_train.csv")
test = read.csv("final_test.csv")

name = names(train)
conti_indx = c(1, 2, 90, 91, 92)

# Demo on Uni-variate GAM
gam1 <- gam(Salary ~ s(YearsCode), data=train, method="REML")
summary(gam1)$r.sq
plot(gam1)


# Demo on Multi-variate GAM
## Two Continuous Input Variables
gam2 <- gam(Salary ~ s(YearsCode) + s(Age), data=train, method="REML")
summary(gam2)$r.sq
plot(gam2)

## Ont Continuous & One Cateogrical Input Variables
gam3 <- gam(Salary ~ s(YearsCode) + Country_United.States, data=train, method="REML")
summary(gam3)$r.sq
plot(gam3)

# Train on Use Full Inputs Variabeles

## Use All Continuous Input Variables
## "Age", "OrgSize", "YearsCode", "YearsCodePro"
fm1 = paste('s(', name[conti_indx[-1]], ')', sep="", collapse="+") 
fm1 = as.formula(paste('Salary ~', fm1))
fm1

gam4 <- gam(fm1, data=train, method="REML")
summary(gam4)$r.sq
plot(gam4)

## Use All Categorical Input Variables
## "EdLevel", "Country_XXX", ... "Skills", ...
fm2 = paste(name[-conti_indx], sep="", collapse="+") 
fm2 = as.formula(paste('Salary ~', fm2))
fm2

gam5 <- gam(fm2, data=train, method="REML") # < 1 minutes
summary(gam5)$r.sq

## Use All Continuous & Categorical Input Variables
fm3_conti = paste('s(', name[conti_indx[-1]], ')', sep="", collapse="+") 
fm3_categ = paste(name[-c(1, conti_indx)], sep="", collapse="+") 
fm3 = as.formula(paste('Salary ~', fm3_conti, "+", fm3_categ))
fm3

gam6 <- gam(fm3, data=train, method="REML") # < 3 minutes
summary(gam6)$r.sq
plot(gam6)


# Test

## R-squared & RMSE
gam4.pred <- predict(gam4, test)
gam4.rsq <- 1 - sum((gam4.pred - test$Salary)^2) / sum((mean(test$Salary) - test$Salary)^2)
gam4.rsq
gam4.rmse <- sqrt(mean(
    (test$Salary - gam4.pred)^2
))
gam4.rmse

gam5.pred <- predict(gam5, test)
gam5.rsq <- 1 - sum((gam5.pred - test$Salary)^2) / sum((mean(test$Salary) - test$Salary)^2)
gam5.rsq
gam5.rmse <- sqrt(mean(
    (test$Salary - gam5.pred)^2
))
gam5.rmse


gam6.pred <- predict(gam6, test)
gam6.rsq <- 1 - sum((gam6.pred - test$Salary)^2) / sum((mean(test$Salary) - test$Salary)^2)
gam6.rsq
gam6.rmse <- sqrt(mean(
    (test$Salary - gam6.pred)^2
))
gam6.rmse

## Count Negatives

sum(gam4.pred < 0)
sum(gam5.pred < 0)
sum(gam6.pred < 0)

## Check Mean Salary

mean(gam4.pred)
mean(gam5.pred)
mean(gam6.pred)
