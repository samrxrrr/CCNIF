import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv(
    "results/master/Driver_Master_Index.tsv",
    sep="\t"
)

plt.figure(figsize=(8,6))
plt.hist(df["QualityScore"], bins=15)
plt.xlabel("Quality Score")
plt.ylabel("Drivers")
plt.title("Distribution of Quality Scores")
plt.tight_layout()
plt.savefig(
    "validation/figures/Figure3_Quality_Distribution.png",
    dpi=300
)
print("Figure3 complete")
