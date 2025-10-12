# THIS CONTAINS NORMAL DISTRIBTION

import numpy as np
from scipy import stats

def dnorm(x, params, log=False):
    """Normal distribution density function"""
    mu, sigma = params
    if log:
        return stats.norm.logpdf(x, loc=mu, scale=sigma)
    else:
        return stats.norm.pdf(x, loc=mu, scale=sigma)

def loglike_normal(params, x):
    """Log-likelihood for normal distribution"""
    return np.sum(dnorm(x=x, params=params, log=True))

# Test
data = np.array([1.2, 2.1, 1.8, 2.3, 1.9])
params = [2.0, 0.5]  # mu, sigma
result = loglike_normal(params, data)
print(f"Log-likelihood: {result:.4f}")