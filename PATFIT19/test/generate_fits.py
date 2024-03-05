import wexpect
import pandas as pd
from collections import OrderedDict

def dict_to_csv(dictionary, filename):
	df = pd.DataFrame(dictionary)
	df.to_csv(filename, index=False)

filenames = ["9010","8515","7525","6040","2080","1090","0595"]
#filenames = ["0595","1090"]

csv_rows = OrderedDict({"Intensities": filenames,	
	"Time/ch": [],	
	"Fit min": [],	
	"Fit max": [],	
	"Chi-sqr/x": [],	
	"Std Chi-sqr/x": [],	
	"Life-1": [],	
	"Std Life-1": [],	
	"Int-1": [],	
	"Std Int-1": [],	
	"Life-2": [],	
	"Std Life-2": [],	
	"Int-2": [],	
	"Std Int-2": [],	
	"Life-3": [],	
	"Std Life-3": [],	
	"Int-3": [],	
	"Std Int-3": [],	
	"LT_mean": [],	
	"Std LT_mean": [],
	"Bkg Counts/Ch": [],
	"Bkg Std": [], 
	"Bkg T0": [],		
	"Area(fit)": [],	
	"Area(table)": []})


for file in filenames:
	child = wexpect.spawn("pos19.exe")
	child.expect(" INPUT DATA - TYPE NAME OF CONTROL DATA FILE:")
	child.sendline(file+".pfc")
	child.expect(" RESULTS - TYPE NAME OF OUTPUT FILE:")
	child.sendline("output\\"+file+".out")
	child.expect(" BEGIN POSITRONFIT ANALYSIS")
	child.close()
	
	std = 0
	ix = False

	
	f = open("output/{}.out".format(file))
	for line in f.readlines():
		if line.find("TIME SCALE") != -1:
			csv_rows["Time/ch"].append(line.split(":")[1].strip())
		elif line.find("FIT RANGE") != -1:
			start = "STARTS IN CH"
			ends = "AND ENDS IN CH"
			fit_range = line.split(ends)
			fit_range = [fit_range[0].split(start)[1].strip(), fit_range[1].strip()]
			csv_rows["Fit min"].append(fit_range[0]) 
			csv_rows["Fit max"].append(fit_range[1])
		elif line.find("REDUCED CHI-SQUARE") != -1:
			rchi = line.split("=")
			rchi = rchi[2].split("WITH STD DEVIATION")
			csv_rows["Chi-sqr/x"].append(rchi[0].strip())
			csv_rows["Std Chi-sqr/x"].append(rchi[1].strip())
		elif line.find("LIFE.COMP.   LIFETIMES") != -1:
			lt = line.split(":")[1].split()
			lt = [i.strip() for i in lt]
			csv_rows["Life-1"].append(lt[0])
			csv_rows["Life-2"].append(lt[1])
			csv_rows["Life-3"].append(lt[2])
			ix = True
		elif line.find("INTENSITIES") != -1 and ix:
			i = line.split(":")[1].split()
			i = [x.strip() for x in i]
			csv_rows["Int-1"].append(i[0])
			csv_rows["Int-2"].append(i[1])
			csv_rows["Int-3"].append(i[2])
		elif line.find("MEAN LIFETIME") != -1:
			csv_rows["LT_mean"].append(line.split(":")[1].strip())
		elif line.find("BACKGROUND   COUNTS/CHANNEL") != -1:
			csv_rows["Bkg Counts/Ch"].append(line.split(":")[1].strip())
		elif line.find("TIME-ZERO    CHANNEL TIME") != -1:
			csv_rows["Bkg T0"].append(line.split(":")[1].strip())
		elif line.find("TOTAL AREA   FROM FIT") != -1:
			area = line.split(":")
			table_area = area[2].strip()
			area = area[1].split()[0].strip()
			csv_rows["Area(fit)"].append(area)
			csv_rows["Area(table)"].append(table_area)
		elif line.find("STD DEVIATIONS") != -1:
			if std == 0:
				lt = line.split(":")[1].split()
				lt = [i.strip() for i in lt]
				csv_rows["Std Life-1"].append(lt[0])
				csv_rows["Std Life-2"].append(lt[1])
				csv_rows["Std Life-3"].append(lt[2])
				std += 1
			elif std == 1:
				i = line.split(":")[1].split()
				i = [x.strip() for x in i]
				csv_rows["Std Int-1"].append(i[0])
				csv_rows["Std Int-2"].append(i[1])
				csv_rows["Std Int-3"].append(i[2])
				std += 1
			elif std == 2:
				csv_rows["Std LT_mean"].append(line.split(":")[1].strip())
				std += 1
			elif std == 3:
				csv_rows["Bkg Std"].append(line.split(":")[1].strip())
				std += 1

print(csv_rows)

dict_to_csv(csv_rows, 'output/af.csv')