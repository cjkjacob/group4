## This is a markdown title

in markdown we can create lists:
- item 1
- item 2
- item 3
- item 4

also we can create enumerate list
1. Hola
2. Hi
3. Namaste

we can do **bold**, also *italic*


```python
# Here we are importing numpy with a nickname np
import numpy as np
arr = np.array([1, 2, 3, 4, 5])
```


```python
print(np.absolute(-1))
np.absolute(-1)
print(arr)
```

    1
    [1 2 3 4 5]
    


```python
# list are native to python
my_list = [1,2,3,4,5]
print(my_list)
```

    [1, 2, 3, 4, 5]
    


```python
# We will using a lot of data frames, so we need pandas library

import pandas as pd
data = {'Ozone': [41, 36, 12], 'Temp': [67, 72, 74]}
df = pd.DataFrame(data)
print(df)
```

       Ozone  Temp
    0     41    67
    1     36    72
    2     12    74
    

## 4 Loading csv files

To load .csv files into a `DataFrame`. we use the pandas function `read_csv`:



```python
df = pd.read_csv('airquality_datasets.csv')
```


```python
# Summary of the dataset
print(df.info())
print(df.describe())
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
                Ozone     Solar.R        Wind        Temp       Month         Day
    count  116.000000  146.000000  153.000000  153.000000  153.000000  153.000000
    mean    42.129310  185.931507    9.957516   77.882353    6.993464   15.803922
    std     32.987885   90.058422    3.523001    9.465270    1.416522    8.864520
    min      1.000000    7.000000    1.700000   56.000000    5.000000    1.000000
    25%     18.000000  115.750000    7.400000   72.000000    6.000000    8.000000
    50%     31.500000  205.000000    9.700000   79.000000    7.000000   16.000000
    75%     63.250000  258.750000   11.500000   85.000000    8.000000   23.000000
    max    168.000000  334.000000   20.700000   97.000000    9.000000   31.000000
    

## 5. Visualizing the dataset

Let’s dive into visualizations using matplotlib. We’ll start with simple histograms and boxplots, then move on to correlation plots.

### Histograms
Histograms help us understand the distribution of the variables. We’ll create histograms for Ozone and Temp.


```python
import matplotlib.pyplot as plt

# Ozone Histogram
plt.figure(figsize=(8, 6))
plt.hist(df['Ozone'].dropna(), bins=20, color='blue', edgecolor='black')
plt.title('Distribution of Ozone Levels')
plt.xlabel('Ozone (ppb)')
plt.ylabel('Frequency')
plt.show()

```


    
![png](Week_4_Diego_files/Week_4_Diego_9_0.png)
    



```python
# Temp Histogram
plt.figure(figsize=(8, 6))
plt.hist(df['Temp'].dropna(), bins=20, color='orange', edgecolor='black')
plt.title('Distribution of Temperature')
plt.xlabel('Temperature (°F)')
plt.ylabel('Frequency')
plt.show()
```


    
![png](Week_4_Diego_files/Week_4_Diego_10_0.png)
    



```python

```
