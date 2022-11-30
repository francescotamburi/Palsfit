#generate a list of the spectra inside the file
def palsreader(file):
	
	spectra = [] #list of spectra to be returned
	lines = file.readlines()
	
	while len(lines)>0:
		spectrum = [[],"metadata: "]
		spectrum[1] = lines.pop(0)
		spec_width = len(lines[1])
	
		for line in range(len(lines)):
			line = lines.pop(0)
			length = len(line)
			if length == spec_width:
				line = line.split()
				spectrum[0].extend(line)
			elif length == 1:
				spectrum = [[],"metadata: "]
				break
	
	spectra.append(spectrum)
	
	for s in reversed(spectra):
		if s[0] == []:
			spectra.pop()
		else:
			break
	
	return spectra

def meltwriter(filename, spectra):
	Nspectra = len(spectra)
	open("metadata.txt","w").close()
	metadata = open("metadata.txt", "a")
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