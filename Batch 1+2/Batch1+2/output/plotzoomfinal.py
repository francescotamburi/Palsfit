import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

R = "#e41a1c"
B = "#377eb8"
G = "#4daf4a"
P = "#984ea3"
O = "#ff7f00"
g = "#cdcd"

plt.rcParams['text.usetex'] = True
plt.rcParams['font.size'] = 12

offset=1

csv_filename = "af.csv"

df = pd.read_csv(csv_filename)

tau_2080 = df[df["Sim Int-1"]==20]
tau_5050 = df[df["Sim Int-1"]==50]
tau_8020 = df[df["Sim Int-1"]==80]

#Tau1
plt.xlabel("$\\tau_2$ (sim) [ps]")
plt.ylabel("$\\tau_1$ (fit) [ps]")

plt.axhline(y = 180, color = g, linestyle = 'dashed')

plt.errorbar(tau_2080["Sim Life-2"]-offset, tau_2080["Life-1"]*1000, yerr=tau_2080["Std Life-1"]*1000, linestyle="none", label="20-80", marker = "o", color=B, capsize=5)
plt.errorbar(tau_5050["Sim Life-2"], tau_5050["Life-1"]*1000, yerr=tau_5050["Std Life-1"]*1000, linestyle="none", label="50-50", marker = "s", color=R, capsize=5)
plt.errorbar(tau_8020["Sim Life-2"]+offset, tau_8020["Life-1"]*1000, yerr=tau_8020["Std Life-1"]*1000, linestyle="none", label="80-20", marker = "d", color=G, capsize=5)

plt.xticks(tau_2080["Sim Life-2"])
plt.xlim(235,275)
plt.ylim(175,188)
plt.legend(title="$I_1$-$I_2$ [\\%]",loc=4)
plt.savefig("plotfin/t1zoom.png", bbox_inches="tight")
plt.clf()