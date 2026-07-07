from pathlib import Path
import gzip
import json

import matplotlib.pyplot as plt
import pandas as pd

# -----------------------------
# Input / Output
# -----------------------------
INPUT = Path("data/processed/expression/expression_matrix.tsv.gz")

RESULTS_DIR = Path("results/expression_qc")
FIGURES_DIR = Path("figures/expression_qc")

RESULTS_DIR.mkdir(parents=True, exist_ok=True)
FIGURES_DIR.mkdir(parents=True, exist_ok=True)

print("Loading expression matrix...")

with gzip.open(INPUT, "rt") as f:
    df = pd.read_csv(f, sep="\t")

# Expression counts start after:
# gene_id
# gene_name
# gene_type
expr = df.iloc[:, 3:]

report = {}

print("Running quality control...")

report["genes"] = int(expr.shape[0])
report["samples"] = int(expr.shape[1])

report["missing_values"] = int(expr.isna().sum().sum())

report["duplicate_gene_ids"] = int(
    df["gene_id"].duplicated().sum()
)

report["negative_values"] = int(
    (expr < 0).sum().sum()
)

library_sizes = expr.sum(axis=0)

report["library_size_min"] = int(library_sizes.min())
report["library_size_max"] = int(library_sizes.max())
report["library_size_mean"] = float(library_sizes.mean())
report["library_size_median"] = float(library_sizes.median())

plt.figure(figsize=(10,6))

plt.hist(
    library_sizes,
    bins=40
)

plt.xlabel("Total Counts per Sample")
plt.ylabel("Number of Samples")
plt.title("CCNIF: Library Size Distribution")

plt.tight_layout()

plt.savefig(
    FIGURES_DIR / "library_size_distribution.png",
    dpi=300
)

plt.close()

with open(
    RESULTS_DIR / "qc_report.json",
    "w"
) as f:
    json.dump(report, f, indent=4)

print("\n========== QC SUMMARY ==========")

for key, value in report.items():
    print(f"{key}: {value}")

print("\nQC completed successfully.")
