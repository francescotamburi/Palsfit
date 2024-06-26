import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

O = "#fe7611"
G = "#19c513"
B = "#1dadff"
P = "#fb3efd"
g = "#cdcd"

single = pd.read_csv("1-life/life1f.csv")
double = pd.read_csv("2-life/life2f.csv")
triple = pd.read_csv("3-life/life3f.csv")

fig, (ax1,ax2)  = plt.subplots(2,1, sharex=True)
fig.subplots_adjust(hspace=0.1) #adjust space between axes

ax2.errorbar(single["Intensities"], single["Life-1"]*1000, yerr=single["Std Life-1"]*1000, linestyle="dotted" , marker = "o", label="1 lifetime" , color=O, capsize=5)
ax2.errorbar(double["Intensities"], double["Life-1"]*1000, yerr=double["Std Life-1"]*1000, linestyle="dotted" , marker = "d", label="2 lifetimes", color=G, capsize=5)
ax1.errorbar(double["Intensities"], double["Life-2"]*1000, yerr=double["Std Life-2"]*1000, linestyle="dashed" , marker = "d", color=G, capsize=5)
ax2.errorbar(triple["Intensities"], triple["Life-1"]*1000, yerr=triple["Std Life-1"]*1000, linestyle="dotted" , marker = "s", label="3 lifetimes", color=B, capsize=5)
ax2.errorbar(triple["Intensities"], triple["Life-2"]*1000, yerr=triple["Std Life-2"]*1000, linestyle="dashed" , marker = "s", color=B, capsize=5)
ax1.errorbar(triple["Intensities"], triple["Life-2"]*1000, yerr=triple["Std Life-2"]*1000, linestyle="dashed" , marker = "s", color=B, capsize=5)
ax1.errorbar(triple["Intensities"], triple["Life-3"]*1000, yerr=triple["Std Life-3"]*1000, linestyle="dashdot", marker = "s", color=B, capsize=5)

ax2.set_ylim( 320,  500)
ax1.set_ylim(1500, 3000)

ax2.axhline(y = 370,  color = g, linestyle = 'dashed')
ax2.axhline(y = 440,  color = g, linestyle = 'dashed')
ax1.axhline(y = 2600, color = g, linestyle = 'dashed')

ax1.spines["bottom"].set_visible(False)
ax2.spines["top"].set_visible(False)
ax1.xaxis.tick_top()
ax1.tick_params(labeltop=False)  # don't put tick labels at the top
ax2.xaxis.tick_bottom()

d = .5  # proportion of vertical to horizontal extent of the slanted line
kwargs = dict(marker=[(-1, -d), (1, d)], markersize=12,
              linestyle="none", color='k', mec='k', mew=1, clip_on=False)
ax1.plot([0, 1], [0, 0], transform=ax1.transAxes, **kwargs)
ax2.plot([0, 1], [1, 1], transform=ax2.transAxes, **kwargs)

plt.show()