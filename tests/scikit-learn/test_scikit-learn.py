#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import datetime
import numpy as np
from sklearn.linear_model import LinearRegression, LogisticRegression
from sklearn.model_selection import train_test_split
from sklearn.model_selection import KFold
from sklearn.model_selection import cross_val_score
from sklearn.metrics import mean_squared_log_error, mean_squared_error
from sklearn.preprocessing import MinMaxScaler
from sklearn.linear_model import Lasso
from sklearn.linear_model import Ridge
from sklearn.feature_selection import SequentialFeatureSelector
from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import Pipeline
from sklearn.model_selection import cross_validate
from sklearn.model_selection import GridSearchCV
from sklearn.feature_selection import VarianceThreshold
from sklearn.model_selection import TimeSeriesSplit

import warnings
warnings.filterwarnings('ignore')


# In[2]:


# df = pd.read_csv('taxi_dataset_with_target.csv', index_col=0)
# df = df.head(10)


# In[3]:


# data_dict = df.to_dict(orient='list')


# In[4]:


new_df = pd.DataFrame({'vendor_id': [1, 0, 1, 1, 1, 1, 0, 1, 0, 1],
 'pickup_datetime': ['2016-03-14 17:24:55',
  '2016-06-12 00:43:35',
  '2016-01-19 11:35:24',
  '2016-04-06 19:32:31',
  '2016-03-26 13:30:55',
  '2016-01-30 22:01:40',
  '2016-06-17 22:34:59',
  '2016-05-21 07:54:58',
  '2016-05-27 23:12:23',
  '2016-03-10 21:45:01'],
 'passenger_count': [930.3997532751514,
  930.3997532751514,
  930.3997532751514,
  930.3997532751514,
  930.3997532751514,
  1061.35522313947,
  1053.5297493310802,
  930.3997532751514,
  930.3997532751514,
  930.3997532751514],
 'store_and_fwd_flag': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
 'trip_duration': [455.0,
  663.0,
  2124.0,
  429.0,
  435.0,
  443.0,
  341.0,
  1551.0,
  255.00000000000003,
  1225.0],
 'distance_km': [1.5004789467430026,
  1.807119412113964,
  6.392080252604317,
  1.487154705417205,
  1.1899254482788029,
  1.1001071911011966,
  1.3278523894831542,
  5.722426850861645,
  1.311541055213959,
  5.126939275009514]})


# In[5]:


X = new_df.drop(['pickup_datetime', 'trip_duration'], axis=1)
Y = new_df['trip_duration']


# In[6]:


model=LinearRegression()
model.fit(X, Y)


# In[7]:


model.coef_, model.intercept_


# In[8]:


X_train, X_test, y_train, y_test = train_test_split(X, Y, 
                                                    test_size=0.2, 
                                                    random_state=42)


# In[9]:


splitter = KFold(n_splits=8, shuffle=True, random_state=33)


# In[10]:


model = LinearRegression() 

cv_scores = cross_val_score(
    model,
    X_train,
    y_train,
    cv=splitter, 
    scoring='neg_mean_squared_error',  
)

mse_scores = -cv_scores
print("MSE на каждой fold:", mse_scores)
print(f"Среднее MSE: {np.mean(mse_scores):.4f} ± {np.std(mse_scores):.4f}")


# In[11]:


model = LinearRegression()
model.fit(X_train, y_train)
y_pred_log = model.predict(X_test)
y_pred_original = np.exp(y_pred_log) - 1
y_test_original = np.exp(y_test) - 1
msle = mean_squared_log_error(y_test_original, y_pred_original)
rmse = np.sqrt(mean_squared_error(y_test_original, y_pred_original))

print(f"MSLE на тесте: {msle:.4f}")


# In[12]:


scores = []
selector = KFold(n_splits=4)

for train_index, test_index in selector.split(X):
    
    X_train, X_test = X.values[train_index], X.values[test_index]
    Y_train, Y_test = Y.values[train_index], Y.values[test_index]
    
    scaler = MinMaxScaler()
    scaler.fit(X_train)
    
    X_train_scaled = scaler.transform(X_train)
    X_test_scaled = scaler.transform(X_test)
    
    model_lasso = Lasso(max_iter=100000) 
    model_lasso.fit(X_train_scaled, Y_train)
    
    predictions = model_lasso.predict(X_test_scaled)
    
    scores.append(np.mean((predictions - Y_test)**2))

    
print(f"MSLE на Кросс-валидации равен: {np.mean(scores)}")


# In[13]:


for train_index, test_index in selector.split(X):
    
    X_train, X_test = X.values[train_index], X.values[test_index]
    Y_train, Y_test = Y.values[train_index], Y.values[test_index]
    
    scaler = MinMaxScaler()
    scaler.fit(X_train)
    
    X_train_scaled = scaler.transform(X_train)
    X_test_scaled = scaler.transform(X_test)
    
    
    model_lasso = Ridge(max_iter=100000, alpha=0.2) 
    model_lasso.fit(X_train_scaled, Y_train)
    
    predictions = model_lasso.predict(X_test_scaled)
    
    scores.append(np.mean((predictions - Y_test)**2))

    
print(f"MSLE на Кросс-валидации равен: {np.mean(scores)}")


# In[14]:


sfs = SequentialFeatureSelector(model, n_features_to_select=2)
sfs.fit(X, Y)
sfs.get_feature_names_out()


# In[15]:


y_pred = model.predict(X)
mse = mean_squared_error(Y, y_pred)

print("Выбранные признаки:", X.columns.tolist())
print(f"MSE на всех данных: {mse:.4f}")


# In[19]:


pipe = Pipeline([
    ('scaler', StandardScaler()),  
    ('logreg', LogisticRegression(penalty=None))  
])


# In[20]:


custom_cv = [(pd.DataFrame(X_train).index.to_list(), pd.DataFrame(X_test).index.to_list())]

begin_time = datetime.datetime.now()

cv_result_pipe = cross_validate(pipe, X, Y, scoring='accuracy',
                                cv=custom_cv, return_train_score=True)


print(f"Accuracy на трейне: {np.mean(cv_result_pipe['train_score']).round(3)}")
print(f"Accuracy на тесте: {np.mean(cv_result_pipe['test_score']).round(3)}")


# In[21]:


alphas = np.linspace(0.01, 100, 100)


# In[22]:


param_grid = {
    "Lasso__alpha": alphas
}

search = GridSearchCV(pipe, param_grid, 
                      cv=splitter, scoring='neg_mean_squared_error')


# In[25]:


numeric_columns = new_df.loc[:,new_df.dtypes!=object].columns
cutter = VarianceThreshold(threshold=0.1)
cutter.fit(new_df[numeric_columns])
constant_cols = [x for x in numeric_columns if x not in cutter.get_feature_names_out()]


# In[27]:


categorical_columns = new_df.loc[:,new_df.dtypes==object].columns


# In[28]:


for col in categorical_columns:
    if col != 'timestamp': 
        if new_df[col].nunique() < 5:
            one_hot = pd.get_dummies(new_df[col], prefix=col, drop_first=True)
            new_df = pd.concat((new_df.drop(col, axis=1), one_hot), axis=1)

        else:
            mean_target = new_df.groupby(col)['trip_duration'].mean()
            new_df[col] = new_df[col].map(mean_target)


# In[29]:


splitter = TimeSeriesSplit(n_splits=4)


# In[ ]:


