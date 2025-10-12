using Random, Distributions, Plots

# --- Binomial (manual) ---
function my_binom_1(n::Int=1, p::Float64=1/3)
    u = rand(n)
    return sum(u .< p)
end
println(my_binom_1(1000))
println(my_binom_1(1000, 0.5))

# --- Quantile Transform ---
function my_binom_2(n::Int=1, p::Float64=1/3)
    u = rand()
    return quantile(Binomial(n, p), u)
end
println(my_binom_2(1000))
println(my_binom_2(1000, 0.5))

# --- Exponential via inverse CDF ---
u = rand(10000)
β = 3.0
x = -β .* log.(1 .- u)
histogram(x, bins=30, color=:lightblue, title="Exponential(β=3)")

println(mean(x))

# --- Gamma (accept-reject) ---
function ar_gamma(n::Int=100)
    x = Float64[]
    while length(x) < n
        u = rand()
        y = u < 0.5 ? -log(1 - rand()) : -log(1 - rand()) - log(1 - rand())
        u2 = rand()
        temp = 2 * sqrt(y) / (1 + y)
        if u2 < temp
            push!(x, y)
        end
    end
    return x
end

xg = ar_gamma(10000)
histogram(xg, bins=30, color=:lightgreen, title="Gamma(3/2,1)")
println(mean(xg))

# --- Beta via rejection sampling ---
x1 = rand(300)
y1 = rand(300) .* 2.6
selected = y1 .< pdf.(Beta(3,6), x1)
accepted = x1[selected]
histogram(accepted, bins=30, color=:orange, title="Beta(3,6) via Rejection Sampling")

println(mean(selected))
println(mean(accepted .< 0.5))
println(cdf(Beta(3,6), 0.5))

# --- Box–Muller Transform ---
u = rand(10000)
v = rand(10000)
r = sqrt.(-2 .* log.(u))
θ = 2π .* v
x_norm = r .* cos.(θ)
histogram(x_norm, bins=40, color=:lightblue, title="Box–Muller Normal(0,1)")
