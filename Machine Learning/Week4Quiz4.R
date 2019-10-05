library(lubridate) # For year() function below
library(forecast)

dat = read.csv("~/gaData.csv")
training = dat[lubridate::year(as.POSIXct(dat$date,format="%m/%d/%Y")) < 2012,]
testing = dat[(lubridate::year(as.POSIXct(dat$date,format="%m/%d/%Y"))) > 2011,]
tstrain = ts(training$visitsTumblr)

model1 = bats(tstrain)
pred = forecast(tstrain,model=model1,h=235)
