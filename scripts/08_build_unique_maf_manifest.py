import pandas as pd
import requests
import json
from pathlib import Path

URL = "https://api.gdc.cancer.gov/files"

print("Loading expression patients...")

expr_cols = pd.read_csv(
    "data/processed/expression/sample_metadata.tsv",
    sep="\t"
)["patient_id"].tolist()

patients = set(expr_cols)

print(f"Expression cohort: {len(patients)} patients")

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

fields = [
    "file_id",
    "file_name",
    "created_datetime",
    "cases.submitter_id"
]

records = []

page = 0
size = 100

while True:

    params = {
        "filters": json.dumps(filters),
        "fields": ",".join(fields),
        "format": "JSON",
        "size": size,
        "from": page * size
    }

    r = requests.get(URL, params=params)
    r.raise_for_status()

    hits = r.json()["data"]["hits"]

    if len(hits) == 0:
        break

    for hit in hits:

        if not hit.get("cases"):
            continue

        patient = hit["cases"][0]["submitter_id"]

        if patient not in patients:
            continue

        records.append({
            "patient_id": patient,
            "file_id": hit["file_id"],
            "file_name": hit["file_name"],
            "created": hit.get("created_datetime")
        })

    page += 1

maf = pd.DataFrame(records)

maf["created"] = pd.to_datetime(maf["created"])

maf = maf.sort_values("created")

maf = maf.drop_duplicates(
    subset="patient_id",
    keep="last"
)

maf = maf.sort_values("patient_id")

manifest = maf[["file_id"]].copy()
manifest["filename"] = maf["file_name"]

Path("data/raw/TCGA-LUAD/metadata").mkdir(
    parents=True,
    exist_ok=True
)

manifest.to_csv(
    "data/raw/TCGA-LUAD/metadata/mutation_manifest_unique.tsv",
    sep="\t",
    index=False
)

print("\n====================================")
print("Unique patient manifest completed")
print("====================================")
print(f"Unique patients : {len(maf)}")
print(f"Duplicate files removed : {len(records)-len(maf)}")
