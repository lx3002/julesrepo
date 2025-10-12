import numpy as np

def gamma_est_MM(x):
    m = np.mean(x)
    v = np.var(x, ddof=1)  # ddof=1 for sample variance like R
    shape = m**2 / v
    scale = v / m
    return {'shape': shape, 'scale': scale}

# Test with example data
x = np.array([1.2, 2.3, 1.7, 3.1, 2.8, 1.5, 2.9, 3.5, 2.1, 1.9])
result = gamma_est_MM(x)
print(result)