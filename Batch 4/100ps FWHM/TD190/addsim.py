import pandas as pd

spec_df = pd.read_csv("output/a.csv")

specfiles = spec_df["Spectr"]
spec_df = spec_df.drop(columns=["Unnamed: 28", "Spectr"])

sim_vals = []

for i in specfiles:
	f = i.split(".")
	f[1] = "out"
	f = ".".join(f)
	out = open(f)
	out = out.readlines()
	lifetimes = out[14].split(":")[1].strip().split()
	intensities = out[15].split(":")[1].strip().split()
	lifetimes = [float(string) for string in lifetimes]
	intensities = [int(float(string)) for string in intensities]
	data = {
		"Sim Life-1": [lifetimes[0]],
		"Sim Int-1": [intensities[0]],
		"Sim Life-2": [lifetimes[1]],
		"Sim Int-2": [intensities[1]]
		}
	data = pd.DataFrame(data)
	sim_vals.append(data)
	
sim_vals = pd.concat(sim_vals)
sim_vals = sim_vals.reset_index(drop=True) #needed to fix InvalidIndexError: Reindexing only valid with uniquely valued Index objects

spec_df = pd.concat([sim_vals,spec_df], axis=1)

spec_df.to_csv("output/af.csv", index = False)