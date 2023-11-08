import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

def intensitySeparator(df):
	tau_2080 = df[df["Sim Int-1"]==20]
	tau_5050 = df[df["Sim Int-1"]==50]
	tau_8020 = df[df["Sim Int-1"]==80]
	return tau_2080, tau_5050, tau_8020

class Plotter:
	
	def __init__(self, x_label):
		self.x = x_label
	
	def Tau1(self, df, label, marker, ):
		plt.errorbar(df[self.x], df["Life-1"], yerr=df["Std Life-1"], linestyle="none", capsize=5, label=label, marker=marker)
	
	def Tau2diff(self, df, label, marker):
		plt.errorbar(df[self.x], np.array(df["Life-2"]) - np.array(df["Sim Life-2"])/1000, yerr=df["Std Life-2"], capsize=5, label=label, marker=marker)
	
	def Intensity(self, df, label, marker):
		plt.errorbar(df[self.x], df["Int-1"], yerr=["Std Int-1"], linestyle="none", capsize=5, label=label, marker=marker)
		plt.errorbar(df[self.x], df["Int-2"], yerr=["Std Int-2"], linestyle="none", capsize=5, label=label, marker=marker)
		
	def GreyLine(y):
		plt.axline(y=y, color="grey", linestyle="dashed")

TauRatio = Plotter("TauRatio")
