import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import numpy as np

O = "#fe7611"
G = "#19c513"
B = "#1dadff"
P = "#fb3efd"
g = "#cdcd"

df = pd.read_csv("af.csv")

fig, (ax1,ax2) = plt.subplots(1,2)

ax1.set_ylabel('%')
ax1.errorbar(df["Intensities"], df["Int-1"], yerr=df["Std Int-1"], linestyle="dashed", marker = "d", color=G, capsize=5)
ax1.errorbar(df["Intensities"], df["Int-2"], yerr=df["Std Int-2"], linestyle="dashed", marker = "s", color=B, capsize=5)
ax1.yaxis.set_major_locator(ticker.MultipleLocator(10))
ax1.yaxis.set_minor_locator(ticker.MultipleLocator(5)) 
ax1.set_ylim(0,100)
ax1.grid(which="both")

#ax2 = ax1.twinx()  # instantiate a second axes that shares the same x-axis

ax2.set_ylabel('%', color=O)
ax2.errorbar(df["Intensities"], df["Int-3"], yerr=df["Std Int-3"], linestyle="dotted", marker = "o", color=O, capsize=5)
ax2.tick_params(axis='y', labelcolor=O)
ax2.set_ylim(0,0.3)

fig.tight_layout()  # otherwise the right y-label is slightly clipped
plt.show()