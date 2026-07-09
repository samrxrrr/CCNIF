# CCNIF Production Architecture (Phase 5.2)

## Production Pipeline

DEGs.tsv
    ↓
Driver Extractor
    ↓
Transcriptomics Evidence
    ↓
Clinical Evidence
    ↓
Functional Evidence
    ↓
Network Evidence
    ↓
Survival Evidence
    ↓
Enrichment Evidence
    ↓
Unified Evidence
    ↓
Unified Statistics
    ↓
Unified Diagnostics
    ↓
Unified Distribution
    ↓
Reliability Engine
    ↓
Normalization Engine
    ↓
Quality Engine
    ↓
Confidence Engine
    ↓
Driver Report
    ↓
Driver Manifest
    ↓
Atlas Builder

## Entry Point

Rscript scripts/run_ccnif.R

## Status

Architecture: Production Ready

Phase: 5.2 Complete
