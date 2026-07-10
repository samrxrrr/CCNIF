from pathlib import Path
import pandas as pd

MASTER = Path("results/master/Driver_Master_Index.tsv")
REFDIR = Path("validation/reference/processed")
OUTDIR = Path("validation/results/biological")

OUTDIR.mkdir(parents=True, exist_ok=True)

master = pd.read_csv(MASTER, sep="\t")

databases = [
    "CGC",
    "IntOGen",
    "OncoKB",
    "CancerMine",
    "NCG"
]

summary = []

for db in databases:

    ref = REFDIR / f"{db}_Genes.tsv"

    if not ref.exists():

        summary.append({
            "Database":db,
            "ReferenceGenes":0,
            "MatchedDrivers":0,
            "CoveragePercent":0
        })

        continue

    genes = set(
        pd.read_csv(ref,sep="\t")["Gene"]
        .astype(str)
        .str.upper()
    )

    hits = master.Driver.str.upper().isin(genes)

    matched = master.loc[hits]

    matched.to_csv(
        OUTDIR/f"{db}_Matches.tsv",
        sep="\t",
        index=False
    )

    summary.append({

        "Database":db,

        "ReferenceGenes":len(genes),

        "MatchedDrivers":len(matched),

        "CoveragePercent":round(
            len(matched)/len(master)*100,
            2
        )

    })

summary = pd.DataFrame(summary)

summary.to_csv(
    OUTDIR/"Biological_Benchmark_Summary.tsv",
    sep="\t",
    index=False
)

print(summary)
