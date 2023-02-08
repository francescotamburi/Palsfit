import pandas as pd
import glob

#joins regular csv files with no naming

csv_filename = input("Name output csv file: ")

files = glob.glob("*.csv")

df_list = [pd.read_csv(x) for x in files]
df = pd.concat(df_list)

df.to_csv(csv_filename+".csv", index = False)