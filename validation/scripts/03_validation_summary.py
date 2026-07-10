from pathlib import Path
import pandas as pd
import json

ROOT = Path("validation")
bench = ROOT/"results"/"benchmark"/"Benchmark_Results.tsv"

df = pd.read_csv(bench, sep="\t")

summary = {
    "Framework":"CCNIF",
    "Version":"1.1",
    "Drivers":int(len(df)),
    "Validated":int(df["Validated"].sum()),
    "ValidationRate":round(float(df["Validated"].mean()*100),2),
    "AverageConfidence":round(float(df["DriverConfidence"].mean()),4),
    "AverageQuality":round(float(df["QualityScore"].mean()),4),
    "TierA":int((df["ConfidenceTier"]=="A").sum()),
    "TierB":int((df["ConfidenceTier"]=="B").sum()),
    "TierC":int((df["ConfidenceTier"]=="C").sum()),
    "TierD":int((df["ConfidenceTier"]=="D").sum())
}

(Path("validation/results/reports")).mkdir(parents=True, exist_ok=True)

with open(
    "validation/results/reports/Validation_Summary.json",
    "w"
) as f:
    json.dump(summary,f,indent=4)

pd.DataFrame([summary]).to_csv(
    "validation/results/reports/Validation_Summary.tsv",
    sep="\t",
    index=False
)

print(json.dumps(summary,indent=4))
