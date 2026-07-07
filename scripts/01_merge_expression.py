from pathlib import Path
import gzip
import json

import pandas as pd
from tqdm import tqdm

INPUT_DIR = Path("data/raw/TCGA-LUAD/expression")
OUTPUT_DIR = Path("data/processed/expression")
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

cohort = pd.read_csv(
    "data/raw/TCGA-LUAD/metadata/expression_cohort.csv"
)

# filename -> TCGA patient barcode
mapping = {}

for _, row in cohort.iterrows():
    filename = row["file_name"]
    uuid = filename.replace(".rna_seq.augmented_star_gene_counts.tsv", "")
    mapping[uuid] = row["patient_id"]

files = sorted(INPUT_DIR.rglob("*.tsv"))

print(f"Found {len(files)} files")

matrix = None
sample_metadata = []

for file in tqdm(files):

    df = pd.read_csv(
        file,
        sep="\t",
        comment="#"
    )

    df = df[
        df["gene_id"].str.startswith("ENSG")
    ].reset_index(drop=True)

    uuid = file.stem.replace(
        ".rna_seq.augmented_star_gene_counts",
        ""
    )

    if uuid not in mapping:
        raise RuntimeError(f"UUID not found: {uuid}")

    sample = mapping[uuid]

    if matrix is None:

        matrix = df[
            ["gene_id", "gene_name", "gene_type"]
        ].copy()

    else:

        if not matrix["gene_id"].equals(df["gene_id"]):
            raise RuntimeError(
                f"Gene order mismatch: {file}"
            )

    matrix[sample] = df["unstranded"].astype("int64")

    sample_metadata.append(
        {
            "patient_id": sample,
            "uuid": uuid,
            "file": file.name
        }
    )

print("Writing matrix...")

with gzip.open(
    OUTPUT_DIR / "expression_matrix.tsv.gz",
    "wt"
) as f:

    matrix.to_csv(
        f,
        sep="\t",
        index=False
    )

matrix[
    ["gene_id", "gene_name", "gene_type"]
].to_csv(
    OUTPUT_DIR / "gene_metadata.tsv",
    sep="\t",
    index=False
)

pd.DataFrame(
    sample_metadata
).to_csv(
    OUTPUT_DIR / "sample_metadata.tsv",
    sep="\t",
    index=False
)

report = {
    "samples": len(sample_metadata),
    "genes": matrix.shape[0],
    "columns": matrix.shape[1]
}

with open(
    OUTPUT_DIR / "merge_report.json",
    "w"
) as f:
    json.dump(report, f, indent=4)

print(report)
print("Merge completed successfully.")
