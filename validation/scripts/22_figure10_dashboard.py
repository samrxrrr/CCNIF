import pandas as pd
import matplotlib.pyplot as plt

df=pd.read_csv(
"results/master/Driver_Master_Index.tsv",
sep="\t"
)

plt.figure(figsize=(8,6))

plt.scatter(
df.DriverConfidence,
df.QualityScore,
s=40
)

plt.xlabel("Driver Confidence")
plt.ylabel("Quality Score")

plt.title("Figure 10. CCNIF Driver Dashboard")

plt.tight_layout()

plt.savefig(
"validation/figures/Figure10_Dashboard.png",
dpi=600
)

print("Figure10 complete")
