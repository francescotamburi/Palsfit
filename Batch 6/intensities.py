import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

O = "#fe7611"
G = "#19c513"
B = "#1dadff"
P = "#fb3efd"
g = "#cdcd"

double = pd.read_csv("2-life/life2f.csv")
triple = pd.read_csv("3-life/life3f.csv")

plt.bar(double["Intensities"], double["Int-1"], label="tau 1")
plt.bar(double["Intensities"], double["Int-2"], label="tau 2", bottom=double["Int-1"])

plt.legend()
plt.savefig("2_lifetimes")
plt.clf()

plt.bar(triple["Intensities"], triple["Int-1"], label="tau 1")
plt.bar(triple["Intensities"], triple["Int-2"], label="tau 2", bottom=triple["Int-1"])
plt.bar(triple["Intensities"], triple["Int-3"], label="tau 3", bottom=triple["Int-1"]+triple["Int-2"])

plt.legend()
plt.savefig("3_lifetimes")
plt.clf()