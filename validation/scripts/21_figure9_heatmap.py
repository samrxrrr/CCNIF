import pandas as pd
import matplotlib.pyplot as plt

df=pd.read_csv(
"validation/results/reports/Integrated_Benchmark.tsv",
sep="\t"
)

heat=df[
["OncoKB","CancerMine","NCG"]
].astype(int)

plt.figure(figsize=(6,12))

plt.imshow(
heat,
aspect="auto"
)

plt.yticks(range(len(df)),df.Driver,fontsize=6)

plt.xticks(
range(3),
["OncoKB","CancerMine","NCG"]
)

plt.colorbar(label="Present")

plt.title("Figure 9. External Evidence Heatmap")

plt.tight_layout()

plt.savefig(
"validation/figures/Figure9_Evidence_Heatmap.png",
dpi=600
)

print("Figure9 complete")
