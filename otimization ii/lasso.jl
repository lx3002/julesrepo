# linear_regression_mse.jl

using LinearAlgebra, Statistics, GLM, DataFrames

function linear_regression_mse()
    # Generate data
    x = randn(100, 2)
    y = x * [2, 1] + randn(100) * 0.05
    
    # MSE function
    function mse(b1, b2)
        y_pred = x * [b1, b2]
        return mean((y .- y_pred) .^ 2)
    end
    
    # Coefficient sequences
    coef_seq = range(-1, 5, length=200)
    
    # Calculate MSE surface
    m = zeros(length(coef_seq), length(coef_seq))
    for i in 1:length(coef_seq)
        for j in 1:length(coef_seq)
            m[i,j] = mse(coef_seq[i], coef_seq[j])
        end
    end
    
    # L1 regularization levels
    l1(b1, b2) = abs(b1) + abs(b2)
    
    l1_levels = zeros(length(coef_seq), length(coef_seq))
    for i in 1:length(coef_seq)
        for j in 1:length(coef_seq)
            l1_levels[i,j] = l1(coef_seq[i], coef_seq[j])
        end
    end
    
    # OLS coefficients using GLM
    df = DataFrame(x1=x[:,1], x2=x[:,2], y=y)
    model = lm(@formula(y ~ 0 + x1 + x2), df)
    ols_coefs = coef(model)
    
    return (mse_surface=m, l1_levels=l1_levels, 
            coef_seq=coef_seq, ols_coefs=ols_coefs,
            true_coefs=[2, 1])
end

# Run the analysis
results = linear_regression_mse()
println("OLS coefficients: ", results.ols_coefs)
println("True coefficients: ", results.true_coefs)