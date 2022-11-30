#generate a list of the spectra inside the file
def palsreader(file):
	spectra = []
	spectrum = [[],"metadata: "]
	for line in file:
		length = len(line)
		if length == 81:
			line = line.split()
			#print(line)
			spectrum[0].extend(line)
		elif length < 81 and length != 1:
			spectrum[1] = line
			print(line)
		elif length == 1:
			print("h")
			spectra.append(spectrum)
			spectrum = [[],"metadata: "]
	spectra.append(spectrum)
	
	print(spectra)
	
	for s in reversed(spectra):
		if s[0] == []:
			spectra.pop()
		else:
			break
	
	return spectra

def meltwriter(filename, spectra):
	Nspectra = len(spectra)
	metadata = open("metadata.txt", "a")
	for i in range(Nspectra):
		metadata.write(spectra[i][1])
		open("{}melt{}.dat".format(filename, i), "w")
		file = open("{}melt{}.dat".format(filename, i), "a")
		for datapoint in spectra[i][0]:
			#print(datapoint)
			file.write("{:>9}\n".format(datapoint))
		file.close()
	metadata.close()

if __name__ == "__main__":
	filename = input("State spectrum file to be converted \n")
	file = open(filename,"r")
	spectra = palsreader(file)
	file.close()
	filename = filename.split(".")[0]
	#print(spectra)
	meltwriter(filename, spectra)