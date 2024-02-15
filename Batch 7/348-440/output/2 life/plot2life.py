import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

O = "#fe7611"
G = "#19c513"
B = "#1dadff"
P = "#fb3efd"
g = "#cdcd"

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

weighted_avg = []

for i in rel_int:
	weighted_avg.append((i[0] * tau_1 + i[1] * tau_2)/100)

df = pd.read_csv("lifef.csv")

fig, (ax1,ax2)  = plt.subplots(2,1, sharex=True, height_ratios=[1,2])
fig.subplots_adjust(hspace=0.1) #adjust space between axes

ax2.errorbar(df["Intensities"], weighted_avg, yerr=0, linestyle="none", marker = ".", color=g, capsize=10, fmt="none")
ax2.errorbar(df["Intensities"], df["Life-1"]*1000, yerr=df["Std Life-1"]*1000, linestyle="none" , marker = "d", color=O, capsize=5)
ax1.errorbar(df["Intensities"], df["Life-2"]*1000, yerr=df["Std Life-2"]*1000, linestyle="none" , marker = "s", color=G, capsize=5)

ax2.set_ylim( 320,  500)
ax1.set_ylim(1000, 2700)

ax2.axhline(y = 348,  color = g, linestyle = 'dashed')
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

plt.savefig("lifetimes.png")