# numerical_gradient.py

def numerical_gradient(f, x, deriv_steps, *args, **kwargs):
    """
    Calculate numerical gradient of function f at point x
    
    Parameters:
    f: function to differentiate
    x: point at which to calculate gradient
    deriv_steps: step sizes for each dimension
    *args, **kwargs: additional arguments to pass to f
    
    Returns:
    gradient: numpy array of partial derivatives
    """
    p = len(x)
    assert len(deriv_steps) == p, "deriv_steps must have same length as x"
    
    f_old = f(x, *args, **kwargs)
    gradient = np.zeros(p)
    
    for coordinate in range(p):
        x_new = x.copy()
        x_new[coordinate] += deriv_steps[coordinate]
        f_new = f(x_new, *args, **kwargs)
        gradient[coordinate] = (f_new - f_old) / deriv_steps[coordinate]
    
    return gradient

# Example usage
if __name__ == "__main__":
    import numpy as np
    
    # Test function: f(x,y) = x^2 + 2y^2
    def quadratic_function(point):
        return point[0]**2 + 2*point[1]**2
    
    # Calculate gradient at (1, 1)
    point = np.array([1.0, 1.0])
    steps = np.array([0.001, 0.001])  # Small step sizes
    
    grad = numerical_gradient(quadratic_function, point, steps)
    print(f"Numerical gradient: {grad}")
    print(f"Analytical gradient: [2, 4]")  # df/dx = 2x, df/dy = 4y