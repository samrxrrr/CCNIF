#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$HOME/CCNIF"
RAW_DIR="$PROJECT_DIR/data/raw"

mkdir -p "$RAW_DIR"

cd "$RAW_DIR"

echo "======================================"
echo "CCNIF Data Download"
echo "======================================"

echo
echo "[1/3] Downloading TCGA-LUAD Expression Matrix..."

wget -c \
https://tcga-xena-hub.s3.us-east-1.amazonaws.com/download/TCGA.LUAD.sampleMap%2FHiSeqV2.gz \
-O expression_matrix.tsv.gz

echo
echo "[2/3] Downloading TCGA-LUAD Clinical Data..."

wget -c \
https://tcga-xena-hub.s3.us-east-1.amazonaws.com/download/TCGA.LUAD.sampleMap%2FLUAD_clinicalMatrix.gz \
-O clinical.tsv.gz

echo
echo "[3/3] Downloading TCGA Phenotype..."

wget -c \
https://tcga-xena-hub.s3.us-east-1.amazonaws.com/download/TCGA_phenotype_denseDataOnlyDownload.tsv.gz \
-O phenotype.tsv.gz

echo
echo "======================================"
echo "Download Complete"
echo "======================================"

ls -lh
