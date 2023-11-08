import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

class Plotter:
	
	def __init__(self, df):
		self.df = df
	
	def plot(self, x, y, error, label, marker):
		plt.errorbar(self.df[x], self.df[y], yerr=self.df[error], linestyle="none", capsize=5, label=label, marker=marker)
	
	def diff(self, x, y1, y2, error, label, marker):
		plt.errorbar(self.df[x], np.array(self.df[y1]) - np.array(self.df[y2]), yerr=df[error], linestyle="none", capsize=5, label=label, marker=marker)
	
	def greyLine(self, y):
		plt.axhline(y=y, color="grey", linestyle="dashed")
	
	def greyPoints(self, x, y, marker):
		plt.plot(self.df[x], self.df[y], color="grey", marker=marker)

df = pd.read_csv("af.csv")

p = Plotter(df)

p.plot("Sim Int-2","Life-1", "Std Life-1","a", "x")
p.greyPoints("Sim Int-2","Sim Life-1", "*")
plt.show()