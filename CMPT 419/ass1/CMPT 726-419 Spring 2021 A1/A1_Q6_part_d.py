import numpy as np
import scipy.io

mdict = scipy.io.loadmat("b.mat")

X_raw = mdict['x']
U_raw = mdict['u']

# Required: write code below that produces two variables, A and B, which
# are 3 x 3 float64 matrices of type numpy.ndarray that represent the 
# model parameters A and B

### start 2 ###

### end 2 ###

# Do not modify the lines below
assert(isinstance(A, np.ndarray))
assert(isinstance(B, np.ndarray))
assert(A.shape == (3,3))
assert(B.shape == (3,3))
assert(A.dtype == np.float64)
assert(B.dtype == np.float64)

print("A: \n{}, \nB: \n{}".format(A, B))