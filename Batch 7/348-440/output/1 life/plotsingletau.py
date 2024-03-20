import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

O = "#fe7611"
G = "#19c513"
B = "#1dadff"
P = "#fb3efd"
g = "#cdcd"

plt.rcParams['text.usetex'] = True
plt.rcParams['font.size'] = 12

true_int = [
	(19.97  ,  79.88),
	(49.925 , 49.925),
	(79.88  ,  19.97),
	(89.865 ,  9.985), 
	(99.3508, 0.4992),
	]

rel_int = [
	(20  , 80 ),
	(50  , 50 ),
	(80  , 20 ),
	(90  , 10 ), 
	(99.5, 0.5),
	]

tau_1 = 348
tau_2 = 440
	
plt.axhline(y = tau_1, color = g, linestyle = 'dashed')
plt.axhline(y = tau_2, color = g, linestyle = 'dashed')

plt.xlabel("Intensities (%)")
plt.ylabel("Lifetime (ps)")

csv_filename = "lifef.csv"
df = pd.read_csv(csv_filename)

#print(df.keys())

plt.errorbar(df["Intensities"], df["Life-1"]*1000, yerr=df["Std Life-1"]*1000, linestyle="none", marker = "o", color=B, capsize=5)

weighted_avg = []

for i in rel_int:
	weighted_avg.append((i[0] * tau_1 + i[1] * tau_2)/100)

plt.errorbar(df["Intensities"], weighted_avg, yerr=0, linestyle="none", marker = ".", color=g, capsize=10, fmt="none")

plt.xlabel(r"Relative intensities [\%]")
plt.ylabel("Lifetime [ps]")

plt.savefig("lifetimes.png", bbox_inches="tight")