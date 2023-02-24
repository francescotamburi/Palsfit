import pandas as pd
import glob

#(should probably separate out renaming columns and joining)

csv_filename = input("Name output csv file: ")

files = glob.glob("*.csv")

df_list = [pd.read_csv(x, sep=";") for x in files]
#df_list = [pd.read_csv(x) for x in files]        for joining already reformatted files
df = pd.concat(df_list)

df = df.rename(columns=lambda x: x.strip())
df = df.drop(columns=["Dataset", "ID", "Sigma-1", "Sigma-2", "Std dev  .2", "Std dev  .5"])

cols = {
	"Std dev":     "Std Chi-sqr/x",
	"Lifet-1":     "Life-1",
	"Std dev  .1": "Std Life-1",
	"Itens-1":     "Int-1",
	"Std dev  .3": "Std Int-1",
	"Lifet-2":     "Life-2",
	"Std dev  .4": "Std Life-2",
	"Itens-2":     "Int-2",
	"Std dev  .6": "Std Int-2",
	"Std dev  .7": "Std LT_mean",
	"Std dev  .8": "Std Bkg",
	"Std dev  .9": "Std T0",
	}	
	
df = df.rename(columns=cols)

df.to_csv(csv_filename+".csv", index = False)