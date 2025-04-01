# Customer Churn Analysis App

## How to Run  
- Run app.py: `python app.py`  
- Access localhost: [http://127.0.0.1:5000/](http://127.0.0.1:5000/)  

## Input  
- Upload a CSV file → refer `\static` for sample data  

## Output  
- Download processed CSV file → refer `\outputs` for sample output


## Documentation  

### Objective  
Develop an accurate churn prediction system that helps businesses retain customers by leveraging data-driven insights to enhance decision-making and engagement strategies.  

### Implementation Outline  
The framework follows a modular pipeline:  

1. **Data Preprocessing** – Handle missing values, encode categorical variables, and balance data using ROSE.  
2. **Model Training** – Train Decision Tree, Random Forest, and XGBoost models.  
3. **Prediction & API Integration** – Process input CSV files, apply trained models, and aggregate predictions using majority voting and weighted averages.  
4. **Frontend & Output** – Serve predictions via a Plumber API, integrated into a Flask-based UI, with downloadable results in CSV format.  

### Results  

#### Dataset  
- **Source:** Kaggle (Refer `\data\training_dataset.csv`)  
- **Preprocessing Steps:**  
  - Train-test split: 80:20 ratio  
  - Remove rows with null values  
  - Encode categorical attributes for uniform analysis

#### Prediction of Churn

##### Sample Input file

##### Attributes

##### Data Pre-Processing

##### Individual model results

##### Aggregated Prediction Result 

##### Sample Output file


### Performance Analysis

#### Metrics for evaluation

#### Understanding Confusion matrix

#### Peformnace Metrics of trained models

#### Feature Importance Trends

1. **XGBoost Model**
2. **Decision Tree**
3. **Random Forest**

## Limitations and Overview




