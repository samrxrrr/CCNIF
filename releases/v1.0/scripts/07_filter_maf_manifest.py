import gzip
import json
import pandas as pd
import requests
from pathlib import Path

print("Loading expression cohort...")

with gzip.open(
    "data/processed/expression/expression_matrix.tsv.gz",
    "rt"
) as f:
    expr = pd.read_csv(f, sep="\t", nrows=1)

patients = set(expr.columns[3:])

print(f"Expression patients: {len(patients)}")

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

FIELDS = [
    "file_id",
    "file_name",
    "cases.submitter_id"
]

records = []

from_index = 0
page_size = 100

while True:

    params = {
        "filters": json.dumps(filters),
        "fields": ",".join(FIELDS),
        "format": "JSON",
        "size": page_size,
        "from": from_index
    }

    r = requests.get(URL, params=params)
    r.raise_for_status()

    hits = r.json()["data"]["hits"]

    if not hits:
        break

    for hit in hits:

        if len(hit.get("cases", [])) == 0:
            continue

        patient = hit["cases"][0]["submitter_id"]

        if patient in patients:

            records.append({
                "id": hit["file_id"],
                "filename": hit["file_name"]
            })

    from_index += page_size

manifest = pd.DataFrame(records)

manifest.to_csv(
    "data/raw/TCGA-LUAD/metadata/mutation_manifest_gdc.tsv",
    sep="\t",
    index=False
)

print()

print("===================================")
print("Filtered Manifest Completed")
print("===================================")

print(f"Files to download : {len(manifest)}")
