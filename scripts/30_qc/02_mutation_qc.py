import json
from pathlib import Path

import matplotlib.pyplot as plt
import pandas as pd

FIGDIR = Path("figures/qc")
OUTDIR = Path("results/qc")

FIGDIR.mkdir(parents=True, exist_ok=True)
OUTDIR.mkdir(parents=True, exist_ok=True)

# -----------------------------
# Tumor mutation burden
# -----------------------------

tmb = pd.read_csv(
    "data/processed/mutation/tumor_mutation_burden.tsv",
    sep="\t"
)

plt.figure(figsize=(8,5))

plt.hist(
    tmb["Mutation_Count"],
    bins=30
)

plt.xlabel("Mutations per patient")
plt.ylabel("Patients")
plt.title("Tumor Mutation Burden")

plt.tight_layout()

plt.savefig(
    FIGDIR / "Mutation_Burden.png",
    dpi=300
)

# -----------------------------
# Top mutated genes
# -----------------------------

genes = pd.read_csv(
    "data/processed/mutation/gene_mutation_frequency.tsv",
    sep="\t"
)

top20 = genes.head(20)

plt.figure(figsize=(10,7))

plt.barh(
    top20["Gene"],
    top20["Mutated_Patients"]
)

plt.gca().invert_yaxis()

plt.xlabel("Mutated Patients")

plt.title("Top 20 Mutated Genes")

plt.tight_layout()

plt.savefig(
    FIGDIR / "Top20_Mutated_Genes.png",
    dpi=300
)

# -----------------------------
# Variant classification
# -----------------------------

variant = pd.read_csv(
    "data/processed/mutation/variant_classification.tsv",
    sep="\t"
)

plt.figure(figsize=(8,5))

plt.bar(
    variant["Variant_Classification"],
    variant["Count"]
)

plt.xticks(rotation=45, ha="right")

plt.ylabel("Count")

plt.title("Variant Classification")

plt.tight_layout()

plt.savefig(
    FIGDIR / "Variant_Classification.png",
    dpi=300
)

summary = {
    "patients": int(len(tmb)),
    "median_mutation_burden": int(tmb["Mutation_Count"].median()),
    "mean_mutation_burden": round(
        float(tmb["Mutation_Count"].mean()),
        2
    ),
    "top_gene": str(top20.iloc[0]["Gene"])
}

with open(
    OUTDIR / "mutation_qc.json",
    "w"
) as f:
    json.dump(summary, f, indent=4)

print(json.dumps(summary, indent=4))
print("Mutation QC completed.")
