# Time-Varying Black-Litterman Portfolio Optimization
The Black-Litterman model is a very important analytical tool for active portfolio management because it allows investment analysts to incorporate investor's views into market equilibrium returns. The Time-Varying Black-Litterman Portfolio Optimization under Nonlinear Constraints (TV-BLPONC) problem is a time-varying nonlinear programming problem in which the nonlinear constraints refer to transaction costs and cardinality constraints. Because of this, TV-BLPONC is more realistic and an even greater analysis tool suitable to evaluate investments and identify trading opportunities across a time period than the original Black-Litterman portfolio optimization problem.\
The purpose of this package is to solve online the TV-BLPONC problem by using a combination of the Beetle Antennae Search (BAS) algorithm and the binary BAS (BBAS) algorithm. Several algorithms from the literature are currently implemented, based on the available literature and our understanding. More precisely, the main articles used are the followings:
*	T.E. Simos, S.D.Mourtas, V.N.Katsikis, "Time-Varying Black-Litterman Portfolio Optimization under Nonlinear Constraints via Neuronets and BAS Algorithm," Applied Soft Computing 112, 107767 (2021)
*	M.A. Medvedeva, V.N. Katsikis, S.D. Mourtas, and T.E. Simos, "Randomized time-varying knapsack problems via binary beetle antennae search algorithm: Emphasis on applications in portfolio insurance," Math Meth Appl Sci, pp. 1-11, 2020.
*	X.S. Yang, Nature-inspired optimization algorithms. Elsevier, 2014.
*	K. Deb, Optimization for Engineering Design: Algorithms and Examples. PHI, second ed., July 2013.
*	X. Jiang and S. Li, BAS: Beetle Antennae Search Algorithm for Optimization Problems," arXiv preprint, vol. abs/1710.10724, 2017.
*	Li, Shimin, et al. “Slime Mould Algorithm: A New Method for Stochastic Optimization.” Future Generation Computer Systems, vol. 111, Elsevier BV, Oct. 2020, pp. 300–23, doi:10.1016/j.future.2020.03.055. \
Also, the package includes the following three Matlab functions for comparison purposes:
*	Yarpiz (2020). Artificial Bee Colony (ABC) (https://www.mathworks.com/matlabcentral/fileexchange/52966-artificial-bee-colony-abc-in-matlab), MATLAB Central File Exchange. Retrieved December 30, 2020.
*	Yarpiz (2020). Differential Evolution (DE) (https://www.mathworks.com/matlabcentral/fileexchange/52897-differential-evolution-de), MATLAB Central File Exchange. Retrieved December 8, 2020.
*	Slime Mould Algorithm (SMA) (https://www.mathworks.com/matlabcentral/fileexchange/76619-slime-mould-algorithm-sma-a-method-for-optimization)
The Matlab functions ABC and DE can also be found in https://yarpiz.com/, and the Matlab function SMA can also be found in https://github.com/aliasghar68/Slime-Mould-Algorithm-A-New-Method-for-Stochastic-Optimization-.\
Note that these functions have been appropriately modified for the TV-BLPONC problem.

# M-files Description
*	Main_TVBLPONC.m: the main function and parameters declaration
*	TVBLPONC.m: problem setup and main procedure
*	dataprep.m: Black-Litterman expected return and covariance construction
*	EER.m: function for calculating the equilibrium excess returns
*	problem.m: complementary function for the problem setup
*	objfun.m: objective function of the problem
*	Sphere.m: objective function of the problem used by ABC, DE and SMA algorithms
*	penfun.m: objective function of the problem plus the penalty value
*	penfun2.m: objective function of the binary problem plus the penalty value
*	BAS.m: appropriately modified BAS algorithm
*	BBAS.m: appropriately modified BBAS algorithm
*	abc.m: appropriately modified ABC algorithm
*	DE.m: appropriately modified DE algorithm
*	SMA.m: appropriately modified SMA algorithm
*	RouletteWheelSelection.m: complementary function of the ABC algorithm
*	Initialization.m: complementary function of the SMA algorithm

# Installation
*	Unzip the file you just downloaded and copy the TV-BLPONC directory to a location,e.g.,/my-directory/
*	Run Matlab/Octave, Go to /my-directory/TV-BLPONC/ at the command prompt
*	run 'Main_TVBLPONC' (Matlab/Octave)

# Results
After running the Main_TVBLPONC.m file, the package outputs are the following:
*	The optimal portfolio of TV-BLPONC problem created by BAS, ABC, DE and SMA.
*	The time consumptions of BAS, ABC, DE and SMA.
*	The graphic illustration of the average price of the objected function along with the optimal portfolios expected return, variance and transaction cost.

# Environment
The TV-BLPONC package has been tested in Matlab 2018b on OS: Windows 10 64-bit.
