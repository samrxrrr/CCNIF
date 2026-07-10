import pandas as pd
import matplotlib.pyplot as plt

df=pd.read_csv(
    "results/master/Driver_Master_Index.tsv",
    sep="\t"
)

plt.figure(figsize=(8,6))

plt.hist(
    df["DriverConfidence"],
    bins=15
)

plt.xlabel("Driver Confidence")
plt.ylabel("Count")
plt.title("Distribution of Driver Confidence Scores")

plt.tight_layout()

plt.savefig(
    "validation/figures/Figure2_Confidence_Distribution.png",
    dpi=300
)

print("Figure saved.")
