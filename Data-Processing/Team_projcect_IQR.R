library(ElemStatLearn)
library(dplyr)
library("caTools")
predict.regsubsets=function(object, newdata, id,...){
  form=as.formula(object$call[[2]])
  mat=model.matrix(form, newdata)
  coefi=coef(object, id=id)
  mat[, names(coefi)]%*%coefi
}

k=5
set.seed(1)
folds=sample(1:k,nrow(train),replace=TRUE)
cv.errors=matrix(NA,k,8,dimnames=list(NULL,paste(1:8)))

data<-read.csv("final_train.csv")
dim(data)
arrange(data,desc(Salary))
quantile(data$Salary,probs = c(0.25,0.75,0.90 )) 
final<-data[data$Salary<110000+(110000-35796),]
final
require(caTools)
set.seed(101) 
sample = sample.split(final$Salary, SplitRatio = 0.70)
train = subset(final, sample == TRUE)
test  = subset(final, sample == FALSE)
train
write.csv(train,file='final_train.csv',row.names=TRUE)
write.csv(test,file='final_test.csv',row.names=TRUE)
write.csv(final,file='final_data.csv',row.names = TRUE)

library(leaps)
library(boot)
BSS=regsubsets(Salary~.,data,nvmax=101)
FSS=regsubsets(Salary~.,data,nvmax=101,method="forward")
plot(summary(FSS)$cp,xlab="Number of Variables",ylab="Cp")
cp=which.min(summary(FSS)$cp)
cp
plot(summary(FSS)$bic,xlab="Number of Variables",ylab="bic")
bic=which.min(summary(FSS)$bic)
bic
for(j in 1:10){
  best.fit=regsubsets(Salary~.,data=data[folds!=j,],nvmax=101)
  for(i in 1:8){
    pred=predict(best.fit,train[folds==j,],id=i)
    cv.errors[j,i]=mean((data$Salary[folds==j]-pred)^2)
  }
}