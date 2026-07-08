import gzip
import json
from pathlib import Path

import numpy as np
import pandas as pd

OUTDIR = Path("data/processed/normalized")
OUTDIR.mkdir(parents=True, exist_ok=True)

print("=" * 60)
print("Loading matched expression matrix...")
print("=" * 60)

with gzip.open(
    "data/processed/final/expression_matched.tsv.gz",
    "rt"
) as f:
    expr = pd.read_csv(f, sep="\t")

annotation = expr.iloc[:, :3].copy()
counts = expr.iloc[:, 3:].copy()

print(f"Genes: {counts.shape[0]}")
print(f"Patients: {counts.shape[1]}")

# -------------------------------------------------
# Filter low-expression genes
# Keep genes with CPM > 1 in at least 20% of samples
# -------------------------------------------------

library_sizes = counts.sum(axis=0)

cpm = counts.div(library_sizes, axis=1) * 1_000_000

min_samples = int(0.20 * counts.shape[1])

mask = (cpm > 1).sum(axis=1) >= min_samples

annotation = annotation.loc[mask].reset_index(drop=True)
counts = counts.loc[mask].reset_index(drop=True)

print(f"Genes after filtering: {counts.shape[0]}")

# -------------------------------------------------
# Recalculate CPM
# -------------------------------------------------

library_sizes = counts.sum(axis=0)

cpm = counts.div(library_sizes, axis=1) * 1_000_000

# -------------------------------------------------
# Log2 transform
# -------------------------------------------------

log2_cpm = np.log2(cpm + 1)

normalized = pd.concat(
    [annotation, log2_cpm],
    axis=1
)

with gzip.open(
    OUTDIR / "expression_log2_cpm.tsv.gz",
    "wt"
) as f:
    normalized.to_csv(
        f,
        sep="\t",
        index=False
    )

annotation.to_csv(
    OUTDIR / "expressed_genes.tsv",
    sep="\t",
    index=False
)

summary = {
    "patients": int(log2_cpm.shape[1]),
    "genes_before": int(expr.shape[0]),
    "genes_after": int(log2_cpm.shape[0]),
    "filter": "CPM > 1 in >=20% samples",
    "transformation": "log2(CPM+1)"
}

with open(
    OUTDIR / "normalization_summary.json",
    "w"
) as f:
    json.dump(summary, f, indent=4)

print("\nNormalization completed.")
print(json.dumps(summary, indent=4))
