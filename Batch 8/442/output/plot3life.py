import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

O = "#fe7611"
G = "#19c513"
B = "#1dadff"
P = "#fb3efd"
g  = "#cdcd"
dg = "#aaaa"

plt.rcParams['text.usetex'] = True
plt.rcParams['font.size'] = 12

df = pd.read_csv("af.csv")

fig, (ax1,ax2)  = plt.subplots(2,1, sharex=True, height_ratios=[1,2])
fig.subplots_adjust(hspace=0.1) #adjust space between axes

df = df[::-1]

real_int=[5.42,10.28,22.26,58.88,74.12,85.14,91.97]

ax2.errorbar(real_int, df["Life-1"]*1000, yerr=df["Std Life-1"]*1000, linestyle="dashed" , marker = "d", color=O, capsize=5, label="$\\tau_1$")
ax2.errorbar(real_int, df["Life-2"]*1000, yerr=df["Std Life-2"]*1000, linestyle="dashed" , marker = "s", color=G, capsize=5, label="$\\tau_2$")
ax2.errorbar(real_int, df["Life-3"]*1000, yerr=df["Std Life-3"]*1000, linestyle="dashdot", marker = ".", color=P, capsize=5, label="$\\tau_3$")
ax1.errorbar(real_int, df["Life-3"]*1000, yerr=df["Std Life-3"]*1000, linestyle="dashdot", marker = ".", color=P, capsize=5)
ax1.errorbar(real_int, df["Life-2"]*1000, yerr=df["Std Life-2"]*1000, linestyle="dashed" , marker = "s", color=G, capsize=5)
ax2.legend()

ax2.set_ylim( 50,  550)
ax1.set_ylim(1600, 2200)

ax2.errorbar(real_int, [66.9,111.7,186.9,291.6,313.5,325.7,332.2], yerr=0, linestyle="none", marker = ".", color=dg, capsize=15, fmt="none")

ax2.axhline(y = 442,  color = g, linestyle = 'dashed')
ax1.axhline(y = 2000, color = g, linestyle = 'dashed')

ax1.spines["bottom"].set_visible(False)
ax2.spines["top"].set_visible(False)
ax1.xaxis.tick_top()
ax1.tick_params(labeltop=False)  # don't put tick labels at the top
ax2.xaxis.tick_bottom()
ax2.set_xticks(real_int,df["Sim-Int-1"])
ax2.set_ylabel("Lifetime [ps]")
ax2.set_xlabel("$I_1$ [\\%]")

d = .5  # proportion of vertical to horizontal extent of the slanted line
kwargs = dict(marker=[(-1, -d), (1, d)], markersize=12,
              linestyle="none", color='k', mec='k', mew=1, clip_on=False)
ax1.plot([0, 1], [0, 0], transform=ax1.transAxes, **kwargs)
ax2.plot([0, 1], [1, 1], transform=ax2.transAxes, **kwargs)

plt.savefig("lifetimes.png", bbox_inches="tight")
plt.clf()

for x,i in zip(df["Sim-Int-1"],real_int):
	plt.errorbar(x, i, yerr=0, linestyle="none", marker = ".", color=dg, capsize=10, fmt="none")
	plt.errorbar(x, 100-i-0.15, yerr=0, linestyle="none", marker = ".", color=dg, capsize=10, fmt="none")
	
plt.axhline(color="black",linewidth="0.1")

plt.errorbar(df["Sim-Int-1"], df["Int-1"], yerr=df["Std Int-1"], linestyle="none" , marker = "d", color=O, capsize=5, label="$I_1$")
plt.errorbar(df["Sim-Int-1"], df["Int-2"], yerr=df["Std Int-2"], linestyle="none" , marker = "s", color=G, capsize=5, label="$I_2$")
plt.legend()

plt.xlabel("$I_1$-$I_2$ [\\%]")
plt.ylabel("Intensity [\\%]")

plt.savefig("intensities.png", bbox_inches="tight")