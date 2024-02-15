import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

O = "#fe7611"
G = "#19c513"
B = "#1dadff"
P = "#fb3efd"
g = "#cdcd"

double = pd.read_csv("2 life/lifef.csv")
triple = pd.read_csv("3 life/lifef.csv")

intensities = double["Intensities"]

I1_2 = double["Int-1"]
I2_2 = double["Int-2"]

I1_3 = triple["Int-1"]
I2_3 = triple["Int-2"]
I3_3 = triple["Int-3"]

x = np.arange(len(intensities))
width = 0.3

plt.bar(np.NaN, np.NaN, color='none', label='2 lifetimes:')
plt.bar(x, double["Int-1"], width, label="tau 1")
plt.bar(x, double["Int-2"], width, label="tau 2", bottom=double["Int-1"])
plt.bar(np.NaN, np.NaN, color='none', label=' ')
plt.errorbar(x-0.2, double["Int-1"], double["Std Int-1"], linestyle="none", marker="s", capsize=2, fillstyle="none")
plt.errorbar(x-0.2, double["Int-1"]+double["Int-2"], double["Std Int-2"], linestyle="none", marker="s", capsize=2, fillstyle="none")

plt.bar(np.NaN, np.NaN, color='none', label='3 lifetimes:')
plt.bar(x+width, triple["Int-1"], width, label="tau 1")
plt.bar(x+width, triple["Int-2"], width, label="tau 2", bottom=triple["Int-1"])
plt.bar(x+width, triple["Int-3"], width, label="tau 3", bottom=triple["Int-1"]+triple["Int-2"])
plt.errorbar(x+width+0.2, triple["Int-1"], triple["Std Int-1"], linestyle="none", marker="s", capsize=2, fillstyle="none")
plt.errorbar(x+width+0.2, triple["Int-1"]+ triple["Int-2"], triple["Std Int-2"], linestyle="none", marker="s", capsize=2, fillstyle="none")
plt.errorbar(x+width+0.2, triple["Int-1"]+ triple["Int-2"]+ triple["Int-3"], triple["Std Int-3"], linestyle="none", marker="s", capsize=2, fillstyle="none")

plt.xticks(x+0.15, intensities)


plt.legend(ncol=2, markerfirst=False, loc="lower right")

#plt.show()
plt.savefig("intensities.png")