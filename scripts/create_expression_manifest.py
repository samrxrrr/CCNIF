import json
from pathlib import Path
import pandas as pd

metadata_file = Path("data/raw/TCGA-LUAD/metadata/expression_manifest.json")
cohort_file = Path("data/raw/TCGA-LUAD/metadata/expression_cohort.csv")

with open(metadata_file) as f:
    metadata = json.load(f)

cohort = pd.read_csv(cohort_file)
selected_ids = set(cohort["file_id"])

rows = []

for hit in metadata["data"]["hits"]:
    if hit["file_id"] not in selected_ids:
        continue

    rows.append({
        "id": hit["file_id"],
        "filename": hit["file_name"],
        "md5": hit.get("md5sum", ""),
        "size": hit["file_size"],
        "state": hit.get("state", "live")
    })

manifest = pd.DataFrame(rows)

output = Path(
    "data/raw/TCGA-LUAD/metadata/expression_manifest_gdc.tsv"
)

manifest.to_csv(
    output,
    sep="\t",
    index=False
)

print(f"Manifest created: {output}")
print(f"Files: {len(manifest)}")
