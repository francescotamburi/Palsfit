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

plt.legend(title="$I_1$-$I_2$ [\\%]",loc=1)
plt.savefig("plotfin/t1.png", bbox_inches="tight")
plt.clf()


#Tau 2
plt.xlabel("$\\tau_2$ (sim) [ps]")
plt.ylabel("$\\tau_2$ (sim) - $\\tau_2$ (fit) [ps]")

plt.axhline(y = 0, color = g, linestyle = 'dashed')

plt.errorbar(tau_2080["Sim Life-2"]-offset, tau_2080["Life-2"]*1000-tau_2080["Sim Life-2"], yerr=tau_2080["Std Life-2"]*1000, linestyle="none", label="20-80", marker = "o", color=B, capsize=5)
plt.errorbar(tau_5050["Sim Life-2"], tau_5050["Life-2"]*1000-tau_5050["Sim Life-2"], yerr=tau_5050["Std Life-2"]*1000, linestyle="none", label="50-50", marker = "s", color=R, capsize=5)
plt.errorbar(tau_8020["Sim Life-2"]+offset, tau_8020["Life-2"]*1000-tau_8020["Sim Life-2"], yerr=tau_8020["Std Life-2"]*1000, linestyle="none", label="80-20", marker = "d", color=G, capsize=5)

plt.legend(title="$I_1$-$I_2$ [\\%]",loc=1)
plt.savefig("plotfin/t2.png", bbox_inches="tight")
plt.clf()


#5050
plt.ylim(0,100)

plt.xlabel("$\\tau_2$ (sim) [ps]")
plt.ylabel("Intensity (fit) [\\%]")

plt.axhline(y = 50, color = g, linestyle = 'dashed')

plt.errorbar(tau_5050["Sim Life-2"], tau_5050["Int-1"], yerr=tau_5050["Std Int-1"], linestyle="none", marker="s", color=P, capsize=5, label="$I_1$")
plt.errorbar(tau_5050["Sim Life-2"], tau_5050["Int-2"], yerr=tau_5050["Std Int-2"], linestyle="none", marker="d", color=O, capsize=5, label="$I_2$")

plt.legend(loc=1)
plt.savefig("plotfin/5050.png", bbox_inches="tight")
plt.clf()


#2080
plt.ylim(0,100)

plt.xlabel("$\\tau_2$ (sim) [ps]")
plt.ylabel("Intensity (fit) [\\%]")

plt.axhline(y = 80, color = g, linestyle = 'dashed')
plt.axhline(y = 20, color = g, linestyle = 'dashed')

plt.errorbar(tau_2080["Sim Life-2"], tau_2080["Int-1"], yerr=tau_2080["Std Int-1"], linestyle="none", marker="s", color=P, capsize=5, label="$I_1$")
plt.errorbar(tau_2080["Sim Life-2"], tau_2080["Int-2"], yerr=tau_2080["Std Int-2"], linestyle="none", marker="d", color=O, capsize=5, label="$I_2$")

plt.legend(loc=5)
plt.savefig("plotfin/2080.png", bbox_inches="tight")
plt.clf()


#8020
plt.ylim(0,100)

plt.xlabel("$\\tau_2$ (sim) [ps]")
plt.ylabel("Intensity (fit) [\\%]")

plt.axhline(y = 80, color = g, linestyle = 'dashed')
plt.axhline(y = 20, color = g, linestyle = 'dashed')

plt.errorbar(tau_8020["Sim Life-2"], tau_8020["Int-1"], yerr=tau_8020["Std Int-1"], linestyle="none", marker="s", color=P, capsize=5, label="$I_1$")
plt.errorbar(tau_8020["Sim Life-2"], tau_8020["Int-2"], yerr=tau_8020["Std Int-2"], linestyle="none", marker="d", color=O, capsize=5, label="$I_2$")

plt.legend(loc=5)
plt.savefig("plotfin/8020.png", bbox_inches="tight")
plt.clf()