# Load models
rf_model <- readRDS("models/rf_model.rds")
xgb_model <- readRDS("models/xgb_model.rds")
dt_model <- readRDS("models/dt_model.rds")

# Extract factor levels from one of the trained models
train_data <- rf_model$trainingData  # Extract the training dataset from the model

# Function to predict churn and probabilities
prediction <- function(model, data) {
  churn_pred <- predict(model, newdata = data)
  churn_prob <- predict(model, newdata = data, type = "prob")
  
  # Convert churn prediction to numeric (handle factor levels)
  churn_numeric <- as.numeric(as.character(churn_pred))
  
  return(list(Churn = churn_numeric, Probabilities = churn_prob))
}

# Function to get final predictions using ensemble models
testData <- function(data) {
  rf_result <- prediction(rf_model, data)
  dt_result <- prediction(dt_model, data)
  xgb_result <- prediction(xgb_model, data)
  
  # Aggregate predictions
  final_churn <- as.integer(round(mean(c(rf_result$Churn, dt_result$Churn, xgb_result$Churn))))  # Majority vote
  final_probabilities <- (rf_result$Probabilities + dt_result$Probabilities + xgb_result$Probabilities) / 3  # Average probabilities
  
  # Return final result as dataframe
  return(data.frame(Churn = final_churn, Prob_0 = final_probabilities[,1], Prob_1 = final_probabilities[,2]))
}
