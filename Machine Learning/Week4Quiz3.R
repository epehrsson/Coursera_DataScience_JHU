set.seed(3523)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

set.seed(223)

model1 = train(CompressiveStrength~.,data=concrete,method="lasso")
plot(model1$finalModel,use.color=TRUE,xvar="penalty")