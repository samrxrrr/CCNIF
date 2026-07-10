import json
import requests

url = "https://api.gdc.cancer.gov/files"

fields = [
    "file_id",
    "file_name",
    "cases.submitter_id",
    "cases.samples.sample_type",
    "analysis.workflow_type",
    "data_type",
    "data_format",
    "file_size"
]

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
                "value": "Gene Expression Quantification"
            }
        }
    ]
}

params = {
    "filters": json.dumps(filters),
    "fields": ",".join(fields),
    "format": "JSON",
    "size": 10000
}

response = requests.get(url, params=params, timeout=60)
response.raise_for_status()

data = response.json()

print(f"Expression files found: {data['data']['pagination']['total']}")

with open(
    "data/raw/TCGA-LUAD/metadata/expression_manifest.json",
    "w"
) as handle:
    json.dump(data, handle, indent=4)

print("Saved expression manifest.")
