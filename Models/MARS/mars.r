library(earth)

train = read.csv("final_train.csv")
test = read.csv("final_test.csv")

name = names(train)
conti_indx = c(1, 2, 90, 91, 92)

train[, name[conti_indx]] = log(train[, name[conti_indx]]+0.1)
test[, name[conti_indx]] = log(test[, conti_indx]+0.1)

# Demo on Uni-variate MARS
mars1 <- earth(Salary ~ YearsCode, train, degree=2)
summary(mars1)$rsq
plot(mars1)


# Demo on Multi-variate MARS
## Two Continuous Input Variables
mars2 <- earth(Salary ~ YearsCode + Age, data=train, degree=2)
summary(mars2)$rsq
plot(mars2)

## One Continuous & One Cateogrical Input Variables
mars3 <- earth(Salary ~ YearsCode + Country_United.States, data=train, degree=2)
summary(mars3)$rsq
plot(mars3)


# Train on Use Full Inputs Variabeles

## Use All Continuous Input Variables
## "Age", "OrgSize", "YearsCode", "YearsCodePro"
fm1 = paste(name[conti_indx[-1]], sep="", collapse="+") 
fm1 = as.formula(paste('Salary ~', fm1))
fm1

mars4 <- earth(fm1, data=train, degree=2)
summary(mars4)$rsq
plot(mars4)


## Use All Categorical Input Variables
## "EdLevel", "Country_XXX", ... "Skills", ...
fm2 = paste(name[-conti_indx], sep="", collapse="+") 
fm2 = as.formula(paste('Salary ~', fm2))
fm2

mars5 <- earth(fm2, data=train, degree=2) # < 1 minute
summary(mars5)$rsq
plot(mars5)

## Use All Continuous & Categorical Input Variables
fm3_conti = paste(name[conti_indx[-1]], sep="", collapse="+") 
fm3_categ = paste(name[-c(1, conti_indx)], sep="", collapse="+") 
fm3 = as.formula(paste('Salary ~', fm3_conti, "+", fm3_categ))
fm3

mars6 <- earth(fm3, data=train, degree=2) # < 2 minute
summary(mars6)$rsq
plot(mars6)


# Test
## RMSE
mars4.pred <- predict(mars4, test)
mars4.rsq <- 1 - sum((mars4.pred - test$Salary)^2) / sum((mean(test$Salary) - test$Salary)^2)
mars4.rsq
mars4.rmse <- sqrt(mean(
    (test$Salary - mars4.pred)^2
))
mars4.rmse

mars5.pred <- predict(mars5, test)
mars5.rsq <- 1 - sum((mars5.pred - test$Salary)^2) / sum((mean(test$Salary) - test$Salary)^2)
mars5.rsq
mars5.rmse <- sqrt(mean(
    (test$Salary - mars5.pred)^2
))
mars5.rmse


mars6.pred <- predict(mars6, test)
mars6.rsq <- 1 - sum((mars6.pred - test$Salary)^2) / sum((mean(test$Salary) - test$Salary)^2)
mars6.rsq
mars6.rmse <- sqrt(mean(
    (test$Salary - mars6.pred)^2
))
mars6.rmse

## Count Negatives

sum(mars4.pred < 1.0)
sum(mars5.pred < 1.0)
sum(mars6.pred < 1.0)

## Check Mean Salary

exp(mean(mars4.pred))
exp(mean(mars5.pred))
exp(mean(mars6.pred))

