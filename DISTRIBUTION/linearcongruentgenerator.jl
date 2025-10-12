seed = Ref(10)  # Use Ref to make seed mutable in closures

function new_random(a=5, c=12, m=16)
    out = (a * seed[] + c) % m
    seed[] = out
    return out
end

out_length = 20
variates = Vector{Union{Nothing, Int}}(undef, out_length)
for kk in 1:out_length
    variates[kk] = new_random()
end

variates