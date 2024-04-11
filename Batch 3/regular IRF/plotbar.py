import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

O = "#fe7611"
G = "#19c513"
B = "#1dadff"
P = "#fb3efd"

width = 3

data = {}

for irf in [150,180,220]:
	#print(irf)
	
	if irf == 180:
		csv_filename = "../../Batch 1+2/Batch1+2/output/af.csv"
	else:
		csv_filename = "tau1 "+str(irf)+"/output/af.csv"
	
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
	#print(diff_i1_5050)
	diff_i2_5050 = np.absolute(tau_5050["Int-2"]-tau_5050["Sim Int-2"])
	
	err_i1_5050 = tau_5050["Std Int-1"]
	err_i2_5050 = tau_5050["Std Int-2"]
	
	diff_i1_8020 = np.absolute(tau_8020["Int-1"]-tau_8020["Sim Int-1"])
	#print(diff_i1_8020)
	diff_i2_8020 = np.absolute(tau_8020["Int-2"]-tau_8020["Sim Int-2"])
	
	err_i1_8020 = tau_8020["Std Int-1"]
	err_i2_8020 = tau_8020["Std Int-2"]
	
	data[str(irf)] = {
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
	("t1-diff", "2080"),
	("t1-diff", "5050"),
	("t1-diff", "8020"),
	
	("t1-err",  "2080"),
	("t1-err",  "5050"),
	("t1-err",  "8020"),
	
	("t2-diff", "2080"),
	("t2-diff", "5050"),
	("t2-diff", "8020"),
	
	("t2-err",  "2080"),
	("t2-err",  "5050"),
	("t2-err",  "8020"),
	
	("2080-diff",  "i1"),
	("2080-diff",  "i2"),
	
	("2080-err",   "i1"),
	("2080-err",   "i2"),
	
	("5050-diff",  "i1"),
	("5050-diff",  "i2"),
	
	("5050-err",   "i1"),
	("5050-err",   "i2"),
	
	("8020-diff",  "i1"),
	("8020-diff",  "i2"),
	
	("8020-err",   "i1"),
	("8020-err",   "i2"),
	]

for dataset in plots:
	plt.plot(x, data["150"][dataset[0]][dataset[1]], color=G, label="150ps", marker="s", linestyle="dotted")
	plt.plot(x, data["180"][dataset[0]][dataset[1]], color=B, label="180ps", marker="s", linestyle="dotted")
	plt.plot(x, data["220"][dataset[0]][dataset[1]], color=P, label="220ps", marker="s", linestyle="dotted")
	
	plt.xticks(x,x)
	plt.legend()
	plt.savefig(dataset[0]+" "+dataset[1]+".png")
	plt.clf()

"""

plt.plot(x, diff_t2_2080, color=B, label="20-80", marker="o", linestyle="dotted")
plt.plot(x, diff_t2_5050, color=R, label="50-50", marker="s", linestyle="dotted")
plt.plot(x, diff_t2_8020, color=G, label="80-20", marker="d", linestyle="dotted")

"""