import json
from pathlib import Path

import pandas as pd

OUT = Path("data/processed/final")
OUT.mkdir(parents=True, exist_ok=True)

print("=" * 60)
print("Building harmonized clinical master")
print("=" * 60)

matched = pd.read_csv(
    "data/processed/final/matched_patients.tsv",
    sep="\t"
)

clinical = pd.read_csv(
    "data/processed/clinical/clinical_master.tsv",
    sep="\t"
)

clinical = clinical[
    clinical["patient_id"].isin(
        matched["patient_id"]
    )
].copy()

clinical = clinical.sort_values("patient_id")

clinical.to_csv(
    OUT / "clinical_master_matched.tsv",
    sep="\t",
    index=False
)

summary = {
    "matched_patients": int(len(clinical)),
    "missing_gender": int(clinical["gender"].isna().sum()),
    "missing_stage": int(clinical["tumor_stage"].isna().sum()),
    "missing_age": int(clinical["age_at_diagnosis"].isna().sum()),
    "missing_vital": int(clinical["vital_status"].isna().sum())
}

with open(
    OUT / "clinical_master_summary.json",
    "w"
) as f:
    json.dump(summary, f, indent=4)

print(json.dumps(summary, indent=4))
print("Done.")
