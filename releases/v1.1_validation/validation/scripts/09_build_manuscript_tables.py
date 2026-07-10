import pandas as pd
from pathlib import Path

Path("validation/tables").mkdir(parents=True, exist_ok=True)

df = pd.read_csv(
    "results/master/Driver_Master_Index.tsv",
    sep="\t"
)

###############################################################################
# TABLE 1
###############################################################################

table1 = (
    df.sort_values("DriverConfidence", ascending=False)
      [["Rank","Driver","DriverConfidence",
        "ConfidenceTier","QualityScore","QualityTier"]]
)

table1.to_csv(
    "validation/tables/Table1_Top50_Drivers.tsv",
    sep="\t",
    index=False
)

###############################################################################
# TABLE 2
###############################################################################

table2 = (
    df.groupby("ConfidenceTier")
      .size()
      .reset_index(name="Drivers")
      .sort_values("ConfidenceTier")
)

table2.to_csv(
    "validation/tables/Table2_Confidence_Tiers.tsv",
    sep="\t",
    index=False
)

###############################################################################
# TABLE 3
###############################################################################

table3 = (
    df.groupby("QualityTier")
      .size()
      .reset_index(name="Drivers")
      .sort_values("QualityTier")
)

table3.to_csv(
    "validation/tables/Table3_Quality_Tiers.tsv",
    sep="\t",
    index=False
)

###############################################################################
# TABLE 4
###############################################################################

summary = pd.DataFrame([{
    "Drivers": len(df),
    "AverageConfidence": round(df.DriverConfidence.mean(),3),
    "AverageQuality": round(df.QualityScore.mean(),3),
    "AverageReliability": round(df.ReliabilityScore.mean(),3),
    "TierA": (df.ConfidenceTier=="A").sum(),
    "TierB": (df.ConfidenceTier=="B").sum(),
    "TierC": (df.ConfidenceTier=="C").sum(),
    "TierD": (df.ConfidenceTier=="D").sum()
}])

summary.to_csv(
    "validation/tables/Table4_Framework_Summary.tsv",
    sep="\t",
    index=False
)

print("Tables generated successfully.")
