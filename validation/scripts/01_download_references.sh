#!/usr/bin/env bash
set -e

mkdir -p validation/reference/raw

echo "Downloading Cancer Gene Census..."
wget -O validation/reference/raw/CGC.csv \
https://cancer.sanger.ac.uk/cosmic/file_download/GRCh38/cosmic/v101/cancer_gene_census.csv.gz || true

echo "Downloading IntOGen..."
wget -O validation/reference/raw/intogen_drivers.tsv.gz \
https://www.intogen.org/downloads/drivers.tsv.gz || true

echo "Downloading NCG..."
wget -O validation/reference/raw/ncg_candidates.tsv \
http://ncg.kcl.ac.uk/download/file?name=NCG_cancerdrivers_annotation_supporting_evidence.tsv || true

echo "Finished."
