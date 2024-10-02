# **Midterm Part 1**

# Load CSV files 



```python
import pandas as pd

df = pd.read_csv('C:/Users/Samuel Zelaya/venv477/Scripts/crops_yield_changes_MIDTERM 1.csv')
df = pd.DataFrame(data)  
print(df)

```

         Year   Crop Scenario  Yield Change (%)
    0   2020s  Wheat     A1FI                 4
    1   2020s   Rice       A2                 2
    2   2020s  Maize       B1                 1
    3   2020s  Wheat       B2                 3
    4   2050s   Rice     A1FI                11
    5   2050s  Maize       A2                10
    6   2050s  Wheat       B1                 4
    7   2050s   Rice       B2                 6
    8   2080s  Maize     A1FI                18
    9   2080s  Wheat       A2                17
    10  2080s   Rice       B1                 8
    11  2080s  Maize       B2                11
    

# Convert 'Yield Change (%)' to numeric



```python

df['Yield Change (%)'] = pd.to_numeric(df['Yield Change (%)'], errors='coerce')

```

# Visualizing data set



```python
import matplotlib.pyplot as plt
import seaborn as sns

# Set the style of the visualization
sns.set(style="whitegrid")

# Create a bar plot
plt.figure(figsize=(12, 6))
bar_plot = sns.barplot(x='Year', y='Yield Change (%)', hue='Crop', data=df, ci=None)

# Adding titles and labels
plt.title('Crop Yield Changes Over Time by Scenario', fontsize=16)
plt.xlabel('Time Period', fontsize=14)
plt.ylabel('Yield Change (%)', fontsize=14)
plt.legend(title='Crops', fontsize=12)
plt.xticks(rotation=45) 

# Show the plot
plt.tight_layout()  
plt.show()

```

    C:\Users\Samuel Zelaya\AppData\Local\Temp\ipykernel_17920\1142926820.py:9: FutureWarning: 
    
    The `ci` parameter is deprecated. Use `errorbar=None` for the same effect.
    
    


    
![png](midterm%201._Zelaya_92824%20_files/midterm%201._Zelaya_92824%20_6_1.png)
    


# **This bar plot provides a visual comparison of crop yield changes influenced by climate change, specifically for essential staple crops such as wheat, rice, and maize. It illustrates how different scenarios and time periods impact agricultural production and compares crop yield changes across different scenarios and time periods.**



# Saving Plot



```python
sns.set(style="whitegrid")

# Create a bar plot
plt.figure(figsize=(12, 6))
bar_plot = sns.barplot(x='Year', y='Yield Change (%)', hue='Crop', data=df, ci=None)

# Adding titles and labels
plt.title('Crop Yield Changes Over Time by Scenario', fontsize=16)
plt.xlabel('Time Period', fontsize=14)
plt.ylabel('Yield Change (%)', fontsize=14)
plt.legend(title='Crops', fontsize=12)
plt.xticks(rotation=45)  

plt.savefig('Crop Yield Changes Over Time by Scenari.png')

plt.close()


```

    C:\Users\Samuel Zelaya\AppData\Local\Temp\ipykernel_17920\2442813782.py:5: FutureWarning: 
    
    The `ci` parameter is deprecated. Use `errorbar=None` for the same effect.
    
    


```python

```
