import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

O = "#fe7611"
G = "#19c513"
B = "#1dadff"
P = "#fb3efd"
g = "#cdcd"

plt.axhline(y = 355, color = g, linestyle = 'dashed')
plt.axhline(y = 444, color = g, linestyle = 'dashed')

plt.xlabel("Intensities (%)")
plt.ylabel("Lifetime (ps)")

csv_filename = "lifef.csv"
df = pd.read_csv(csv_filename)

#print(df.keys())

plt.errorbar(df["Intensities"], df["Life-1"]*1000, yerr=df["Std Life-1"]*1000, linestyle="none", marker = "o", color=B, capsize=5)
plt.errorbar(df["Intensities"], df["Life-2"]*1000, yerr=df["Std Life-2"]*1000, linestyle="none", marker = "s", color=G, capsize=5)

plt.show()