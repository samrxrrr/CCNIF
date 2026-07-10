import pandas as pd
import matplotlib.pyplot as plt

plt.rcParams["figure.figsize"]=(8,5)

df=pd.read_csv(
"validation/results/biological/Biological_Benchmark_Summary.tsv",
sep="\t"
)

plt.bar(df.Database,df.CoveragePercent)

plt.ylabel("Coverage (%)")
plt.xlabel("Reference Database")
plt.title("Figure 8. External Biological Validation")

plt.tight_layout()

plt.savefig(
"validation/figures/Figure8_Biological_Validation.png",
dpi=600
)

print("Figure8 complete")
