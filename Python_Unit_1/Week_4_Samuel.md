### **This is a markdown Python**



```python
in a markdown, we can create lists 

-item 1 
- item2 
-item 3

also we can create enumae,rsted lists 
1. hola 
2. hello 
3. namaste 

```

### **Here we are importing numpy with a nickname np**


print (np.absolute(-1))
import numpy as np
arr = np.array([1, 2, 3, 4, 5])
print(arr)


### **List are native to python**



```python
my_list = [1, 2, 3, 4, 5]
print( my_list)

```

    [1, 2, 3, 4, 5]
    

### **We will be using a lot of data frames , so we need pandas library**



```python
import pandas as pd
data = {'Ozone': [41, 36, 12], 'Temp': [67, 72, 74]}
df = pd.DataFrame(data)  
print(df)
```

       Ozone  Temp
    0     41    67
    1     36    72
    2     12    74
    

#### Load CSV files 

to load a.csv file into a `Data Frame`, use the pandas function 
`read_.csv`


```python
df = pd.read_csv('airquality_datasets.csv')
```


```python

print(df.info())
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 153 entries, 0 to 152
    Data columns (total 6 columns):
     #   Column   Non-Null Count  Dtype  
    ---  ------   --------------  -----  
     0   Ozone    116 non-null    float64
     1   Solar.R  146 non-null    float64
     2   Wind     153 non-null    float64
     3   Temp     153 non-null    int64  
     4   Month    153 non-null    int64  
     5   Day      153 non-null    int64  
    dtypes: float64(3), int64(3)
    memory usage: 7.3 KB
    None
    

print (df.info())
print(df.describe())


#### **Visualizing data set**



```python

import matplotlib.pyplot as plt

# Ozone Histogram
plt.figure(figsize=(8, 6))
plt.hist(df['Ozone'].dropna(), bins=20, color='blue', edgecolor='black')
plt.title('Distribution of Ozone Levels')
plt.xlabel('Ozone (ppb)')
plt.ylabel('Frequency')
plt.show()

# Temp Histogram
plt.figure(figsize=(8, 6))
plt.hist(df['Temp'].dropna(), bins=20, color='orange', edgecolor='black')
plt.title('Distribution of Temperature')
plt.xlabel('Temperature (°F)')
plt.ylabel('Frequency')
plt.show()
```


    
![png](Week_4_Samuel_files/Week_4_Samuel_13_0.png)
    



    
![png](Week_4_Samuel_files/Week_4_Samuel_13_1.png)
    



```python
#box plot 
# Boxplot for Ozone
plt.figure(figsize=(8, 6))
plt.boxplot(df['Ozone'].dropna())
plt.title('Boxplot of Ozone Levels')
plt.ylabel('Ozone (ppb)')
plt.show()

# Boxplot for Temp
plt.figure(figsize=(8, 6))
plt.boxplot(df['Temp'].dropna())
plt.title('Boxplot of Temperature')
plt.ylabel('Temperature (°F)')
plt.show()
```


    
![png](Week_4_Samuel_files/Week_4_Samuel_14_0.png)
    



    
![png](Week_4_Samuel_files/Week_4_Samuel_14_1.png)
    



```python

```
