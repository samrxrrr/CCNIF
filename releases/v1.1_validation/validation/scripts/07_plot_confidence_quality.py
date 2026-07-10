import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv(
    "results/master/Driver_Master_Index.tsv",
    sep="\t"
)

plt.figure(figsize=(8,8))

plt.scatter(
    df["QualityScore"],
    df["DriverConfidence"],
    s=35
)

for _,r in df.head(20).iterrows():
    plt.text(
        r["QualityScore"],
        r["DriverConfidence"],
        r["Driver"],
        fontsize=7
    )

plt.xlabel("Quality Score")
plt.ylabel("Driver Confidence")
plt.title("Confidence vs Quality")
plt.tight_layout()

plt.savefig(
    "validation/figures/Figure4_Confidence_vs_Quality.png",
    dpi=300
)

print("Figure4 complete")
