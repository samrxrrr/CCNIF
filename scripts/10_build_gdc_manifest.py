import json
import requests
import pandas as pd
from pathlib import Path

print("Loading unique MAF patients...")

unique = pd.read_csv(
    "data/raw/TCGA-LUAD/metadata/mutation_manifest_unique.tsv",
    sep="\t"
)

file_ids = unique["file_id"].tolist()

URL = "https://api.gdc.cancer.gov/files"

filters = {
    "op": "in",
    "content": {
        "field": "file_id",
        "value": file_ids
    }
}

params = {
    "filters": json.dumps(filters),
    "format": "TSV",
    "size": 2000,
    "fields": "file_id,file_name,file_size,md5sum,state"
}

print("Downloading official GDC manifest...")

response = requests.get(URL, params=params)
response.raise_for_status()

Path("data/raw/TCGA-LUAD/metadata").mkdir(
    parents=True,
    exist_ok=True
)

with open(
    "data/raw/TCGA-LUAD/metadata/mutation_manifest_gdc.tsv",
    "wb"
) as f:
    f.write(response.content)

print("Official GDC manifest saved.")
