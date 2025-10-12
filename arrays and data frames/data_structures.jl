using LinearAlgebra, DataFrames

# ARRAYS
x = [7, 8, 10, 45]
x_arr = reshape(x, 2, 2)
println(x_arr)
println(size(x_arr))
println(isa(x_arr, Array))
println(eltype(x_arr))
println(x_arr[1,2])
println(x_arr[3])
println(x_arr[:,2])
println(findall(>(9), x_arr))
y = -x
y_arr = reshape(y, 2, 2)
println(y_arr + x_arr)
println(sum(x_arr, dims=2))

# DATA FRAMES
states = DataFrame(
    Population = [3615, 365, 2212, 2110, 21198],
    Income = [3624, 6315, 4530, 3378, 5114],
    Illiteracy = [2.1, 1.5, 1.8, 1.9, 1.1],
    LifeExp = [69.05, 69.31, 70.55, 70.66, 71.71],
    HSGrad = [41.3, 66.7, 58.1, 39.9, 62.6]
)
println(states)
println(states[5, :])
println(states[5, :Illiteracy])
println(filter(row -> row.Illiteracy > 1.5, states))
states.HSGrad ./= 100
states.HSGrad .*= 100
states.LiterateGrad = 100 .* (states.HSGrad ./ (100 .- states.Illiteracy))
println(first(states.LiterateGrad, 5))

# EIGENVALUES
factory = [35 10; 8 4]
eigvals_, eigvecs_ = eigen(factory)
println(eigvals_)
println(eigvecs_)
println(eigvals_[2] * eigvecs_[:,2])

# ADDING ROWS AND COLUMNS
df = DataFrame(v1=[35,8], v2=[10,4], logicals=[true,false])
push!(df, (v1=-3, v2=-5, logicals=true))
println(df)

# DICTIONARIES
plan = Dict("factory"=>factory, "available"=>Dict("labor"=>40,"steel"=>20), "output"=>Dict("trucks"=>20,"cars"=>10))
println(plan["output"])
my_distribution = Dict("family"=>"exponential", "mean"=>5, "rate"=>1/5)
my_distribution["was_estimated"] = false
my_distribution["last_updated"] = "2011-08-30"
delete!(my_distribution, "was_estimated")
println(my_distribution)
