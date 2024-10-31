import numpy as np
import matplotlib.pyplot as plt
import matplotlib.patches as patches


def parse_mag_file(filename):
    layers = {}
    current_layer = None

    with open(filename, "r") as f:
        for line in f:
            line = line.strip()
            if line.startswith("<<"):
                current_layer = line[2:-2].strip()
                layers[current_layer] = []
            elif line.startswith("rect"):
                _, x1, y1, x2, y2 = line.split()
                layers[current_layer].append(
                    [float(x1), float(y1), float(x2), float(y2)]
                )

    return layers


layer_color_map = {
    "nwell": (150, 150, 150),
    "ntransistor": (126, 143, 74),
    "ptransistor": (193, 116, 98),
    "ndiffusion": (66, 213, 66),
    "pdiffusion": (202, 160, 115),
    "ndcontact": (98, 191, 159),
    "pdcontact": (165, 164, 182),
    "psubstratepcontact": (176, 176, 188),
    "nsubstratencontact": (131, 193, 172),
    "polysilicon": (220, 95, 95),
    "metal1": (125, 166, 250),
}


def get_layer_color(layer_name: str) -> tuple:
    color = layer_color_map.get(layer_name, (0, 0, 0))
    return tuple([x / 255 for x in color])


def visualize_mag_data(layers, filename: str):
    del layers["labels"]
    del layers["end"]
    _, ax = plt.subplots(figsize=(10, 10))

    # Generate a unique color for each layer
    colors = {layer_name: get_layer_color(layer_name) for layer_name in layers.keys()}

    # Iterate through each layer and plot the rectangles
    for layer_name, rectangles in layers.items():
        for rect in rectangles:
            x1, y1, x2, y2 = rect
            ax.add_patch(
                patches.Rectangle(
                    (x1, y1),
                    x2 - x1,
                    y2 - y1,
                    edgecolor="black",
                    facecolor=colors[layer_name],
                    alpha=0.5,
                )
            )

    # Customize the plot
    ax.set_xlim(-5, 35)  # Adjust limits as needed
    ax.set_ylim(-5, 100)  # Adjust limits as needed
    ax.set_xlabel("X-axis")
    ax.set_ylabel("Y-axis")
    ax.set_title(
        "Visualization of " + filename.split("/")[-1].split(".")[0] + ".mag file"
    )
    ax.set_aspect("equal", adjustable="box")
    plt.grid(True)

    # Remove borders (spines)
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)
    ax.spines["left"].set_visible(False)
    ax.spines["bottom"].set_visible(False)

    # Create custom legend outside the plot
    handles = [
        patches.Rectangle((0, 0), 1, 1, color=color, alpha=0.5)
        for color in colors.values()
    ]
    ax.legend(
        handles, colors.keys(), loc="upper left", bbox_to_anchor=(1, 1), title="Layers"
    )

    # Disable grid
    plt.grid(False)

    # Hide axis
    plt.axis("off")

    plt.tight_layout()  # Adjust layout to make room for legend
    plt.savefig(f"{filename.split('.')[0]}_mag.png", bbox_inches="tight")


# Main execution
import sys

filename = sys.argv[1]
layers = parse_mag_file(filename)
visualize_mag_data(layers, filename)
