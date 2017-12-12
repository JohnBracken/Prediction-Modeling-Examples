#Load the olive data and all necessary libraries.
library(pgmm)
library(rattle)
data(olive)
olive=olive[,-1]
library(caret)

#Do the model fit using trees.
modFit <- train(Area~.,method="rpart", data=olive)

#Generate the new test data.
new <- as.data.frame(t(colMeans(olive)))

#Make a prediction using the tree model on the new model fit.
prediction <- predict(modFit, newdata=new)

#Print and plot the model fit to the olive data.
print(modFit$finalModel)
fancyRpartPlot(modFit$finalModel)