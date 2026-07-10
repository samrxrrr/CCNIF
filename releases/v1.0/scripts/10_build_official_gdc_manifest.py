import pandas as pd
import requests
from pathlib import Path

print("Loading unique MAF file IDs...")

unique = pd.read_csv(
    "data/raw/TCGA-LUAD/metadata/mutation_manifest_unique.tsv",
    sep="\t"
)

file_ids = unique["file_id"].tolist()

print(f"Preparing manifest for {len(file_ids)} files")

url = "https://api.gdc.cancer.gov/manifest"

response = requests.post(
    url,
    json={"ids": file_ids}
)

response.raise_for_status()

Path("data/raw/TCGA-LUAD/metadata").mkdir(
    parents=True,
    exist_ok=True
)

manifest_path = "data/raw/TCGA-LUAD/metadata/mutation_manifest_official.tsv"

with open(manifest_path, "wb") as f:
    f.write(response.content)

print("\nOfficial manifest saved:")
print(manifest_path)
