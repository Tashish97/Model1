# importing necessary libraries
library(tidyverse)
library(randomForest)
library(MLmetrics)
library(caTools)

#importing the dataset
df <- read.csv("Computer_Data.csv",stringsAsFactors = TRUE)
summary(df)

#dropping list column
df <- df[-c(1)]

#train test split
sample <- sample.split(df$price,.7)
train <- df[sample,]
test <- df[!sample,]


#modelling with default parameters
model1 <- randomForest(price~.,data = train)
predictions <- predict(model1,test[-1])

plot(model1)
# error decreases after ntree>300, so ntree =300
MAE(predictions,test[,1])
MAPE(predictions,test[,1])*100

colSums(is.na(df))

#hyper-paramter tuning (finding best mtry)
model2 <- tuneRF(train[,-1],train[,1],ntreeTry = 300, trace = TRUE, plot = TRUE)
test[14,]

print(model1)

temp <- data.frame(speed=as.integer(33),hd=as.integer(130),ram=as.integer(4),
                   screen=as.integer(14),cd=c("no"),multi=c("no"),premium=c("yes"),
                    stringsAsFactors = TRUE)
#model1$forest$xlevels$cd
levels(temp$cd) <- model1$forest$xlevels$cd
levels(temp$multi) <- model1$forest$xlevels$multi
levels(temp$premium) <- model1$forest$xlevels$premium

tmodel <- randomForest(price~.,data = train, mtry = 6, ntree =300)
print(tmodel)

predictions <- predict(tmodel,test)
MAE(predictions,test[,1])
MAPE(predictions,test[,1])*100
RMSE(predictions,test[,1])

predict(tmodel,temp)

saveRDS(tmodel,"model.rds")

