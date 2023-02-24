import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

csv_filename = "af.csv"

df = pd.read_csv(csv_filename)

plt.title("Tau 1")
plt.xlabel("Tau2/Tau1")
plt.ylabel("Tau 1")

tau_2080 = df[df["Sim Int-1"]==20]
plt.errorbar(tau_2080["TauRatio"], tau_2080["Life-1"], yerr=tau_2080["Std Life-1"], linestyle="none", label="20-80", marker = "o", capsize=5)

tau_5050 = df[df["Sim Int-1"]==50]
plt.errorbar(tau_5050["TauRatio"], tau_5050["Life-1"], yerr=tau_5050["Std Life-1"], linestyle="none", label="50-50", marker = "x", capsize=5)

tau_8020 = df[df["Sim Int-1"]==80]
plt.errorbar(tau_8020["TauRatio"], tau_8020["Life-1"], yerr=tau_8020["Std Life-1"], linestyle="none", label="80-20", marker = "*", capsize=5)

plt.axhline(y = 0.150, color = 'grey', linestyle = 'dashed')
plt.legend()
#plt.show()

plt.savefig("tau1.png")
plt.clf()

#produce same for tau2...

plt.title("Tau 2 deviation")
plt.xlabel("Tau2/Tau1")
plt.ylabel("Tau 2 - Simulated Tau 2")

plt.errorbar(tau_2080["TauRatio"], np.array(tau_2080["Life-2"]) - np.array(tau_2080["Sim Life-2"])/1000, yerr=tau_2080["Std Life-1"], linestyle="none", label="20-80", marker = "o", capsize=5)
plt.errorbar(tau_5050["TauRatio"], np.array(tau_5050["Life-2"]) - np.array(tau_5050["Sim Life-2"])/1000, yerr=tau_5050["Std Life-1"], linestyle="none", label="50-50", marker = "x", capsize=5)
plt.errorbar(tau_8020["TauRatio"], np.array(tau_8020["Life-2"]) - np.array(tau_8020["Sim Life-2"])/1000, yerr=tau_8020["Std Life-1"], linestyle="none", label="80-20", marker = "*", capsize=5)

plt.axhline(y = 0, color = 'grey', linestyle = 'dashed')
plt.legend()

plt.savefig("tau2.png")
plt.clf()

########
"""
plt.axhline(y = 0.150, color = 'grey', linestyle = 'dashed')
plt.errorbar(tau_2080["TauRatio"], tau_2080["Life-1"], yerr=tau_2080["Std Life-1"], linestyle="none", label="20-80", marker = "o", capsize=5)

plt.savefig("tau1_2080.png")
plt.clf()
"""
#########################

plt.title("Intensity 20-80")
plt.xlabel("Tau2/Tau1")
plt.ylabel("Intensity")

plt.errorbar(tau_2080["TauRatio"], tau_2080["Int-1"], yerr=tau_2080["Std Int-1"], linestyle="none", label="Tau 1",marker = "x", capsize=5)

plt.errorbar(tau_2080["TauRatio"], tau_2080["Int-2"], yerr=tau_2080["Std Int-2"], linestyle="none", marker = "x", label="Tau 2", capsize=5)

plt.axhline(y = 20, color = 'grey', linestyle = 'dashed')
plt.axhline(y = 80, color = 'grey', linestyle = 'dashed')
plt.legend()
#plt.show()

plt.savefig("i2080.png")
plt.clf()

#########################

plt.title("Intensity 80-20")
plt.xlabel("Tau2/Tau1")
plt.ylabel("Intensity")

plt.errorbar(tau_8020["TauRatio"], tau_8020["Int-1"], yerr=tau_8020["Std Int-1"], linestyle="none", label="Tau 1", capsize=5,marker = "x",)

plt.errorbar(tau_8020["TauRatio"], tau_8020["Int-2"], yerr=tau_8020["Std Int-2"], linestyle="none", label="Tau 2", capsize=5,marker = "x",)

plt.axhline(y = 20, color = 'grey', linestyle = 'dashed')
plt.axhline(y = 80, color = 'grey', linestyle = 'dashed')
plt.legend()
#plt.show()

plt.savefig("i5050.png")
plt.clf()

#########################

plt.title("Intensity 50-50")
plt.xlabel("Tau2/Tau1")
plt.ylabel("Intensity")

plt.errorbar(tau_5050["TauRatio"], tau_5050["Int-1"], yerr=tau_5050["Std Int-1"], linestyle="none", label="Tau 1", capsize=5,marker = "x",)

plt.errorbar(tau_5050["TauRatio"], tau_5050["Int-2"], yerr=tau_5050["Std Int-2"], linestyle="none", label="Tau 2", capsize=5,marker = "x",)

plt.axhline(y = 50, color = 'grey', linestyle = 'dashed')
plt.legend()
#plt.show()

plt.savefig("i8020.png")
plt.clf()