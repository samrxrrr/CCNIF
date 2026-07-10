from pathlib import Path
import pandas as pd

master = pd.read_csv(
    "results/master/Driver_Master_Index.tsv",
    sep="\t"
)

processed = Path("validation/reference/processed")

dbs = {
    "OncoKB":"OncoKB_Genes.tsv",
    "CancerMine":"CancerMine_Genes.tsv",
    "NCG":"NCG_Genes.tsv"
}

for db,f in dbs.items():

    genes = set(
        pd.read_csv(processed/f,sep="\t")["Gene"]
        .astype(str)
        .str.upper()
    )

    master[db] = master.Driver.str.upper().isin(genes)

master["EvidenceCount"] = (
    master["OncoKB"].astype(int) +
    master["CancerMine"].astype(int) +
    master["NCG"].astype(int)
)

master = master.sort_values(
    ["EvidenceCount","DriverConfidence"],
    ascending=[False,False]
)

Path("validation/results/reports").mkdir(
    parents=True,
    exist_ok=True
)

master.to_csv(
    "validation/results/reports/Integrated_Benchmark.tsv",
    sep="\t",
    index=False
)

print(
    master[
        [
            "Rank",
            "Driver",
            "DriverConfidence",
            "EvidenceCount",
            "OncoKB",
            "CancerMine",
            "NCG"
        ]
    ].head(30)
)
