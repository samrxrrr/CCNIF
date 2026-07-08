from pathlib import Path
import pandas as pd
from tqdm import tqdm
import json

INPUT_DIR = Path("data/raw/TCGA-LUAD/mutation")
OUTPUT_DIR = Path("data/processed/mutation")

OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

files = sorted(INPUT_DIR.rglob("*.maf.gz"))

print("=" * 60)
print(f"Found {len(files)} MAF files")
print("=" * 60)

frames = []

required_columns = [
    "Hugo_Symbol",
    "Entrez_Gene_Id",
    "Variant_Classification",
    "Variant_Type",
    "Tumor_Sample_Barcode",
    "Chromosome",
    "Start_Position",
    "End_Position",
    "Reference_Allele",
    "Tumor_Seq_Allele2"
]

for file in tqdm(files):

    df = pd.read_csv(
        file,
        sep="\t",
        comment="#",
        low_memory=False
    )

    keep = [c for c in required_columns if c in df.columns]

    df = df[keep]

    frames.append(df)

maf = pd.concat(frames, ignore_index=True)

maf.to_csv(
    OUTPUT_DIR / "merged_maf.tsv",
    sep="\t",
    index=False
)

gene_frequency = (
    maf.groupby("Hugo_Symbol")
       .size()
       .sort_values(ascending=False)
       .reset_index(name="Mutation_Count")
)

gene_frequency.to_csv(
    OUTPUT_DIR / "mutation_frequency.tsv",
    sep="\t",
    index=False
)

variant_frequency = (
    maf.groupby("Variant_Classification")
       .size()
       .sort_values(ascending=False)
       .reset_index(name="Count")
)

variant_frequency.to_csv(
    OUTPUT_DIR / "variant_classification.tsv",
    sep="\t",
    index=False
)

report = {
    "maf_files": len(files),
    "total_variants": int(len(maf)),
    "unique_genes": int(maf["Hugo_Symbol"].nunique()),
    "unique_samples": int(maf["Tumor_Sample_Barcode"].nunique())
}

with open(
    OUTPUT_DIR / "maf_summary.json",
    "w"
) as f:
    json.dump(report, f, indent=4)

print("\n" + "=" * 60)
print("MAF Parsing Completed")
print("=" * 60)

print(json.dumps(report, indent=4))
