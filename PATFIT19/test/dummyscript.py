f = open("aaa.txt", "w")
if input("hello") == "hi":
	f.write("allo")
else:
	f.write("yello")

f.close()