set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)

adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
inVal = createDataPartition(training$diagnosis, p = 3/4)[[1]]
training.train = training[inVal,]
training.val = training[-inVal,]
testing = adData[-inTrain,]

set.seed(62433)

model1 = train(diagnosis~.,data=training.train,method="rf")
model2 = train(diagnosis~.,data=training.train,method="gbm")
model3 = train(diagnosis~.,data=training.train,method="lda")

pred1.v = predict(model1,newdata=training.val)
pred2.v = predict(model2,newdata=training.val)
pred3.v = predict(model3,newdata=training.val)

combinePred = data.frame(diagnosis=training.val$diagnosis,Pred1=pred1.v,
                         Pred2=pred2.v,Pred3=pred3.v)
model4 = train(diagnosis~.,data=combinePred,method="rf")

pred1 = predict(model1,newdata=testing)
pred2 = predict(model2,newdata=testing)
pred3 = predict(model3,newdata=testing)
combinePred.test = data.frame(diagnosis=testing$diagnosis,Pred1=pred1,
                         Pred2=pred2,Pred3=pred3)
pred4 = predict(model4,newdata=combinePred.test)

confusionMatrix(testing$diagnosis,pred1)
confusionMatrix(testing$diagnosis,pred2)
confusionMatrix(testing$diagnosis,pred3)
confusionMatrix(combinePred.test$diagnosis,pred4)
