# optimization_factory.py

import numpy as np
from scipy.optimize import minimize

def optimization_factory():
    factory = np.array([[40, 60], [1, 3]])
    resources = ['labor', 'steel']
    products = ['car', 'truck']
    available = np.array([1600, 70])
    prices = np.array([13, 27])
    
    def revenue(output):
        return -np.dot(output, prices)
    
    # Constraints: factory * output <= available
    constraints = [
        {'type': 'ineq', 'fun': lambda x: available[0] - np.dot(factory[0,:], x)},
        {'type': 'ineq', 'fun': lambda x: available[1] - np.dot(factory[1,:], x)},
        {'type': 'ineq', 'fun': lambda x: x[0]},  # car >= 0
        {'type': 'ineq', 'fun': lambda x: x[1]}   # truck >= 0
    ]
    
    result = minimize(revenue, x0=[5, 5], method='SLSQP', constraints=constraints)
    return result.x

if __name__ == "__main__":
    optimal_production = optimization_factory()
    print("Optimal production plan:", optimal_production)