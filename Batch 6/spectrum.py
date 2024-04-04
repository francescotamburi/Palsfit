import matplotlib.pyplot as plt

first = True

data = []

file = open("50-50.dat")

for line in file:
	if first:
		first = False
		pass
	else:
		data = data + list(map(int,line.split()))

print(data)

plt.semilogy(data, linewidth=0.1, marker=".", markersize=2)
plt.show()