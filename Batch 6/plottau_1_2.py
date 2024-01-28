import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

O = "#fe7611"
G = "#19c513"
B = "#1dadff"
P = "#fb3efd"
g = "#cdcd"

width = 3

single = pd.read_csv("1-life/life1f.csv")
double = pd.read_csv("2-life/life2f.csv")
triple = pd.read_csv("3-life/life3f.csv")

plt.errorbar(single["Intensities"], single["Life-1"]*1000, yerr=single["Std Life-1"]*1000, linestyle="dotted" , marker = "o", label="1 lifetime" , color=O, capsize=5)
plt.errorbar(double["Intensities"], double["Life-1"]*1000, yerr=double["Std Life-1"]*1000, linestyle="dotted" , marker = "d", label="2 lifetimes", color=G, capsize=5)
plt.errorbar(double["Intensities"], double["Life-2"]*1000, yerr=double["Std Life-2"]*1000, linestyle="dashed" , marker = "d", color=G, capsize=5)
plt.errorbar(triple["Intensities"], triple["Life-1"]*1000, yerr=triple["Std Life-1"]*1000, linestyle="dotted" , marker = "s", label="3 lifetimes", color=B, capsize=5)
plt.errorbar(triple["Intensities"], triple["Life-2"]*1000, yerr=triple["Std Life-2"]*1000, linestyle="dashed" , marker = "s", color=B, capsize=5)
plt.errorbar(triple["Intensities"], triple["Life-3"]*1000, yerr=triple["Std Life-3"]*1000, linestyle="dashdot", marker = "s", color=B, capsize=5)

plt.axhline(y = 370,  color = g, linestyle = 'dashed')
plt.axhline(y = 440,  color = g, linestyle = 'dashed')
plt.axhline(y = 2600, color = g, linestyle = 'dashed')

plt.xlabel("Intensities (%)")
plt.ylabel("Lifetime (ps)")

"""
plt.ylim(320,500)
plt.legend()
plt.savefig("t1t2")

plt.ylim(1000,3000)
plt.legend()
plt.savefig("t3")"""

plt.legend()
plt.show()