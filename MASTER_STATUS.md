# CCNIF
## Cancer Causal Network Inference Framework

Project Version: v0.3.0

Last Updated: 2026-07-08

============================================================

PROJECT STATUS

Overall Progress:
~60%

Current Phase:
Multi-Omics Dataset Construction Completed

============================================================

DATASETS

Expression
----------
Samples: 517 downloaded
Matched samples: 505

Genes (raw):
60660

Genes after filtering:
17629

Normalization:
log2(CPM + 1)

Status:
Completed

------------------------------------------------------------

Clinical

Downloaded patients:
585

Matched patients:
517

Final matched:
505

Variables:
11

Status:
Completed

------------------------------------------------------------

Mutation

MAF files:
507

Unique samples:
505

Functional variants:
121778

Mutated genes:
16399

Status:
Completed

============================================================

DIRECTORIES

data/processed/expression
Completed

data/processed/clinical
Completed

data/processed/mutation
Completed

data/processed/final
Completed

data/processed/normalized
Completed

============================================================

COMPLETED SCRIPTS

test_logger.py
test_config.py
test_state.py

01_merge_expression.py

03_rename_samples.py

04_download_clinical.py

05_harmonize_clinical.py

06_download_maf_manifest.py

07_filter_maf_manifest.py

08_build_unique_maf_manifest.py

09_find_missing_maf_patients.py

10_parse_maf.py

11_build_mutation_matrix.py

12_build_final_cohort.py

13_normalize_expression.py

============================================================

CURRENT RESULTS

Expression matrix

Clinical matrix

Mutation matrix

Final matched cohort

Normalized expression matrix

Tumor mutation burden

Mutation frequencies

============================================================

NEXT TASKS

1.
Generate QC figures

2.
PCA

3.
Expression QC

4.
Mutation QC

5.
Clinical QC

6.
Expression-Mutation integration

7.
Driver prioritization

8.
Regulatory network inference

9.
Explainable AI

10.
Publication figures

============================================================

GITHUB

Repository Status:
Ready for update

Last Milestone:
v0.3

============================================================
