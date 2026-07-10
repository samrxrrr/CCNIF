import json
from pathlib import Path

import pandas as pd
import requests

OUT = Path("data/processed/clinical")
OUT.mkdir(parents=True, exist_ok=True)

payload = {
    "filters": {
        "op": "=",
        "content": {
            "field": "project.project_id",
            "value": "TCGA-LUAD"
        }
    },
    "expand": "demographic,diagnoses",
    "format": "JSON",
    "size": 1000
}

print("Downloading TCGA-LUAD clinical metadata...")

r = requests.post(
    "https://api.gdc.cancer.gov/cases",
    json=payload,
    timeout=300
)

r.raise_for_status()

hits = r.json()["data"]["hits"]

records = []

for case in hits:

    demo = case.get("demographic", {})

    diag = {}

    if case.get("diagnoses"):

        primary = None

        for d in case["diagnoses"]:
            if d.get("diagnosis_is_primary_disease", False):
                primary = d
                break

        if primary is None:
            primary = case["diagnoses"][0]

        diag = primary

    records.append({

        "patient_id":
            case.get("submitter_id"),

        "gender":
            demo.get("sex_at_birth"),

        "race":
            demo.get("race"),

        "ethnicity":
            demo.get("ethnicity"),

        "vital_status":
            demo.get("vital_status"),

        "age_at_index":
            demo.get("age_at_index"),

        "age_at_diagnosis":
            diag.get("age_at_diagnosis"),

        "tumor_stage":
            diag.get("ajcc_pathologic_stage"),

        "tumor_T":
            diag.get("ajcc_pathologic_t"),

        "tumor_N":
            diag.get("ajcc_pathologic_n"),

        "tumor_M":
            diag.get("ajcc_pathologic_m"),

        "tumor_grade":
            diag.get("tumor_grade"),

        "primary_diagnosis":
            diag.get("primary_diagnosis"),

        "days_to_death":
            diag.get("days_to_death"),

        "days_to_last_follow_up":
            diag.get("days_to_last_follow_up")

    })

clinical = pd.DataFrame(records)

clinical = clinical.sort_values("patient_id")

clinical.to_csv(
    OUT / "clinical_master.tsv",
    sep="\t",
    index=False
)

summary = {
    "patients": int(len(clinical)),
    "variables": int(len(clinical.columns))
}

with open(
    OUT / "clinical_master_summary.json",
    "w"
) as f:
    json.dump(summary, f, indent=4)

print("="*60)
print("Clinical Master Built")
print("="*60)
print(json.dumps(summary, indent=4))
