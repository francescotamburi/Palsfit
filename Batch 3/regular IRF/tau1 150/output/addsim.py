import pandas as pd

csv_filename = input("Input csv file name: ")
df = pd.read_csv(csv_filename)

specfiles = df["Spectrum file"]
df = df.drop(columns=["Unnamed: 28", "Spectrum file"])

tau1 = [150]*len(specfiles)
tau2 = []
int1 = []
int2 = []

for i in specfiles:
	f = i.split("_")
	tau2.append(int(f[0]))
	int1.append(int(f[1]))
	int2.append(int(f[1].split(".")[0]))

data = {
	"Sim Life-1": tau1,
	"Sim Int-1": int1,
	"Sim Life-2": tau2,
	"Sim Int-2": int2
	}

left = pd.DataFrame(data)

df = pd.concat([left,df], axis=1)

df.insert(4,"TauRatio",df["Sim Life-2"]/df["Sim Life-1"])

df.to_csv(csv_filename, index = False)