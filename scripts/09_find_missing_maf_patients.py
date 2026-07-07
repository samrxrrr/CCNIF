import pandas as pd

expr = pd.read_csv(
    "data/processed/expression/sample_metadata.tsv",
    sep="\t"
)

maf = pd.read_csv(
    "data/raw/TCGA-LUAD/metadata/mutation_manifest_unique.tsv",
    sep="\t"
)

# Reload patient mapping from API metadata
import requests
import json

URL = "https://api.gdc.cancer.gov/files"

filters = {
    "op": "and",
    "content": [
        {
            "op": "=",
            "content": {
                "field": "cases.project.project_id",
                "value": "TCGA-LUAD"
            }
        },
        {
            "op": "=",
            "content": {
                "field": "data_type",
                "value": "Masked Somatic Mutation"
            }
        }
    ]
}

params = {
    "filters": json.dumps(filters),
    "fields": "file_id,cases.submitter_id",
    "format": "JSON",
    "size": 2000
}

hits = requests.get(URL, params=params).json()["data"]["hits"]

maf_patients = set()

for h in hits:
    if h.get("cases"):
        maf_patients.add(h["cases"][0]["submitter_id"])

expr_patients = set(expr["patient_id"])

missing = sorted(expr_patients - maf_patients)

print("\nMissing patients:", len(missing))
print("--------------------------------")

for p in missing:
    print(p)

pd.DataFrame({"patient_id": missing}).to_csv(
    "results/missing_maf_patients.csv",
    index=False
)

print("\nSaved: results/missing_maf_patients.csv")
