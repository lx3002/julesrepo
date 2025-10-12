# optimization_factory.jl

using Optim

function optimization_factory()
    factory = [40 60; 1 3]
    available = [1600.0, 70.0]
    prices = [13.0, 27.0]
    
    function revenue(output)
        return -dot(output, prices)
    end
    
    # Constraints: factory * x <= available, x >= 0
    lower_bounds = [0.0, 0.0]
    upper_bounds = [Inf, Inf]
    
    # For linear constraints: A*x <= b
    A = factory
    b = available
    
    # Using Fminbox with L-BFGS for constrained optimization
    result = optimize(revenue, lower_bounds, upper_bounds, [5.0, 5.0], Fminbox(LBFGS()))
    return result.minimizer
end

# Run the optimization
optimal_production = optimization_factory()
println("Optimal production plan: ", optimal_production)