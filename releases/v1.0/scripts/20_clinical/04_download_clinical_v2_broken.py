import json
import requests
import pandas as pd
from pathlib import Path

OUTDIR = Path("data/processed/clinical")
OUTDIR.mkdir(parents=True, exist_ok=True)

FIELDS = [
    "submitter_id",
    "demographic.gender",
    "demographic.race",
    "demographic.ethnicity",
    "diagnoses.age_at_diagnosis",
    "diagnoses.tumor_stage",
    "diagnoses.tumor_grade",
    "diagnoses.primary_diagnosis",
    "diagnoses.vital_status",
    "diagnoses.days_to_death",
    "diagnoses.days_to_last_follow_up"
]

payload = {
    "filters": {
        "op": "=",
        "content": {
            "field": "project.project_id",
            "value": "TCGA-LUAD"
        }
    },
    "format": "JSON",
    "size": 1000,
    "fields": ",".join(FIELDS)
}

print("Downloading TCGA-LUAD clinical metadata...")

response = requests.post(
    "https://api.gdc.cancer.gov/cases",
    json=payload,
    timeout=300
)

response.raise_for_status()

hits = response.json()["data"]["hits"]

records = []

for case in hits:

    demographic = case.get("demographic", {})

    diagnoses = {}

    if case.get("diagnoses"):
        diagnoses = case["diagnoses"][0]

    records.append({

        "patient_id":
            case.get("submitter_id"),

        "gender":
            demographic.get("gender"),

        "race":
            demographic.get("race"),

        "ethnicity":
            demographic.get("ethnicity"),

        "age_at_diagnosis":
            diagnoses.get("age_at_diagnosis"),

        "tumor_stage":
            diagnoses.get("tumor_stage"),

        "tumor_grade":
            diagnoses.get("tumor_grade"),

        "primary_diagnosis":
            diagnoses.get("primary_diagnosis"),

        "vital_status":
            diagnoses.get("vital_status"),

        "days_to_death":
            diagnoses.get("days_to_death"),

        "days_to_last_follow_up":
            diagnoses.get("days_to_last_follow_up")

    })

clinical = pd.DataFrame(records)

clinical = clinical.sort_values("patient_id")

clinical.to_csv(
    OUTDIR / "clinical_v2.tsv",
    sep="\t",
    index=False
)

summary = {
    "patients": int(len(clinical)),
    "variables": int(len(clinical.columns))
}

with open(
    OUTDIR / "clinical_v2_summary.json",
    "w"
) as f:
    json.dump(summary, f, indent=4)

print("=" * 60)
print("Clinical reconstruction completed")
print("=" * 60)
print(json.dumps(summary, indent=4))
