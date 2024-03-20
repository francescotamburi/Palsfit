import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

O = "#fe7611"
G = "#19c513"
B = "#1dadff"
P = "#fb3efd"

plt.rcParams['text.usetex'] = True
plt.rcParams['font.size'] = 12

width = 3

data = {}

for counts in ["regular","3x count","3x count + background"]:
	#print(irf)
	
	if counts == "regular":
		csv_filename = "../../Batch 3/single Gaussian IRF/gauss210/150/output/af.csv"
	elif counts == "3x count":
		csv_filename = "../BG 8.5k/output/af.csv"
	elif counts == "3x count + background":
		csv_filename = "../BG 3x/output/af.csv"
	
	df = pd.read_csv(csv_filename)
	
	tau_2080 = df[df["Sim Int-1"]==20]
	tau_5050 = df[df["Sim Int-1"]==50]
	tau_8020 = df[df["Sim Int-1"]==80]

	diff_t1_2080 = np.absolute(tau_2080["Life-1"]*1000-tau_2080["Sim Life-1"])
	diff_t1_5050 = np.absolute(tau_5050["Life-1"]*1000-tau_5050["Sim Life-1"])
	diff_t1_8020 = np.absolute(tau_8020["Life-1"]*1000-tau_8020["Sim Life-1"])
	
	err_t1_2080 = tau_2080["Std Life-1"]*1000
	err_t1_5050 = tau_5050["Std Life-1"]*1000
	err_t1_8020 = tau_8020["Std Life-1"]*1000
	
	diff_t2_2080 = np.absolute(tau_2080["Life-2"]*1000-tau_2080["Sim Life-2"])
	diff_t2_5050 = np.absolute(tau_5050["Life-2"]*1000-tau_5050["Sim Life-2"])
	diff_t2_8020 = np.absolute(tau_8020["Life-2"]*1000-tau_8020["Sim Life-2"])
	
	err_t2_2080 = tau_2080["Std Life-2"]*1000
	err_t2_5050 = tau_5050["Std Life-2"]*1000
	err_t2_8020 = tau_8020["Std Life-2"]*1000
	
	diff_i1_2080 = np.absolute(tau_2080["Int-1"]-tau_2080["Sim Int-1"])
	diff_i2_2080 = np.absolute(tau_2080["Int-2"]-tau_2080["Sim Int-2"])
	
	err_i1_2080 = tau_2080["Std Int-1"]
	err_i2_2080 = tau_2080["Std Int-2"]
	
	diff_i1_5050 = np.absolute(tau_5050["Int-1"]-tau_5050["Sim Int-1"])
	diff_i2_5050 = np.absolute(tau_5050["Int-2"]-tau_5050["Sim Int-2"])
	
	err_i1_5050 = tau_5050["Std Int-1"]
	err_i2_5050 = tau_5050["Std Int-2"]
	
	diff_i1_8020 = np.absolute(tau_8020["Int-1"]-tau_8020["Sim Int-1"])
	diff_i2_8020 = np.absolute(tau_8020["Int-2"]-tau_8020["Sim Int-2"])
	
	err_i1_8020 = tau_8020["Std Int-1"]
	err_i2_8020 = tau_8020["Std Int-2"]
	
	data[counts] = {
			"t1-diff": {
				"2080": diff_t1_2080, 
				"5050": diff_t1_5050, 
				"8020": diff_t1_8020
			},
			"t1-err": {
				"2080": err_t1_2080, 
				"5050": err_t1_5050, 
				"8020": err_t1_8020
			},
			"t2-diff": {
				"2080": diff_t2_2080, 
				"5050": diff_t2_5050, 
				"8020": diff_t2_8020
			},
			"t2-err": {
				"2080": err_t2_2080, 
				"5050": err_t2_5050, 
				"8020": err_t2_8020
			},
			"2080-diff": {
				"i1": diff_i1_2080, 
				"i2": diff_i2_2080
			},
			"2080-err": {
				"i1": err_i1_2080, 
				"i2": err_i2_2080
			},
			"5050-diff": {
				"i1": diff_i1_5050, 
				"i2": diff_i2_5050
			},
			"5050-err": {
				"i1": err_i1_5050, 
				"i2": err_i2_5050
			},
			"8020-diff": {
				"i1": diff_i1_8020, 
				"i2": diff_i2_8020
			},
			"8020-err": {
				"i1": err_i1_8020, 
				"i2": err_i2_8020
			},
		}

"""

diff_t2_2080 = -np.absolute(tau_2080["Life-2"]*1000-tau_2080["Sim Life-2"])
diff_t2_5050 = -np.absolute(tau_5050["Life-2"]*1000-tau_5050["Sim Life-2"])
diff_t2_8020 = -np.absolute(tau_8020["Life-2"]*1000-tau_8020["Sim Life-2"])

diff_i1_2080 = np.absolute(tau_2080["Int-1"]-tau_2080["Sim Int-2"])
diff_i1_5050 = np.absolute(tau_5050["Int-1"]-tau_5050["Sim Int-2"])
diff_i1_8020 = np.absolute(tau_8020["Int-1"]-tau_8020["Sim Int-2"])

diff_i2_2080 = -np.absolute(tau_2080["Int-2"]-tau_2080["Sim Int-2"])
diff_i2_5050 = -np.absolute(tau_5050["Int-2"]-tau_5050["Sim Int-2"])
diff_i2_8020 = -np.absolute(tau_8020["Int-2"]-tau_8020["Sim Int-2"])
"""

x = tau_2080["Sim Life-2"]

plots = [
	("t2-diff", "5050"),
	("t2-diff", "8020")
	]

for dataset in plots:
	plt.plot(x, data["regular"][dataset[0]][dataset[1]], color=O, label="regular", marker="s", linestyle="dotted")
	plt.plot(x, data["3x count"][dataset[0]][dataset[1]], color=G, label="3x count", marker="d", linestyle="dotted")
	plt.plot(x, data["3x count + background"][dataset[0]][dataset[1]], color=P, label="3x count + background", marker="8", linestyle="dotted")
	
	plt.xlabel(r"$\tau_2$ [ps]")
	plt.ylabel(r"$\tau_2$ deviation [ps]")

	plt.xticks(x,x)
	plt.legend()
	plt.savefig(dataset[0]+" "+dataset[1]+".png", bbox_inches="tight")
	plt.clf()

"""

plt.plot(x, diff_t2_2080, color=B, label="20-80", marker="o", linestyle="dotted")
plt.plot(x, diff_t2_5050, color=R, label="50-50", marker="s", linestyle="dotted")
plt.plot(x, diff_t2_8020, color=G, label="80-20", marker="d", linestyle="dotted")

"""