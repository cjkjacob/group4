```python
import pandas as pd
import matplotlib.dates as mdates
from plotnine import ggplot, aes, geom_point, labs

# Read the XLS file
data = pd.read_csv('Midterm_Project2_final.csv')

# Assuming your date column is named 'Date' (replace 'Date' with your actual column name)
data['DATE'] = pd.to_datetime(data['DATE'])  # Convert the 'Date' column to datetime
data.set_index('DATE', inplace=True)  # Set 'Date' as the index
data.index = pd.to_datetime(data.index)

# Info on the data
print(data.index.min(), data.index.max())
data.info()
```

    2014-01-01 00:00:00 2024-08-01 00:00:00
    <class 'pandas.core.frame.DataFrame'>
    DatetimeIndex: 128 entries, 2014-01-01 to 2024-08-01
    Data columns (total 5 columns):
     #   Column                                                       Non-Null Count  Dtype  
    ---  ------                                                       --------------  -----  
     0   CPI for All Urban Consumers: All Items Less Food and Energy  128 non-null    float64
     1   U.S. National Home Price Index                               127 non-null    float64
     2   Industrial Production: Total Index                           128 non-null    float64
     3   All Employees, Total Nonfarm                                 128 non-null    int64  
     4   Personal Saving Rate                                         128 non-null    float64
    dtypes: float64(4), int64(1)
    memory usage: 6.0 KB
    


```python
data.describe()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>CPI for All Urban Consumers: All Items Less Food and Energy</th>
      <th>U.S. National Home Price Index</th>
      <th>Industrial Production: Total Index</th>
      <th>All Employees, Total Nonfarm</th>
      <th>Personal Saving Rate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>128.000000</td>
      <td>127.000000</td>
      <td>128.000000</td>
      <td>128.00000</td>
      <td>128.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>268.120922</td>
      <td>226.171685</td>
      <td>100.864814</td>
      <td>147563.40625</td>
      <td>6.878125</td>
    </tr>
    <tr>
      <th>std</th>
      <td>24.737659</td>
      <td>52.474030</td>
      <td>2.963890</td>
      <td>6075.01364</td>
      <td>4.248667</td>
    </tr>
    <tr>
      <th>min</th>
      <td>235.961000</td>
      <td>161.921000</td>
      <td>84.681200</td>
      <td>130421.00000</td>
      <td>2.000000</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>248.737250</td>
      <td>182.321000</td>
      <td>99.438475</td>
      <td>142889.50000</td>
      <td>5.200000</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>262.107000</td>
      <td>207.533000</td>
      <td>101.737700</td>
      <td>147448.00000</td>
      <td>5.750000</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>285.618500</td>
      <td>279.367000</td>
      <td>102.816325</td>
      <td>151648.00000</td>
      <td>6.825000</td>
    </tr>
    <tr>
      <th>max</th>
      <td>319.768000</td>
      <td>321.556000</td>
      <td>104.103800</td>
      <td>158779.00000</td>
      <td>32.000000</td>
    </tr>
  </tbody>
</table>
</div>



# Line Graph


```python
# Assume `data` is your dataset with a datetime index and the selected variables
plt.figure(figsize=(15, 10))

# Plot each variable
plt.plot(data.index, data['CPI for All Urban Consumers: All Items Less Food and Energy'], label='CPI (Less Food & Energy')
plt.plot(data.index, data['U.S. National Home Price Index'], label='U.S. National Home Price Index')
plt.plot(data.index, data['Industrial Production: Total Index'], label='Industrial Production Index')
plt.plot(data.index, data['Personal Saving Rate'], label='Personal Saving Rate')

# Ensure the x-axis uses years
plt.gca().xaxis.set_major_locator(mdates.YearLocator(1))  # Major ticks every year
plt.gca().xaxis.set_major_formatter(mdates.DateFormatter('%Y'))  # Format as 'YYYY'

# Set x-axis limits to match the full date range of the dataset
plt.xlim(data.index.min(), data.index.max())

# Customize
plt.title('Economic Indicators Over Time')
plt.xlabel('Year')
plt.ylabel('Value')
plt.legend()
plt.grid(True)


# Show plot
plt.show()

```


    
![png](MidtermGraph_files/MidtermGraph_3_0.png)
    


# Line Graph with Highlight


```python
# Ensure index is datetime
data.index = pd.to_datetime(data.index)

# Exclude "All Employees, Total Nonfarm"
df_filtered = data.drop(columns=["All Employees, Total Nonfarm"])

# Smoothing: Calculate rolling mean to smooth out short-term fluctuations
# df_smoothed = df_filtered.rolling(window=12).mean()  # 12-month (1-year) rolling average

# Create a figure and axis objects
fig, ax = plt.subplots(figsize=(20, 15))

# Color palette and line styles
colors = ['b', 'g', 'r', 'c']
styles = ['-', '--', '-.', '-.']

# Plot each variable with rolling mean and individual styling
for i, col in enumerate(df_filtered.columns):
    ax.plot(df_filtered.index, df_filtered[col], label=col, color=colors[i % len(colors)], linestyle=styles[i % len(styles)])

# Set major ticks every 10 years
ax.xaxis.set_major_locator(mdates.YearLocator(1))
ax.xaxis.set_major_formatter(mdates.DateFormatter('%Y'))

# Set limits and labels
ax.set_xlim(df_filtered.index.min(), df_filtered.index.max())
ax.set_title('Economic Indicators Over Time', fontsize=20)
ax.set_xlabel('Year', fontsize=16)
ax.set_ylabel('Value (Smoothed)', fontsize=16)

# Highlight specific events (e.g., COVID-19)
ax.axvspan(pd.Timestamp('2019-12-01'), pd.Timestamp('2021-06-01'), color='grey', alpha=0.8, label='COVID-19')

# Customize grid and legend
ax.grid(True)
ax.legend(title="Indicators", fontsize=10, loc='upper left')

# Automatically rotate the x-axis labels
fig.autofmt_xdate()

# Save and Show plot
plt.savefig('Economic_indicators.png')  # Adjust dpi and bbox_inches as needed
plt.show()

```


    
![png](MidtermGraph_files/MidtermGraph_5_0.png)
    

