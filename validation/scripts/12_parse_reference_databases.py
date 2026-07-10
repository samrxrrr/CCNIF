from pathlib import Path
import pandas as pd

BASE = Path("validation/reference/external")
OUT = Path("validation/reference/processed")

OUT.mkdir(parents=True, exist_ok=True)

DATABASES = {
    "CGC": ("CGC/CGC.csv", ["Gene Symbol","Gene","SYMBOL"]),
    "IntOGen": ("IntOGen/drivers.tsv", ["SYMBOL","Gene","gene"]),
    "OncoKB": ("OncoKB/oncokb.tsv", ["Hugo Symbol","Gene","SYMBOL"]),
    "CancerMine": ("CancerMine/cancermine.tsv", ["gene_normalized","Gene","gene"]),
    "NCG": ("NCG/ncg.tsv", ["symbol","Gene","gene","SYMBOL"])
}

print("\n========================================")
print("REFERENCE DATABASE PARSER")
print("========================================")

for db,(relpath,candidates) in DATABASES.items():

    infile = BASE / relpath

    if not infile.exists():
        print(f"{db:<12} MISSING")
        continue

    print(f"{db:<12} FOUND")

    try:

        sep = "\t"

        if infile.suffix.lower()==".csv":
            sep=","

        df = pd.read_csv(
            infile,
            sep=sep,
            low_memory=False
        )

        gene_col = None

        for c in candidates:
            if c in df.columns:
                gene_col = c
                break

        if gene_col is None:
            print(f"  -> No recognized gene column.")
            print("  -> Columns:",list(df.columns))
            continue

        genes = (
            df[gene_col]
            .dropna()
            .astype(str)
            .str.upper()
            .drop_duplicates()
            .sort_values()
        )

        outfile = OUT / f"{db}_Genes.tsv"

        genes.to_csv(
            outfile,
            sep="\t",
            index=False,
            header=["Gene"]
        )

        print(f"  -> {len(genes)} genes exported")

    except Exception as e:
        print(f"  -> ERROR: {e}")

print("\nFinished.")
