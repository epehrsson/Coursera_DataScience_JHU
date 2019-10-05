library(caret)
library(gbm)
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)

vowel.train$y = as.factor(vowel.train$y)
vowel.test$y = as.factor(vowel.test$y)

set.seed(33833)

model1 = train(y~., data=vowel.train, method="rf")
model2 = train(y~., data=vowel.train, method="gbm")

predictions = as.data.frame(cbind(vowel.test$y,predict(model1,newdata=vowel.test),
      predict(model2,newdata=vowel.test)))
colnames(predictions) = c("Truth","Model1","Model2")
