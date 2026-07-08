import gzip
import json
from pathlib import Path

import matplotlib.pyplot as plt
import pandas as pd
from sklearn.decomposition import PCA

OUTDIR = Path("results/qc")
FIGDIR = Path("figures/qc")

OUTDIR.mkdir(parents=True, exist_ok=True)
FIGDIR.mkdir(parents=True, exist_ok=True)

print("Loading normalized expression matrix...")

with gzip.open(
    "data/processed/normalized/expression_log2_cpm.tsv.gz",
    "rt"
) as f:
    expr = pd.read_csv(f, sep="\t")

X = expr.iloc[:, 3:].T

print(f"Samples: {X.shape[0]}")
print(f"Genes: {X.shape[1]}")

pca = PCA(n_components=2)

coords = pca.fit_transform(X)

pca_df = pd.DataFrame({
    "patient_id": X.index,
    "PC1": coords[:, 0],
    "PC2": coords[:, 1]
})

pca_df.to_csv(
    OUTDIR / "pca_coordinates.tsv",
    sep="\t",
    index=False
)

plt.figure(figsize=(8,6))

plt.scatter(
    pca_df["PC1"],
    pca_df["PC2"],
    s=18,
    alpha=0.8
)

plt.xlabel(
    f"PC1 ({pca.explained_variance_ratio_[0]*100:.1f}%)"
)

plt.ylabel(
    f"PC2 ({pca.explained_variance_ratio_[1]*100:.1f}%)"
)

plt.title("TCGA-LUAD PCA")

plt.tight_layout()

plt.savefig(
    FIGDIR / "PCA.png",
    dpi=300
)

summary = {
    "samples": int(X.shape[0]),
    "genes": int(X.shape[1]),
    "pc1_variance": float(pca.explained_variance_ratio_[0]),
    "pc2_variance": float(pca.explained_variance_ratio_[1])
}

with open(
    OUTDIR / "expression_qc.json",
    "w"
) as f:
    json.dump(summary, f, indent=4)

print(json.dumps(summary, indent=4))
print("Done.")
