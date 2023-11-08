import matplotlib.pyplot as plt
import numpy as np

R = "#e41a1c"
B = "#377eb8"
G = "#4daf4a"
P = "#984ea3"
O = "#ff7f00"

s_con = (2*np.sqrt(2*np.log(2)))

a1 = 213.3
b1 = 0.8
s1 = b1/s_con
c1 = 0

a2 = 150.2
b2 = 0.1
s2 = b2/s_con
c2 = -5

a3 = 265.7
b3 = 0.1
s3 = b3/s_con
c3 = 17



x = np.linspace(200,-200,100000)
y1 = a1 * 1/(s1*np.sqrt(2*np.pi)) * np.exp(-(x-c1)**2/(2*(s1)**2))
y2 = a2 * 1/(s1*np.sqrt(2*np.pi)) * np.exp(-(x-c2)**2/(2*(s2)**2))
y3 = a3 * 1/(s1*np.sqrt(2*np.pi)) * np.exp(-(x-c3)**2/(2*(s3)**2))
y = y1 + y2 + y3

plt.tick_params(
    axis='x',          # changes apply to the x-axis
    which='both',      # both major and minor ticks are affected
    left=False,      # ticks along the bottom edge are off
    right=False,         # ticks along the top edge are off
    labelleft=False) # labels along the bottom edge are off

plt.plot(x,y)
plt.plot(x,y1)
plt.plot(x,y2)
plt.plot(x,y3)
plt.show()