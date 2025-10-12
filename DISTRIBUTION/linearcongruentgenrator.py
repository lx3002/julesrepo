seed = 10

def new_random(a=5, c=12, m=16):
    global seed
    out = (a * seed + c) % m
    seed = out
    return out

out_length = 20
variates = [None] * out_length
for kk in range(out_length):
    variates[kk] = new_random()

print(variates)