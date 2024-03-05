import pandas as pd

csv_filename = input("Input csv file name: ")
df = pd.read_csv(csv_filename+".csv")

df = df.drop(columns=["Unnamed: 34", "Spectrum"])

n = 2

intensities = reversed(["80-20","70-30","60-40","50-50","30-70","10-90","5-95"])


data = {
	"Intensities": intensities,
	}

left = pd.DataFrame(data)

df = pd.concat([left,df], axis=1)

df.to_csv(csv_filename+"f.csv", index = False)