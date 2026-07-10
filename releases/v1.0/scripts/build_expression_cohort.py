import json
from pathlib import Path

import pandas as pd

manifest_file = Path(
    "data/raw/TCGA-LUAD/metadata/expression_manifest.json"
)

with open(manifest_file) as f:
    manifest = json.load(f)

rows = []

for hit in manifest["data"]["hits"]:

    case = hit["cases"][0]

    sample = case["samples"][0]

    rows.append({
        "patient_id": case["submitter_id"],
        "sample_type": sample["sample_type"],
        "workflow": hit["analysis"]["workflow_type"],
        "file_id": hit["file_id"],
        "file_name": hit["file_name"],
        "file_size": hit["file_size"]
    })

df = pd.DataFrame(rows)

print("=" * 60)
print("Original files:", len(df))

df = df[df["workflow"] == "STAR - Counts"]

print("STAR Counts:", len(df))

df = df[df["sample_type"] == "Primary Tumor"]

print("Primary Tumor:", len(df))

df = df.drop_duplicates(subset="patient_id")

print("Unique Patients:", len(df))

output = Path("data/raw/TCGA-LUAD/metadata")
output.mkdir(parents=True, exist_ok=True)

df.to_csv(
    output / "expression_cohort.csv",
    index=False
)

print()
print("Saved expression_cohort.csv")
