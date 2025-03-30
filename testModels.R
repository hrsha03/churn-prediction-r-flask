# load packages
library(tidyverse)
library(caret)
library(xgboost)
library(ROSE)
library(e1071)

# load models
rf_model <- readRDS("models/rf_model.rds")
xgb_model <- readRDS("models/xgb_model.rds")
dt_model <- readRDS("models/dt_model.rds")


#function for confusion matrix
confusion_matrix<-function(model, testData){
  y_pred <- predict(model, newdata=testData)
  conf_matrix <- confusionMatrix(y_pred, as.factor(testData$Churn))
  return (conf_matrix)
}

# Performance metrics for trained models
compute_metrics <- function(conf_matrix) {
  TP <- conf_matrix$table[2, 2]  # True Positives
  FP <- conf_matrix$table[1, 2]  # False Positives
  FN <- conf_matrix$table[2, 1]  # False Negatives
  TN <- conf_matrix$table[1, 1]  # True Negatives
  
  Accuracy <- (TP + TN) / sum(conf_matrix$table)
  Precision <- TP / (TP + FP)
  Recall <- TP / (TP + FN)
  F1_Score <- 2 * (Precision * Recall) / (Precision + Recall)
  Jaccard <- TP / (TP + FP + FN)
  
  print(paste("Accuracy: ", Accuracy))
  print(paste("Precision: ", Precision))
  print(paste("Recall: ", Recall))
  print(paste("F1 Score: ", F1_Score))
  print(paste("Jaccard Index: ", Jaccard))
}

# function to plot feature importance
plot_feature_importance <- function(model) {
  if ("randomForest" %in% class(model)) {
    importance_df <- as.data.frame(importance(model))
    importance_df$Feature <- rownames(importance_df)
    importance_df <- importance_df %>% arrange(desc(MeanDecreaseGini))
  } else if ("train" %in% class(model)) {
    importance_df <- varImp(model)$importance
    importance_df$Feature <- rownames(importance_df)
    importance_df <- importance_df %>% arrange(desc(Overall))
  } else {
    stop("Model type not trained for feature importance extraction")
  }
  
  ggplot(importance_df, aes(x = reorder(Feature, desc(importance_df[,1])), y = importance_df[,1])) +
    geom_bar(stat = "identity", fill = "steelblue") +
    coord_flip() +xlab("Test Attribute") +
    ylab("Feature Importance") +
    ggtitle(paste("Feature Importance -", model)) +
    theme_minimal()
}

# ANALYSIS OF RESULTS

# DT model
conf_matrix1<-confusion_matrix(dt_model, testData)
compute_metrics(conf_matrix1)
plot_feature_importance(dt_model)

#RF model
conf_matrix2<-confusion_matrix(rf_model, testData)
compute_metrics(conf_matrix2)
plot_feature_importance(rf_model)

#XGBoost model
conf_matrix3<-confusion_matrix(xgb_model, testData)
compute_metrics(conf_matrix3)
plot_feature_importance(xgb_model)