import subprocess

def patfit(pfc_file, output_file_name)
	subprocess.run(["pat19.exe",pfc_file,output_file_name])

def block1()
	while True:
		inp = input("Output variables? (h = help, default = none) \n")
		if type(inp) == "int" and len(str(inp)) == 4:
			break
		elif inp == "h" or inp == "H":
			print("4 digit integer with 0 (off) or 1 (on) indicating")
			print("1st pos: Write input echo to result file")
			print("2nd pos: Write each iteration output to result file")
			print("3rd pos: Write residual plot to result file")
			print("4th pos: Write correlation matrix to result file")
		elif inp == "":
			inp = 0000
			print("Using default output variables \n")
			break
		else:
			print "Error \n"
	return ["POSITRONFIT DATA BLOCK 1: OUTPUT OPTIONS",inp]
	
def block2()
	while True:
		break
	return

def generate_pfc(filename, pfc_path, spectrum): #refer to pg.12 documentation
	output_file = "{}{}.pfc"format(pfc_path,filename)
	out = open(output_file, "w")
	lines = []
	
	lines.extend(block1())
	lines.extend(block2())
	
	return "{}{}.pfc"format(pfc_path,filename)

while(True):
	pfc_file = input("Please input .pfc file")
	output_file_name = input("Please input output file")
	try:
		patfit(pfc_file,output_file_name)
		break
	else:
		cl = input("Error, type x to close") 
		if cl == "x" or "X":
			break