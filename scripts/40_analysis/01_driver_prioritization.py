import gzip
import json
from pathlib import Path

import matplotlib.pyplot as plt
import pandas as pd

OUTDIR = Path("results/drivers")
FIGDIR = Path("figures/drivers")

OUTDIR.mkdir(parents=True, exist_ok=True)
FIGDIR.mkdir(parents=True, exist_ok=True)

print("Loading mutation frequencies...")

mutation = pd.read_csv(
    "data/processed/mutation/gene_mutation_frequency.tsv",
    sep="\t"
)

mutation = mutation.rename(columns={"Gene": "gene_name"})

print("Loading normalized expression...")

with gzip.open(
    "data/processed/normalized/expression_log2_cpm.tsv.gz",
    "rt"
) as f:
    expr = pd.read_csv(f, sep="\t")

expr["MeanExpression"] = expr.iloc[:, 3:].mean(axis=1)

expr = expr[
    ["gene_name", "MeanExpression"]
]

merged = mutation.merge(
    expr,
    on="gene_name",
    how="inner"
)

merged["MutationScore"] = (
    merged["Frequency"] /
    merged["Frequency"].max()
)

merged["ExpressionScore"] = (
    merged["MeanExpression"] /
    merged["MeanExpression"].max()
)

merged["DriverScore"] = (
    0.6 * merged["MutationScore"] +
    0.4 * merged["ExpressionScore"]
)

merged = merged.sort_values(
    "DriverScore",
    ascending=False
)

merged.to_csv(
    OUTDIR / "driver_scores.tsv",
    sep="\t",
    index=False
)

top50 = merged.head(50)

top50.to_csv(
    OUTDIR / "top50_drivers.tsv",
    sep="\t",
    index=False
)

plt.figure(figsize=(10,8))

plt.barh(
    top50["gene_name"],
    top50["DriverScore"]
)

plt.gca().invert_yaxis()

plt.xlabel("Driver Score")

plt.title("Top 50 Candidate Driver Genes")

plt.tight_layout()

plt.savefig(
    FIGDIR / "Driver_Ranking.png",
    dpi=300
)

summary = {
    "genes_ranked": int(len(merged)),
    "top_driver": str(top50.iloc[0]["gene_name"]),
    "top_score": round(float(top50.iloc[0]["DriverScore"]), 4)
}

with open(
    OUTDIR / "driver_summary.json",
    "w"
) as f:
    json.dump(summary, f, indent=4)

print(json.dumps(summary, indent=4))
print("Driver prioritization completed.")
