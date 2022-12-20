#generate a list of the spectra inside the file
def palsreader(file):
	
	spectra = [] #list of spectra to be returned
	lines = file.readlines()
	
	while len(lines)>0:
		spectrum = [[],"metadata: "]
		spectrum[1] = lines.pop(0)
		spec_width = len(lines[1])
		print(spec_width)
	
		for line in range(len(lines)):
			line = lines.pop(0)
			length = len(line)
			if length == 1:
				spectra.append(spectrum)
				break
			print(line)
			line = line.split()
			spectrum[0].extend(line)
	
	spectra.append(spectrum)
	#print(spectra)
	
	for s in reversed(spectra):
		if s[0] == []:
			spectra.pop()
		else:
			break
	
	return spectra

def meltwriter(filename, spectra):
	Nspectra = len(spectra)
	open("{}_metadata.txt".format(filename),"w").close()
	metadata = open("{}_metadata.txt".format(filename), "a")
	for i in range(Nspectra):
		metadata.write("{} = {}".format(i, spectra[i][1]))
		open("{}melt{}.dat".format(filename, i), "w")
		file = open("{}melt{}.dat".format(filename, i), "a")
		for datapoint in spectra[i][0]:
			file.write("{:>9}\n".format(datapoint))
		file.close()
	metadata.close()

if __name__ == "__main__":
	filename = input("State spectrum file to be converted \n")
	file = open(filename,"r")
	spectra = palsreader(file)
	file.close()
	filename = filename.split(".")[0]
	meltwriter(filename, spectra)