import os

palsfit, current = os.getcwd().split("\\Palsfit\\")

palsfit = palsfit + "\\Palsfit\\"

while True:
	procedure = input("1 = single dataset \n2 = comparison \n")
	if procedure == "1":
		procedure = "spec"
		break
	elif procedure == "2":
		procedure = "comp"
		break
	else:
		print("please enter '1' or '2' \n")

template = open(palsfit + "utilities\\figure maker\\" + procedure + ".txt").read()

template = template.replace("&name&", input("figure name: "))
template = template.replace("&path&", current)

if procedure == "spec":
	template = template.replace("&t1&", input("tau 1: "))

out = open("fig.txt", "w")
out.write(template)
