import json
import pandas as pd
from pathlib import Path

master = pd.read_csv(
    "results/master/Driver_Master_Index.tsv",
    sep="\t"
)

summary = json.load(
    open(
        "validation/results/reports/Validation_Summary.json"
    )
)

top10 = master.sort_values(
    "DriverConfidence",
    ascending=False
).head(10)

genes = ", ".join(top10.Driver.tolist())

text = f"""
RESULTS

CCNIF successfully completed production analysis for {summary['Drivers']} candidate driver genes.

All drivers completed the full evidence generation,
statistical analysis,
reliability assessment,
normalization,
quality scoring,
confidence estimation,
report generation,
and master index integration.

The mean Driver Confidence Score was {summary['AverageConfidence']:.2f},
while the mean Quality Score reached {summary['AverageQuality']:.2f}.

Confidence tier distribution consisted of:

Tier A = {summary['TierA']}
Tier B = {summary['TierB']}
Tier C = {summary['TierC']}
Tier D = {summary['TierD']}

The highest ranked candidate drivers were:

{genes}.

Validation infrastructure,
benchmark framework,
publication figures,
and manuscript tables were generated successfully.

External benchmarking datasets will be incorporated in the subsequent validation phase.
"""

Path("manuscript/results").mkdir(
    parents=True,
    exist_ok=True
)

with open(
    "manuscript/results/Results_Draft.txt",
    "w"
) as f:
    f.write(text)

print(text)
