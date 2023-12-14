import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

R = "#e41a1c"
B = "#377eb8"
G = "#4daf4a"
P = "#984ea3"
O = "#ff7f00"
g = "#cdcd"

offset = 1

csv_filename = "af.csv"

df = pd.read_csv(csv_filename)

tau_2080 = df[df["Sim Int-1"]==20]
tau_5050 = df[df["Sim Int-1"]==50]
tau_8020 = df[df["Sim Int-1"]==80]

#Tau1
plt.xlabel("Simulated Tau 2 (ps)")
plt.ylabel("Tau 1 (ps)")

plt.axhline(y = 150, color = g, linestyle = 'dashed')

plt.errorbar(tau_2080["Sim Life-2"]-offset, tau_2080["Life-1"]*1000, yerr=tau_2080["Std Life-1"]*1000, linestyle="none", label="20-80", marker = "o", color=B, capsize=5)
plt.errorbar(tau_5050["Sim Life-2"], tau_5050["Life-1"]*1000, yerr=tau_5050["Std Life-1"]*1000, linestyle="none", label="50-50", marker = "s", color=R, capsize=5)
plt.errorbar(tau_8020["Sim Life-2"]+offset, tau_8020["Life-1"]*1000, yerr=tau_8020["Std Life-1"]*1000, linestyle="none", label="80-20", marker = "d", color=G, capsize=5)

#plt.xlim(185,235)
plt.savefig("t1r.png")
plt.clf()


#Tau 2
plt.xlabel("Simulated Tau 2 (ps)")
plt.ylabel("PALSFIT Output - Simulated Tau 2 (ps)")

plt.axhline(y = 0, color = g, linestyle = 'dashed')

plt.errorbar(tau_2080["Sim Life-2"]-offset, tau_2080["Life-2"]*1000-tau_2080["Sim Life-2"], yerr=tau_2080["Std Life-2"]*1000, linestyle="none", label="20-80", marker = "o", color=B, capsize=5)
plt.errorbar(tau_5050["Sim Life-2"], tau_5050["Life-2"]*1000-tau_5050["Sim Life-2"], yerr=tau_5050["Std Life-2"]*1000, linestyle="none", label="50-50", marker = "s", color=R, capsize=5)
plt.errorbar(tau_8020["Sim Life-2"]+offset, tau_8020["Life-2"]*1000-tau_8020["Sim Life-2"], yerr=tau_8020["Std Life-2"]*1000, linestyle="none", label="80-20", marker = "d", color=G, capsize=5)

#plt.xlim(185,235)
plt.legend()
plt.savefig("t2r.png")
plt.clf()

#5050
plt.ylim(0,100)

plt.xlabel("Simulated Tau 2 (ps)")
plt.ylabel("Intensity (%)")

plt.axhline(y = 50, color = g, linestyle = 'dashed')

plt.errorbar(tau_5050["Sim Life-2"], tau_5050["Int-1"], yerr=tau_5050["Std Int-1"], linestyle="none", label="Tau 1", marker="s", color=P, capsize=5)
plt.errorbar(tau_5050["Sim Life-2"], tau_5050["Int-2"], yerr=tau_5050["Std Int-2"], linestyle="none", label="Tau 2", marker="s", color=O, capsize=5)

#plt.xlim(185,235)
plt.legend()
plt.savefig("5050r.png")
plt.clf()


#2080
plt.ylim(0,100)

plt.xlabel("Simulated Tau 2 (ps)")
plt.ylabel("Intensity (%)")

plt.axhline(y = 80, color = g, linestyle = 'dashed')
plt.axhline(y = 20, color = g, linestyle = 'dashed')

plt.errorbar(tau_2080["Sim Life-2"], tau_2080["Int-1"], yerr=tau_2080["Std Int-1"], linestyle="none", label="Tau 1", marker="o", color=P, capsize=5)
plt.errorbar(tau_2080["Sim Life-2"], tau_2080["Int-2"], yerr=tau_2080["Std Int-2"], linestyle="none", label="Tau 2", marker="o", color=O, capsize=5)

#plt.xlim(185,235)
plt.legend()
plt.savefig("2080r.png")
plt.clf()


#8020
plt.ylim(0,100)

plt.xlabel("Simulated Tau 2 (ps)")
plt.ylabel("Intensity (%)")

plt.axhline(y = 80, color = g, linestyle = 'dashed')
plt.axhline(y = 20, color = g, linestyle = 'dashed')

plt.errorbar(tau_8020["Sim Life-2"], tau_8020["Int-1"], yerr=tau_8020["Std Int-1"], linestyle="none", label="Tau 1", marker="d", color=P, capsize=5)
plt.errorbar(tau_8020["Sim Life-2"], tau_8020["Int-2"], yerr=tau_8020["Std Int-2"], linestyle="none", label="Tau 2", marker="d", color=O, capsize=5)

#plt.xlim(185,235)
plt.legend()
plt.savefig("8020r.png")
plt.clf()