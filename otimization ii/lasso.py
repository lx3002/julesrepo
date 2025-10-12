# linear_regression_mse.py

import numpy as np
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression

def linear_regression_mse():
    # Set random seed for reproducibility
    np.random.seed(42)
    
    # Generate data
    x = np.random.randn(100, 2)
    y = x @ np.array([2, 1]) + np.random.randn(100) * 0.05
    
    # MSE function
    def mse(b1, b2):
        y_pred = x @ np.array([b1, b2])
        return np.mean((y - y_pred) ** 2)
    
    # Coefficient sequences
    coef_seq = np.linspace(-1, 5, 200)
    
    # Create meshgrid for 2D evaluation
    B1, B2 = np.meshgrid(coef_seq, coef_seq)
    
    # Calculate MSE surface
    m = np.zeros_like(B1)
    for i in range(B1.shape[0]):
        for j in range(B1.shape[1]):
            m[i,j] = mse(B1[i,j], B2[i,j])
    
    # L1 regularization levels
    def l1(b1, b2):
        return np.abs(b1) + np.abs(b2)
    
    l1_levels = l1(B1, B2)
    
    # OLS coefficients
    model = LinearRegression(fit_intercept=False)
    model.fit(x, y)
    ols_coefs = model.coef_
    
    return {
        'mse_surface': m,
        'l1_levels': l1_levels,
        'B1': B1,
        'B2': B2,
        'ols_coefs': ols_coefs,
        'true_coefs': np.array([2, 1])
    }

if __name__ == "__main__":
    results = linear_regression_mse()
    print("OLS coefficients:", results['ols_coefs'])
    print("True coefficients:", results['true_coefs'])