# numerical_gradient.jl

function numerical_gradient(f, x, deriv_steps, args...; kwargs...)
    """
    Calculate numerical gradient of function f at point x
    
    Parameters:
    f: function to differentiate
    x: point at which to calculate gradient
    deriv_steps: step sizes for each dimension
    args, kwargs: additional arguments to pass to f
    
    Returns:
    gradient: array of partial derivatives
    """
    p = length(x)
    @assert length(deriv_steps) == p "deriv_steps must have same length as x"
    
    f_old = f(x, args...; kwargs...)
    gradient = zeros(p)
    
    for coordinate in 1:p
        x_new = copy(x)
        x_new[coordinate] += deriv_steps[coordinate]
        f_new = f(x_new, args...; kwargs...)
        gradient[coordinate] = (f_new - f_old) / deriv_steps[coordinate]
    end
    
    return gradient
end

# Example usage
if abspath(PROGRAM_FILE) == @__FILE__
    # Test function: f(x,y) = x^2 + 2y^2
    quadratic_function(point) = point[1]^2 + 2*point[2]^2
    
    # Calculate gradient at (1, 1)
    point = [1.0, 1.0]
    steps = [0.001, 0.001]
    
    grad = numerical_gradient(quadratic_function, point, steps)
    println("Numerical gradient: ", grad)
    println("Analytical gradient: [2.0, 4.0]")  # df/dx = 2x, df/dy = 4y
end