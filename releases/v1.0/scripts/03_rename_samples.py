import gzip
import pandas as pd
from pathlib import Path

print("Loading expression matrix...")

with gzip.open(
    "data/processed/expression/expression_matrix.tsv.gz",
    "rt"
) as f:
    expr = pd.read_csv(f, sep="\t")

print("Loading cohort metadata...")

cohort = pd.read_csv(
    "data/raw/TCGA-LUAD/metadata/expression_cohort.csv"
)

# ------------------------------------
# Build UUID -> TCGA barcode mapping
# ------------------------------------

mapping = dict(
    zip(
        cohort["file_id"],
        cohort["patient_id"]
    )
)

old_columns = expr.columns.tolist()

new_columns = []

for col in old_columns:

    if col in ["gene_id", "gene_name", "gene_type"]:
        new_columns.append(col)
    else:
        new_columns.append(mapping.get(col, col))

expr.columns = new_columns

print("Saving renamed matrix...")

with gzip.open(
    "data/processed/expression/expression_matrix.tsv.gz",
    "wt"
) as f:
    expr.to_csv(
        f,
        sep="\t",
        index=False
    )

sample_metadata = pd.DataFrame({
    "sample_id": new_columns[3:]
})

sample_metadata.to_csv(
    "data/processed/expression/sample_metadata.tsv",
    sep="\t",
    index=False
)

print("\nCompleted.")
print("Samples renamed:", len(new_columns) - 3)

missing = [c for c in new_columns[3:] if c.startswith("ENSG")]

print("Done.")
