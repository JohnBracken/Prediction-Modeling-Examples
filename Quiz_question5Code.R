
#Open the necessary libraries
library(ElemStatLearn)
library(caret)

#Test and training data
data(vowel.train)
data(vowel.test)

#Convert y values to factor variables.
vowel.test$y <- as.factor(vowel.test$y)
vowel.train$y <- as.factor(vowel.train$y)

#Set random seed for reproducibility
set.seed(33833)

#Create a predictive random forest model on the traning data.
#Include the importance levels for each predictor variable.
modfit <- randomForest(y~., data=vowel.train, method = "rf", importance = TRUE)

#Store and print the variable importance table.
importance_var <- importance(modfit)
print(importance_var)