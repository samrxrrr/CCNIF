import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv(
    "results/master/Driver_Master_Index.tsv",
    sep="\t"
)

counts = (
    df["ConfidenceTier"]
    .value_counts()
    .sort_index()
)

plt.figure(figsize=(6,6))

plt.bar(
    counts.index,
    counts.values
)

plt.xlabel("Confidence Tier")
plt.ylabel("Drivers")
plt.title("Driver Confidence Tier Distribution")

plt.tight_layout()

plt.savefig(
    "validation/figures/Figure5_Confidence_Tiers.png",
    dpi=300
)

print("Figure5 complete")
