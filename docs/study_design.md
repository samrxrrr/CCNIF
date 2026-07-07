# CCNIF Study Design

## Project

Cancer Causal Network Inference Framework (CCNIF)

## Working Title

Cancer Causal Network Inference Framework (CCNIF): An Explainable Multi-Omics Platform for Inferring Putative Molecular Drivers of Tumor Progression

## Primary Objective

Develop a reproducible computational framework that integrates publicly available molecular and clinical data to infer and prioritize putative causal mechanisms associated with tumor progression.

## Secondary Objectives

- Prioritize candidate driver genes.
- Infer transcriptional regulatory programs.
- Associate regulatory programs with cancer hallmarks.
- Construct explainable causal network models.
- Quantify confidence using multiple independent evidence sources.
- Evaluate associations with clinical outcomes.

## Study Type

Computational oncology

Retrospective

Multi-omics integration

Open-source

Reproducible

No wet laboratory experiments

## Current Status

Phase 1: Study design

## Biological Scope

Initial implementation: Single cancer type

The CCNIF framework will be developed and validated using one cancer type. The software architecture will remain generalizable to additional cancer types in future studies.

## Initial Cancer Type

Selected cancer:
Lung Adenocarcinoma (TCGA-LUAD)

Selection rationale:

- Extensive publicly available multi-omics datasets
- Comprehensive clinical annotation
- Well-characterized driver genes
- Multiple independent validation cohorts
- Strong biological knowledge base
- Suitable benchmark for developing the CCNIF framework

## Core Data Modalities

The initial CCNIF implementation will integrate:

- Somatic mutation data
- Bulk RNA-seq gene expression
- Clinical metadata
- Curated transcription factor-target interactions
- Curated pathway and cancer hallmark annotations
- Protein-protein interaction networks

Optional supporting evidence:

- Functional dependency datasets where scientifically justified

Excluded from the initial implementation:

- DNA methylation
- Proteomics
- Single-cell sequencing
- Spatial transcriptomics

## Planned Public Data Sources

Primary molecular and clinical data:
- TCGA

Supporting biological knowledge:
- COSMIC Cancer Gene Census
- DoRothEA
- TRRUST
- Reactome
- MSigDB Hallmark
- STRING

Supporting validation resource:
- DepMap

Only publicly accessible resources with clear documentation and citation will be used.
