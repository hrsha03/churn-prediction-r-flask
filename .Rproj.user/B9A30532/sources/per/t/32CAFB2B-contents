# install packages if not present
if (!require("tidyverse")) {  install.packages("tidyverse") }
if (!require("caret")) {  install.packages("caret") }
if (!require("xgboost")) {  install.packages("xgboost") }
if (!require("ROSE")) {  install.packages("ROSE") }
if (!require("e1071")) {  install.packages("e1071") }

# load packages
library(tidyverse)
library(caret)
library(xgboost)
library(ROSE)
library(e1071)

# Load Data
df <- read.csv("data/training_dataset.csv")

# Display Basic Info
print(dim(df))

# data pre processing
# Convert categorical variables to factors
df <- df %>% mutate_if(is.character, as.factor)

# Handling Missing Values
df <- df %>% drop_na()

# Encode Categorical Variables
df$Churn <- as.factor(df$Churn)

# test-train split
set.seed(123)
trainIndex <- createDataPartition(df$Churn, p=0.8, list=FALSE)
trainData <- df[trainIndex, ]
testData <- df[-trainIndex, ]

# handle class imbalance
trainData <- ROSE(Churn ~ ., data=trainData, seed=123)$data

# train models
# Train Decision Tree Model
dt_model <- train(Churn ~ ., data=trainData, method="rpart", trControl=trainControl(method="cv", number=5))

# Train Random Forest Model
rf_model <- train(Churn ~ ., data=trainData, method="rf", trControl=trainControl(method="cv", number=5))

# Train XGBoost Model
xgb_model <- train(
  Churn ~ .,
  data = trainData,
  method = "xgbTree",
  trControl = trainControl(method = "cv", number = 5),
  tuneGrid = expand.grid(
    nrounds = 100,
    max_depth = 6,
    eta = 0.3,
    gamma = 0,
    colsample_bytree = 1,
    min_child_weight = 1,
    subsample = 1
  )
)

# save models
saveRDS(rf_model, "models/rf_model.rds")
saveRDS(xgb_model, "models/xgb_model.rds")
saveRDS(dt_model, "models/dt_model.rds")