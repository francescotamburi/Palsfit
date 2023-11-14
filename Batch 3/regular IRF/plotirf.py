import matplotlib.pyplot as plt
import numpy as np

C = "#00DDDD"
M = "#DD00DD"
Y = "#DDDD00"
K = "#000000"
O = "#ff7f00"
g = "#cdcd"


class Gaussian:
	def __init__(self, fwhm, intensity, shift):
		self.intensity = intensity
		self.fwhm = fwhm
		self.shift = shift
		self.prep()
	
	def prep(self):
		self.amplitude = self.intensity
		self.std_dev = self.fwhm/2.355
		self.mean = self.shift
		
	def equation(self, x):
		return self.amplitude * np.exp(-.5*((x-self.mean)/self.std_dev)**2)
	
g1 = Gaussian(213.3, 80, 0)
g2 = Gaussian(150, 10, -5)
g3 = Gaussian(267, 10, 17)

x = np.linspace(200,-200,1000000)
y1 = g1.equation(x)
y2 = g2.equation(x)
y3 = g3.equation(x)
y = y1 + y2 + y3

def find_peak(y):
	return index(max(y))

def fwhm(y_list,x):
	h_index = np.argmax(y_list)
	h = max(y_list)
	
	diff = np.absolute(y_list-h/2)
	t1 = diff[:h_index].argmin()
	t2 = diff[h_index:].argmin()
	print(x[t1],x[t2+h_index])
	
	return abs(x[t2+h_index] - x[t1])

print("peak = {}".format(x[np.argmax(y)]))
print("fwhm = {}".format(fwhm(y, x)))

plt.plot(x,y, color = K, label="IRF")
plt.plot(x,y1, color = C)
plt.plot(x,y2, color = M)
plt.plot(x,y3, color = Y)
#plt.axhline(y = 50, color = g, linestyle = 'dashed')

plt.ylabel("Intensity %")
plt.xlabel("Time (ps)")
plt.legend()
plt.show()