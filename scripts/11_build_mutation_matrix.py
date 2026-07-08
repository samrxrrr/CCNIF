import json
from pathlib import Path

import pandas as pd

INPUT = "data/processed/mutation/merged_maf.tsv"

OUTPUT_DIR = Path("data/processed/mutation")
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

print("=" * 60)
print("Loading merged MAF...")
print("=" * 60)

maf = pd.read_csv(
    INPUT,
    sep="\t",
    low_memory=False
)

print(f"Variants loaded: {len(maf):,}")

# -----------------------------------------
# Keep only functional coding mutations
# -----------------------------------------

functional = [
    "Missense_Mutation",
    "Nonsense_Mutation",
    "Frame_Shift_Del",
    "Frame_Shift_Ins",
    "Splice_Site",
    "Nonstop_Mutation",
    "Translation_Start_Site",
    "In_Frame_Del",
    "In_Frame_Ins"
]

maf = maf[
    maf["Variant_Classification"].isin(functional)
].copy()

print(f"Functional variants: {len(maf):,}")

# -----------------------------------------
# Convert barcode -> patient ID
# -----------------------------------------

maf["patient_id"] = (
    maf["Tumor_Sample_Barcode"]
        .astype(str)
        .str[:12]
)

# -----------------------------------------
# Binary mutation matrix
# -----------------------------------------

matrix = (
    pd.crosstab(
        maf["patient_id"],
        maf["Hugo_Symbol"]
    ) > 0
).astype(int)

matrix.to_csv(
    OUTPUT_DIR / "mutation_matrix.tsv",
    sep="\t"
)

# -----------------------------------------
# Tumor Mutation Burden
# -----------------------------------------

tmb = (
    maf.groupby("patient_id")
       .size()
       .reset_index(name="Mutation_Count")
       .sort_values("Mutation_Count", ascending=False)
)

tmb.to_csv(
    OUTPUT_DIR / "tumor_mutation_burden.tsv",
    sep="\t",
    index=False
)

# -----------------------------------------
# Frequently mutated genes
# -----------------------------------------

gene_freq = (
    matrix.sum(axis=0)
          .sort_values(ascending=False)
          .reset_index()
)

gene_freq.columns = [
    "Gene",
    "Mutated_Patients"
]

gene_freq["Frequency"] = (
    gene_freq["Mutated_Patients"]
    / matrix.shape[0]
)

gene_freq.to_csv(
    OUTPUT_DIR / "gene_mutation_frequency.tsv",
    sep="\t",
    index=False
)

summary = {
    "patients": int(matrix.shape[0]),
    "genes": int(matrix.shape[1]),
    "functional_variants": int(len(maf)),
    "mean_mutations_per_patient": round(
        float(tmb["Mutation_Count"].mean()),
        2
    )
}

with open(
    OUTPUT_DIR / "mutation_matrix_summary.json",
    "w"
) as f:
    json.dump(summary, f, indent=4)

print("\n" + "=" * 60)
print("Mutation Matrix Completed")
print("=" * 60)
print(json.dumps(summary, indent=4))
