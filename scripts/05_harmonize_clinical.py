import gzip
import json
import pandas as pd

print("Loading expression matrix...")

with gzip.open(
    "data/processed/expression/expression_matrix.tsv.gz",
    "rt"
) as f:
    expr = pd.read_csv(f, sep="\t", nrows=1)

expression_patients = set(expr.columns[3:])

print("Expression patients:", len(expression_patients))

clinical = pd.read_csv(
    "data/processed/clinical/clinical.tsv",
    sep="\t"
)

print("Clinical patients:", len(clinical))

clinical = clinical[
    clinical["patient_id"].isin(expression_patients)
].copy()

clinical = clinical.sort_values("patient_id")

clinical.to_csv(
    "data/processed/clinical/clinical_harmonized.tsv",
    sep="\t",
    index=False
)

summary = {
    "expression_patients": len(expression_patients),
    "clinical_before": 585,
    "clinical_after": int(clinical.shape[0]),
    "matched": int(clinical.shape[0])
}

with open(
    "data/processed/clinical/harmonization_summary.json",
    "w"
) as f:
    json.dump(summary, f, indent=4)

print(summary)
print("Clinical harmonization completed.")
