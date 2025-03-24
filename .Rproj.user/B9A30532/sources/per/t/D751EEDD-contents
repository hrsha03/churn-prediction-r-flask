# main.R - Modified to accept arguments
args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]  # e.g., "uploads/input.csv"
output_file <- args[2] # e.g., "outputs/output.csv"

library(readr)
library(dplyr)
library(tidyr)

source("testData.R")

input_data <- read_csv(input_file)

df <- rf_model$trainingData[, -which(names(rf_model$trainingData) == ".outcome")]

process_row <- function(row, ref_data) {
  return(data.frame(
    CustomerID = row$CustomerID,
    Tenure = row$Tenure,
    PreferredLoginDevice = factor(row$PreferredLoginDevice, levels = levels(ref_data$PreferredLoginDevice), exclude = NULL),
    CityTier = row$CityTier,
    WarehouseToHome = row$WarehouseToHome,
    PreferredPaymentMode = factor(row$PreferredPaymentMode, levels = levels(ref_data$PreferredPaymentMode), exclude = NULL),
    Gender = factor(row$Gender, levels = levels(ref_data$Gender), exclude = NULL),
    HourSpendOnApp = row$HourSpendOnApp,
    NumberOfDeviceRegistered = row$NumberOfDeviceRegistered,
    PreferedOrderCat = factor(row$PreferedOrderCat, levels = levels(ref_data$PreferedOrderCat), exclude = NULL),
    SatisfactionScore = row$SatisfactionScore,
    MaritalStatus = factor(row$MaritalStatus, levels = levels(ref_data$MaritalStatus), exclude = NULL),
    NumberOfAddress = row$NumberOfAddress,
    Complain = row$Complain,
    OrderAmountHikeFromlastYear = row$OrderAmountHikeFromlastYear,
    CouponUsed = row$CouponUsed,
    OrderCount = row$OrderCount,
    DaySinceLastOrder = row$DaySinceLastOrder,
    CashbackAmount = row$CashbackAmount
  ))
}

output_data <- data.frame()

for (i in 1:nrow(input_data)) {
  row <- input_data[i, ]
  processed_row <- process_row(row, df) %>% drop_na()

  if (nrow(processed_row) > 0) {
    prediction_result <- testData(processed_row)
    output_data <- rbind(output_data, cbind(CustomerID = row$CustomerID, prediction_result))
  }
}

write_csv(output_data, output_file)
print(paste("Predictions saved to", output_file))
