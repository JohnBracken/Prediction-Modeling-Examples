library(ElemStatLearn)
library(caret)
data(SAheart)
set.seed(8484)

#Set the training indices and get the training and test data set
train = sample(1:dim(SAheart)[1], size = dim(SAheart)[1]/2, replace=F)
trainSA = SAheart[train,]
testSA =SAheart[-train,]

#Convert chd to a factor variable.
trainSA$chd <- as.factor(as.character(trainSA$chd))
testSA$chd <- as.factor(as.character(testSA$chd))
set.seed(13234)

#Create the logistic regression fit based on multiple predictors.
fitMod <- train(as.factor(chd)~age+alcohol+obesity+tobacco+typea+ldl, method ="glm", family="binomial",data=trainSA)

#Predict the chd state for the test and training datasets
pred_training <- predict(fitMod,trainSA[,-10])
pred_test <- predict(fitMod, testSA[,-10])

#convert chd back to numeric values for misclassification
trainSA$chd <- as.numeric(as.character(trainSA$chd))
testSA$chd <- as.numeric(as.character(testSA$chd))

pred_training <- as.numeric(as.character(pred_training))
pred_test <- as.numeric(as.character(pred_test))

#Define the missclassification function.
missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}

#Calcluate the percent missclassification for the training and test datasets.  
train_misclass <- missClass(trainSA$chd, pred_training)
test_misclass <- missClass(testSA$chd, pred_test)