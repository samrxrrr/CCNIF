import pandas as pd
import matplotlib.pyplot as plt

df=pd.read_csv(
"validation/results/biological/Biological_Benchmark_Summary.tsv",
sep="\t"
)

plt.figure(figsize=(8,5))

plt.plot(
df.Database,
df.ReferenceGenes,
marker="o",
label="Reference Genes"
)

plt.plot(
df.Database,
df.MatchedDrivers,
marker="s",
label="Matched Drivers"
)

plt.legend()

plt.title("Figure 11. Reference Database Summary")

plt.tight_layout()

plt.savefig(
"validation/figures/Figure11_Reference_Summary.png",
dpi=600
)

print("Figure11 complete")
