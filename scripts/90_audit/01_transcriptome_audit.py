import gzip
import json
from pathlib import Path

import pandas as pd

report = {}

print("=" * 70)
print("CCNIF TRANSCRIPTOME FORENSIC AUDIT")
print("=" * 70)

# --------------------------------------------------
# expression_matched
# --------------------------------------------------

with gzip.open(
    "data/processed/final/expression_matched.tsv.gz",
    "rt"
) as f:
    expr = pd.read_csv(f, sep="\t", nrows=5)

expr_full = pd.read_csv(
    "data/processed/final/expression_matched.tsv.gz",
    sep="\t",
    compression="gzip",
    usecols=["gene_id", "gene_name", "gene_type"]
)

report["expression_matched_rows"] = len(expr_full)
report["expression_matched_unique_gene_id"] = expr_full["gene_id"].nunique()
report["expression_matched_unique_gene_name"] = expr_full["gene_name"].nunique()

print("\nExpression matched")
print(report["expression_matched_rows"])
print(expr_full.head())

# --------------------------------------------------
# normalized
# --------------------------------------------------

norm = pd.read_csv(
    "data/processed/normalized/expression_log2_cpm.tsv.gz",
    sep="\t",
    compression="gzip",
    usecols=["gene_id", "gene_name", "gene_type"]
)

report["normalized_rows"] = len(norm)
report["normalized_unique_gene_id"] = norm["gene_id"].nunique()

print("\nNormalized")
print(report["normalized_rows"])

# --------------------------------------------------
# DESeq counts
# --------------------------------------------------

counts = pd.read_csv(
    "data/processed/deseq/counts.tsv",
    sep="\t",
    nrows=5
)

counts_header = pd.read_csv(
    "data/processed/deseq/counts.tsv",
    sep="\t",
    usecols=["gene_id", "gene_name", "gene_type"]
)

report["deseq_counts_rows"] = len(counts_header)
report["deseq_unique_gene_id"] = counts_header["gene_id"].nunique()

print("\nDESeq counts")
print(report["deseq_counts_rows"])
print(counts_header.head())

# --------------------------------------------------
# DEG table
# --------------------------------------------------

deg = pd.read_csv(
    "results/evidence/TP53/transcriptomics/DEGs.tsv",
    sep="\t"
)

report["deg_rows"] = len(deg)
report["deg_unique_gene_id"] = deg["gene_id"].nunique()

print("\nDEGs")
print(report["deg_rows"])
print(deg.head())

# --------------------------------------------------
# Compare identifiers
# --------------------------------------------------

print("\nGene ID examples")

print("Expression:")
print(expr_full["gene_id"].head().tolist())

print("Normalized:")
print(norm["gene_id"].head().tolist())

print("Counts:")
print(counts_header["gene_id"].head().tolist())

print("DEGs:")
print(deg["gene_id"].head().tolist())

Path("results/audit").mkdir(parents=True, exist_ok=True)

with open(
    "results/audit/transcriptome_audit.json",
    "w"
) as f:
    json.dump(report, f, indent=4)

print("\nAudit completed.")
