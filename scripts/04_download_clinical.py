import json
from pathlib import Path

import pandas as pd
import requests

URL = "https://api.gdc.cancer.gov/cases"

FIELDS = [
    "submitter_id",
    "diagnoses.vital_status",
    "diagnoses.days_to_death",
    "diagnoses.days_to_last_follow_up",
    "diagnoses.age_at_diagnosis",
    "diagnoses.tumor_stage",
    "diagnoses.tumor_grade",
    "diagnoses.primary_diagnosis",
    "demographic.gender",
    "demographic.race",
    "demographic.ethnicity"
]

filters = {
    "op": "=",
    "content": {
        "field": "project.project_id",
        "value": "TCGA-LUAD"
    }
}

params = {
    "filters": json.dumps(filters),
    "fields": ",".join(FIELDS),
    "format": "JSON",
    "size": 1000
}

print("Downloading clinical data...")

response = requests.get(URL, params=params)
response.raise_for_status()

data = response.json()["data"]["hits"]

rows = []

for case in data:

    diagnosis = case["diagnoses"][0] if case.get("diagnoses") else {}
    demographic = case.get("demographic", {})

    rows.append({
        "patient_id": case.get("submitter_id"),

        "gender": demographic.get("gender"),
        "race": demographic.get("race"),
        "ethnicity": demographic.get("ethnicity"),

        "age_at_diagnosis": diagnosis.get("age_at_diagnosis"),

        "tumor_stage": diagnosis.get("tumor_stage"),
        "tumor_grade": diagnosis.get("tumor_grade"),

        "primary_diagnosis": diagnosis.get("primary_diagnosis"),

        "vital_status": diagnosis.get("vital_status"),

        "days_to_death": diagnosis.get("days_to_death"),

        "days_to_last_follow_up":
            diagnosis.get("days_to_last_follow_up")
    })

clinical = pd.DataFrame(rows)

clinical = clinical.sort_values("patient_id")

clinical.to_csv(
    "data/processed/clinical/clinical.tsv",
    sep="\t",
    index=False
)

summary = {
    "patients": int(clinical.shape[0]),
    "variables": int(clinical.shape[1])
}

with open(
    "data/processed/clinical/clinical_summary.json",
    "w"
) as f:
    json.dump(summary, f, indent=4)

print(summary)
print("Clinical download completed.")
