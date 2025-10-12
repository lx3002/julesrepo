function gamma_est_MM(x)
    m = mean(x)
    v = var(x, corrected=true)  # corrected=true for sample variance like R
    shape = m^2 / v
    scale = v / m
    return (shape=shape, scale=scale)
end

# Test with example data
x = [1.2, 2.3, 1.7, 3.1, 2.8, 1.5, 2.9, 3.5, 2.1, 1.9]
result = gamma_est_MM(x)
println(result)