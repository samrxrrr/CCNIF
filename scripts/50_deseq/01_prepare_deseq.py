import gzip
import json
from pathlib import Path

import pandas as pd

OUT = Path("data/processed/deseq")
OUT.mkdir(parents=True, exist_ok=True)

print("="*60)
print("Preparing DESeq2 Inputs")
print("="*60)

# -------------------------
# Expression
# -------------------------

with gzip.open(
    "data/processed/final/expression_matched.tsv.gz",
    "rt"
) as f:
    expr = pd.read_csv(f, sep="\t")

counts = expr.copy()

counts = counts.drop(columns=["gene_name","gene_type"])

counts = counts.rename(columns={
    "gene_id":"GeneID"
})

counts.to_csv(
    OUT/"counts.tsv",
    sep="\t",
    index=False
)

print("Counts matrix saved.")

# -------------------------
# Clinical
# -------------------------

clinical = pd.read_csv(
    "data/processed/final/clinical_matched.tsv",
    sep="\t"
)

clinical.to_csv(
    OUT/"clinical_metadata.tsv",
    sep="\t",
    index=False
)

print("Clinical metadata saved.")

# -------------------------
# Mutation Matrix
# -------------------------

mutation = pd.read_csv(
    "data/processed/final/mutation_matrix_matched.tsv",
    sep="\t",
    index_col=0
)

# TP53 status

tp53 = mutation["TP53"].copy()

design = pd.DataFrame({
    "patient_id": tp53.index,
    "TP53_status": tp53.map({
        0:"WildType",
        1:"Mutant"
    })
})

design.to_csv(
    OUT/"design_TP53.tsv",
    sep="\t",
    index=False
)

summary = {
    "patients": int(len(design)),
    "TP53_mutant": int((design["TP53_status"]=="Mutant").sum()),
    "TP53_wildtype": int((design["TP53_status"]=="WildType").sum())
}

with open(
    OUT/"deseq_summary.json",
    "w"
) as f:
    json.dump(summary,f,indent=4)

print(json.dumps(summary,indent=4))
print("Done.")
