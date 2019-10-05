set.seed(3523)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

set.seed(325)
library(e1071)

model1 = svm(CompressiveStrength~.,data=training)
sqrt(mean((testing$CompressiveStrength-predict(model1,newdata=testing))^2))
