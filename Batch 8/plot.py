import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

O = "#fe7611"
G = "#19c513"
B = "#1dadff"
P = "#fb3efd"
g  = "#cdcd"
dg = "#aaaa"

plt.rcParams['text.usetex'] = True
plt.rcParams['font.size'] = 12

df = pd.read_excel("Red Bulk 442.xlxs")

print(df["I2 (Kanda)"])
print(df["Reduced Bulk"])
input()