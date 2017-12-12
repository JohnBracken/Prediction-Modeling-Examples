#Predicting outcomes using recursive partitioning and regression trees.

#Load the predictive modeling library to look at a datasets, segmentationOriginal.
#Also need the caret library to train the tree model and rattle to do regression tree plots.
library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
library(rattle)

#Split traing and test datasets based on the case type.
training <- segmentationOriginal[segmentationOriginal$Case=="Train", ]
test<-segmentationOriginal[segmentationOriginal$Case=="Test", ]

#Set a seed to provide reproducability of the model Fit and prediction data.
set.seed(125)

#Create the tree model using the train command on the training dataset.
modFit <- train(Class~., method = "rpart", data=training)

#Predict the class of the segmentation based on using this model on the test data.
predicted <- predict(modFit, newdata=test)

#Print and plot the final model.  The plot shows the classification tree based on the
#model.
print(modFit$FinalModel)
fancyRpartPlot(modFit$finalModel)