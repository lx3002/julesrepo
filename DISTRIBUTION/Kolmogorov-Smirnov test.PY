import numpy as np
from scipy import stats
from scipy.stats import gamma

def ks_test_gamma_python(data, shape, scale):
    """
    One-sample Kolmogorov-Smirnov test for Gamma distribution
    
    Args:
        data: Array-like data to test
        shape: Shape parameter for Gamma distribution
        scale: Scale parameter for Gamma distribution
    
    Returns:
        KS test results
    """
    # Check for ties
    if len(data) != len(np.unique(data)):
        print("Warning: Ties should not be present for the Kolmogorov-Smirnov test")
    
    # Perform KS test
    d_stat, p_value = stats.kstest(
        data, 
        'gamma', 
        args=(shape, 0, scale)  # shape, location, scale
    )
    
    print(f"One-sample Kolmogorov-Smirnov test")
    print(f"data:  data")
    print(f"D = {d_stat:.6f}, p-value = {p_value:.4f}")
    print(f"alternative hypothesis: two-sided")
    
    return d_stat, p_value

# Example usage with cats dataset equivalent
# Assuming we have cats data loaded
try:
    # If you have the MASS package equivalent data
    from sklearn.datasets import fetch_data
    # This is just an example - you'd need actual cats data
    cats_hwt = np.array([...])  # Your actual cat heart weight data here
    
    # Example parameters from gamma estimation
    cats_gamma_shape = 2.5  # Example value
    cats_gamma_scale = 1.2  # Example value
    
    result = ks_test_gamma_python(cats_hwt, cats_gamma_shape, cats_gamma_scale)
    
except ImportError:
    # Create synthetic example data
    print("Using synthetic data for demonstration")
    np.random.seed(123)
    cats_hwt = gamma.rvs(a=2.5, scale=1.2, size=100)  # Synthetic cat heart weights
    cats_gamma_shape = 2.5
    cats_gamma_scale = 1.2
    
    result = ks_test_gamma_python(cats_hwt, cats_gamma_shape, cats_gamma_scale)