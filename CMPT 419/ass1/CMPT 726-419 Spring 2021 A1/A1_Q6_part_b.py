import numpy as np
import scipy.io

mdict = scipy.io.loadmat("a.mat")

x = mdict['x'][0]
u = mdict['u'][0]

# Required: write code below that produces two variables, A and B, which
# are scalars of type numpy.float64 that represent the model parameters 
# A and B

### start 1 ###
X = np.matrix([x[:-1], u[:-1]]).T
A, B = np.linalg.lstsq(X, x[1:], rcond=None)[0]
### end 1 ###

# Do not modify the lines below
assert(isinstance(A, np.float64))
assert(isinstance(B, np.float64))

print("A: {}, B: {}".format(A, B))