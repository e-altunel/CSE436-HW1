import matplotlib.pyplot as plt
import numpy as np
import sys

# Load data, assuming it starts with a header line and space-separated columns.
data = np.loadtxt(sys.argv[1])

# Extract columns: typically the first is time, and the others are signals like V(a), V(b), V(y)
time = data[:, 0]
v_a = data[:, 1]
if data.shape[1] > 4:
    v_b = data[:, 3]
    v_y = data[:, 5]
else:
    v_y = data[:, 3]

# Create a figure with subplots
if data.shape[1] > 4:
    fig, axs = plt.subplots(nrows=3, ncols=1, figsize=(10, 12))
else:
    fig, axs = plt.subplots(nrows=2, ncols=1, figsize=(10, 8))

# Plot each signal in a different subplot
axs[0].plot(time, v_a, label="V(in)", color="blue")
axs[0].set_ylabel("Voltage (V)")
axs[0].set_title("V(in) vs Time")
axs[0].grid(True)

if data.shape[1] > 4:
    axs[1].plot(time, v_b, label="V(in2)", color="green")
    axs[1].set_ylabel("Voltage (V)")
    axs[1].set_title("V(in2) vs Time")
    axs[1].grid(True)

    axs[2].plot(time, v_y, label="V(out)", color="red")
    axs[2].set_xlabel("Time (s)")
    axs[2].set_ylabel("Voltage (V)")
    axs[2].set_title("V(out) vs Time")
    axs[2].grid(True)
else:
    axs[1].plot(time, v_y, label="V(out)", color="red")
    axs[1].set_xlabel("Time (s)")
    axs[1].set_ylabel("Voltage (V)")
    axs[1].set_title("V(out) vs Time")
    axs[1].grid(True)

# Adjust layout to prevent overlap
plt.tight_layout()

# Save the figure
plt.savefig(sys.argv[2])
