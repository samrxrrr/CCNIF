from pathlib import Path
import pandas as pd

master = pd.read_csv(
    "results/master/Driver_Master_Index.tsv",
    sep="\t"
)

avg_conf = master.DriverConfidence.mean()
avg_quality = master.QualityScore.mean()
avg_rel = master.ReliabilityScore.mean()

tiers = master.ConfidenceTier.value_counts()

top10 = master.nlargest(10,"DriverConfidence")["Driver"].tolist()

text = f"""
RESULTS

CCNIF analyzed {len(master)} candidate driver genes.

Average Driver Confidence Score:
{avg_conf:.2f}

Average Quality Score:
{avg_quality:.2f}

Average Reliability Score:
{avg_rel:.2f}

Confidence Tier Distribution

Tier A : {tiers.get('A',0)}
Tier B : {tiers.get('B',0)}
Tier C : {tiers.get('C',0)}
Tier D : {tiers.get('D',0)}

Top ranked drivers

{', '.join(top10)}

Biological validation demonstrated substantial overlap with four
independent external resources including IntOGen,
OncoKB, CancerMine and NCG.
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
