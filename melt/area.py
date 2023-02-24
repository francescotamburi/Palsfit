from matplotlib import pyplot as plt

file = open(input("Spectrum file: "))
lines = file.readlines()

y = [int(line.strip()) for line in lines]

print(sum(y))
input()