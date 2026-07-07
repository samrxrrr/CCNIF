import json
from pathlib import Path

import pandas as pd
import requests

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
    "file_size",
    "analysis.workflow_type",
    "cases.submitter_id"
]

records = []

from_index = 0
page_size = 100

print("Querying GDC...")

while True:

    params = {
        "filters": json.dumps(filters),
        "fields": ",".join(FIELDS),
        "format": "JSON",
        "size": page_size,
        "from": from_index
    }

    response = requests.get(URL, params=params)
    response.raise_for_status()

    payload = response.json()["data"]

    hits = payload["hits"]

    if len(hits) == 0:
        break

    for hit in hits:

        records.append({
            "file_id": hit["file_id"],
            "file_name": hit["file_name"],
            "file_size": hit["file_size"],
            "workflow": hit.get("analysis", {}).get("workflow_type"),
            "patient_count": len(hit.get("cases", []))
        })

    print(f"Downloaded metadata for {len(records)} files")

    from_index += page_size

manifest = pd.DataFrame(records)

manifest = manifest.drop_duplicates()

manifest = manifest.sort_values("file_name")

Path(
    "data/raw/TCGA-LUAD/metadata"
).mkdir(
    parents=True,
    exist_ok=True
)

manifest.to_csv(
    "data/raw/TCGA-LUAD/metadata/mutation_manifest.csv",
    index=False
)

print("\n===================================")
print("Mutation Manifest Completed")
print("===================================")

print(f"Files discovered : {len(manifest)}")

print(
    manifest.head()
)
