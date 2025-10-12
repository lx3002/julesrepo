import numpy as np
import matplotlib.pyplot as plt
from sklearn.utils import resample
import pandas as pd
from sklearn.linear_model import LinearRegression

# --- Toy Collector Problem ---
prob_table = np.array([.2, .1, .1, .1, .1, .1, .05, .05, .05, .05, .02, .02, .02, .02, .02])
boxes = np.arange(1, 16)

def box_count(prob=prob_table):
    collected = np.zeros(len(prob))
    count = 0
    while np.sum(collected) < len(prob):
        x = np.random.choice(boxes, p=prob)
        collected[x-1] = 1
        count += 1
    return count

sim_boxes = [box_count() for _ in range(1000)]
plt.hist(sim_boxes, bins=30, color='skyblue')
plt.title("Toy Collector Simulation")
plt.xlabel("Boxes"); plt.ylabel("Frequency")
plt.show()

# --- Bootstrap Example: Speed of Light ---
speed = np.array([28, -44, 29, 30, 26, 27, 22, 23, 33, 16,
                  24, 29, 24, 40, 21, 31, 34, -2, 25, 19])
newspeed = speed - np.mean(speed) + 33.02
bstrap = [np.mean(np.random.choice(newspeed, size=20, replace=True)) for _ in range(1000)]

plt.hist(bstrap, bins=30, color='lightblue')
plt.title("Bootstrap Sampling Distribution")
plt.show()

p_val = (np.sum(np.array(bstrap) < 21.75) + np.sum(np.array(bstrap) > 44.29)) / 1000
print("P-value:", p_val)

# --- Bootstrap Regression R² ---
from sklearn.metrics import r2_score
import statsmodels.api as sm

df = sm.datasets.get_rdataset("mtcars").data
X = df[['wt', 'disp']]
y = df['mpg']

def bootstrap_rsq(X, y, n_boot=1000):
    rsq_vals = []
    for _ in range(n_boot):
        X_res, y_res = resample(X, y)
        model = LinearRegression().fit(X_res, y_res)
        rsq_vals.append(model.score(X_res, y_res))
    return np.array(rsq_vals)

rsq_vals = bootstrap_rsq(X, y)
print("R² mean:", rsq_vals.mean(), "Std. Err:", rsq_vals.std())
plt.hist(rsq_vals, color='lightgreen', bins=30)
plt.title("Bootstrap R² Distribution (mpg~wt+disp)")
plt.show()
