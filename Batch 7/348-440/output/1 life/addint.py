import pandas as pd

csv_filename = input("Input csv file name: ")
df = pd.read_csv(csv_filename+".csv")

#df = df.drop(columns=["Unnamed: 22", "Spectrum fil"])

intensities = ["20-80","50-50","80-20","90-10","99.5-1.5"]


data = {
	"Intensities": intensities,
	}

left = pd.DataFrame(data)

df = pd.concat([left,df], axis=1)

df.to_csv(csv_filename+"f.csv", index = False)