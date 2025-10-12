using JuMP, GLPK

# 1. lp_data_definition

# Factory matrix: Rows = Resources (Labor, Steel), Cols = Products (Car, Truck)
factory = [
    40.0 60.0;  # Labor consumption per Car/Truck
     1.0  3.0   # Steel consumption per Car/Truck
]

# Available resources (b)
available = [1600.0, 70.0] # [Labor, Steel]

# Prices (c): Revenue per unit (to be MAXIMIZED)
prices = [13.0, 27.0]

# 2. jl_linear_programming (Using dedicated LP solver JuMP)

# Create a JuMP model using the GLPK solver
model = Model(GLPK.Optimizer)

# Define variables: car and truck, ensuring they are non-negative
@variable(model, car >= 0)
@variable(model, truck >= 0)

# Objective: Maximize Revenue (13*car + 27*truck)
@objective(model, Max, prices[1] * car + prices[2] * truck)

# Constraints (Resource Limits): factory * output <= available
# 1. Labor Constraint: 40*car + 60*truck <= 1600
@constraint(model, Labor, factory[1, 1] * car + factory[1, 2] * truck <= available[1])

# 2. Steel Constraint: 1*car + 3*truck <= 70
@constraint(model, Steel, factory[2, 1] * car + factory[2, 2] * truck <= available[2])

# Run the optimization
optimize!(model)

print("--- Julia Linear Programming Results (JuMP) ---\n")
if termination_status(model) == MOI.OPTIMAL
    print("Optimal Production Plan (car, truck):\n")
    # Extract the optimized values
    @show value(car)
    @show value(truck)
    @show objective_value(model)
else
    print("Optimization failed. Status: ", termination_status(model))
end