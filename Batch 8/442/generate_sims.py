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
	"K0     3                                       ! Number of lifetimes",
	"TA     0.129 0.37 2.                           ! Lifetimes (ns)",
	"SIGMA  0. 0. 0.                                ! Log-normal standard deviation (0=no broadening)",
	"RINT   4.89 94.96 0.15                         ! Lifetime intensities (%) - must add up to 100",
	"IX     10000                                   ! Initial random integer",
	"NSPEC  1                                       ! Number of simulated spectra",
	"NEXTNR 1                                       ! Number of first spectrum"
	]

t1 = [332.2,325.7,313.5,291.6,186.9,111.7,66.9]
t2 = 442
i1 = [91.83,85.01,74.01,58.79,22.23,10.26,5.41]
i2 = [8.02,14.84,25.84,41.06,77.62,89.59,94.44]
filenames = ["9010","8515","7525","6040","2080","1090","0595"]

for file,t1,i1,i2 in zip(filenames,t1,i1,i2):
	sim[11] = "TA     {} {} 2.                           ! Lifetimes (ns)".format(t1/1000,t2/1000)
	sim[13] = "RINT   {} {} 0.15                         ! Lifetime intensities (%) - must add up to 100".format(i1,i2)
	f = open(file+".sim", "w")
	f.write("\n".join(sim))
	f.close()