from pathlib import Path
import pandas as pd

ROOT = Path("validation")
MASTER = ROOT/"reference"/"Benchmark_Table.tsv"
REFDIR = ROOT/"reference"/"processed"
OUT = ROOT/"results"/"benchmark"

OUT.mkdir(parents=True, exist_ok=True)

master = pd.read_csv(MASTER, sep="\t")

refs = {
    "CGC":"CGC_Genes.tsv",
    "NCG":"NCG_Genes.tsv",
    "IntOGen":"IntOGen_Genes.tsv",
    "OncoKB":"OncoKB_Genes.tsv",
    "CancerMine":"CancerMine_Genes.tsv"
}

for db,f in refs.items():

    p = REFDIR/f

    if not p.exists():
        print(f"Skipping {db} (missing)")
        continue

    genes = set(
        pd.read_csv(p,sep="\t")["Gene"]
        .astype(str)
        .str.upper()
    )

    master[db] = master["Driver"].str.upper().isin(genes)

master["Validated"] = (
    master[
        ["CGC","NCG","IntOGen","OncoKB","CancerMine"]
    ]
    .sum(axis=1)>0
)

master.to_csv(
    OUT/"Benchmark_Results.tsv",
    sep="\t",
    index=False
)

print(master.head())
print()
print("Drivers:",len(master))
print("Validated:",master["Validated"].sum())
