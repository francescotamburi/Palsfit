from matplotlib import pyplot as plt

file = open(input("Spectrum file: "))
lines = file.readlines()

y = [int(line.strip()) for line in lines]
plt.plot(y, linestyle="none", marker='.')
plt.yscale('log')

plt.savefig("plot.png")
#plt.show()