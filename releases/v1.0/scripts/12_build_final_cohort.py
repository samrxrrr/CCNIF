import gzip
import json
from pathlib import Path

import pandas as pd

OUTDIR = Path("data/processed/final")
OUTDIR.mkdir(parents=True, exist_ok=True)

print("=" * 60)
print("Loading datasets...")
print("=" * 60)

# -------------------------
# Expression
# -------------------------

with gzip.open(
    "data/processed/expression/expression_matrix.tsv.gz",
    "rt"
) as f:
    expr = pd.read_csv(f, sep="\t")

expr_patients = set(expr.columns[3:])

# -------------------------
# Clinical
# -------------------------

clinical = pd.read_csv(
    "data/processed/clinical/clinical_harmonized.tsv",
    sep="\t"
)

clinical_patients = set(clinical["patient_id"])

# -------------------------
# Mutation
# -------------------------

mutation = pd.read_csv(
    "data/processed/mutation/mutation_matrix.tsv",
    sep="\t",
    index_col=0
)

mutation_patients = set(mutation.index)

# -------------------------
# Intersection
# -------------------------

matched = sorted(
    expr_patients &
    clinical_patients &
    mutation_patients
)

print(f"Matched patients: {len(matched)}")

# -------------------------
# Save patient list
# -------------------------

pd.DataFrame(
    {"patient_id": matched}
).to_csv(
    OUTDIR / "matched_patients.tsv",
    sep="\t",
    index=False
)

# -------------------------
# Expression
# -------------------------

expr_matched = expr[
    ["gene_id", "gene_name", "gene_type"] + matched
]

with gzip.open(
    OUTDIR / "expression_matched.tsv.gz",
    "wt"
) as f:
    expr_matched.to_csv(
        f,
        sep="\t",
        index=False
    )

# -------------------------
# Clinical
# -------------------------

clinical_matched = clinical[
    clinical["patient_id"].isin(matched)
].copy()

clinical_matched.to_csv(
    OUTDIR / "clinical_matched.tsv",
    sep="\t",
    index=False
)

# -------------------------
# Mutation
# -------------------------

mutation_matched = mutation.loc[matched]

mutation_matched.to_csv(
    OUTDIR / "mutation_matrix_matched.tsv",
    sep="\t"
)

# -------------------------
# Summary
# -------------------------

summary = {
    "matched_patients": len(matched),
    "genes_expression": int(expr.shape[0]),
    "genes_mutation": int(mutation.shape[1]),
    "clinical_variables": int(clinical.shape[1])
}

with open(
    OUTDIR / "cohort_summary.json",
    "w"
) as f:
    json.dump(summary, f, indent=4)

analysis_manifest = {
    "cohort": "TCGA-LUAD",
    "patients": len(matched),
    "expression": "expression_matched.tsv.gz",
    "clinical": "clinical_matched.tsv",
    "mutation": "mutation_matrix_matched.tsv"
}

with open(
    OUTDIR / "analysis_manifest.json",
    "w"
) as f:
    json.dump(analysis_manifest, f, indent=4)

print("\n" + "=" * 60)
print("Final CCNIF Cohort Created")
print("=" * 60)
print(json.dumps(summary, indent=4))
