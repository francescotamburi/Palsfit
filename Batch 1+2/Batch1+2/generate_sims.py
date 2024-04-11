sim = ["SIMULATION PARAMETERS: Untitled",
	"NCHAN  10000                                   ! Number of channels",
	"AREA   10000000.                               ! Area without ",
	"BACKGR 0.5                                     ! Background",
	"T0     3000.                                   ! Time-zero T0",
	"CHATIM 3.0000E-03                              ! Time (ns) per channel width",
	"KG     3                                       ! Number of Gaussians in resolution function",
	"FWHM   0.2036 0.3022 0.1573                    ! FWHMs (ns) of the Gaussians",
	"OMEGA  60. 30. 10.                             ! Gaussian intensities (%) - must add up to 100",
	"DP0    0. 0.0203 -0.0847                       ! Shifts (ns) of the Gaussians",
	"K0     2                                       ! Number of lifetimes",
	"TA     0.129 0.37                              ! Lifetimes (ns)",
	"SIGMA  0. 0. 0.                                ! Log-normal standard deviation (0=no broadening)",
	"RINT   4.89 94.96 0.15                         ! Lifetime intensities (%) - must add up to 100",
	"IX     10000                                   ! Initial random integer",
	"NSPEC  1                                       ! Number of simulated spectra",
	"NEXTNR 1                                       ! Number of first spectrum"
	]

t1 = 180
t2 = [x for x in range(220,290,10)]
print(t2)
i1 = [20,50,80]
i2 = [80,50,20]
filenames = []


for life in t2:
	for i in range(3):
		filenames.append("{}_{}".format(life,"{}{}".format(i1[i],i2[i])))


print(filenames)
f_count=0
for tau_2 in t2:
	for i in range(3):
		sim[11] = "TA     {} {}                              ! Lifetimes (ns)".format(t1/1000,tau_2/1000)
		sim[13] = "RINT   {} {}                              ! Lifetime intensities (%) - must add up to 100".format(i1[i],i2[i])
		f = open(filenames[f_count]+".sim", "w")
		f.write("\n".join(sim))
		f.close()
		print(filenames[f_count])
		f_count+=1
	