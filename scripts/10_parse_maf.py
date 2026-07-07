from pathlib import Path
import gzip
import pandas as pd
from tqdm import tqdm

INPUT_DIR = Path("data/raw/TCGA-LUAD/mutation")
OUTPUT_DIR = Path("data/processed/mutation")

OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

files = sorted(INPUT_DIR.rglob("*.maf.gz"))

print(f"Found {len(files)} MAF files")

frames = []

for file in tqdm(files):

    df = pd.read_csv(
        file,
        sep="\t",
        comment="#",
        low_memory=False
    )

    keep = [
        "Hugo_Symbol",
        "Variant_Classification",
        "Variant_Type",
        "Tumor_Sample_Barcode",
        "Chromosome",
        "Start_Position",
        "Reference_Allele",
        "Tumor_Seq_Allele2"
    ]

    keep = [c for c in keep if c in df.columns]

    frames.append(df[keep])

maf = pd.concat(frames, ignore_index=True)

maf.to_csv(
    OUTPUT_DIR / "merged_maf.tsv",
    sep="\t",
    index=False
)

summary = maf.groupby("Hugo_Symbol").size().sort_values(ascending=False)

summary.to_csv(
    OUTPUT_DIR / "mutation_frequency.tsv",
    sep="\t",
    header=["Mutations"]
)

print("\n================================")
print("Merged MAF completed")
print("================================")
print(f"Variants : {len(maf):,}")
print(f"Genes    : {maf['Hugo_Symbol'].nunique():,}")
