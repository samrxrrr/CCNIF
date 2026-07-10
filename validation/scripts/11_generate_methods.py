import json
from pathlib import Path

cfg=json.load(open("config/analysis_config.json"))

text=f"""
METHODS

Framework
---------
Cancer Causal Network Inference Framework (CCNIF) v1.0

Cohort
------
{cfg['project']['cohort']}

Differential Expression
-----------------------
Minimum CPM: {cfg['expression']['min_cpm']}
Minimum sample fraction: {cfg['expression']['min_sample_fraction']}
Transformation: {cfg['expression']['log_transform']}

DESeq2
------
Prefilter minimum count: {cfg['deseq2']['prefilter_min_count']}
Prefilter sample fraction: {cfg['deseq2']['prefilter_min_fraction']}
Adjusted P-value cutoff: {cfg['deseq2']['padj_cutoff']}
Log2 Fold Change cutoff: {cfg['deseq2']['log2fc_cutoff']}
Shrinkage method: {cfg['deseq2']['lfc_shrink_method']}

Functional Enrichment
---------------------
Organism: {cfg['enrichment']['organism']}
Adjusted P-value cutoff: {cfg['enrichment']['padj_cutoff']}

Gene Set Enrichment Analysis
----------------------------
Collection: {cfg['gsea']['collection']}
Minimum pathway size: {cfg['gsea']['minSize']}
Maximum pathway size: {cfg['gsea']['maxSize']}
Permutations: {cfg['gsea']['nperm']}
Ranking metric: {cfg['gsea']['ranking']}

Production Pipeline
-------------------
The production workflow consisted of transcriptomic evidence generation,
clinical evidence integration,
functional enrichment,
network analysis,
survival analysis,
statistical modeling,
reliability estimation,
normalization,
quality assessment,
confidence scoring,
driver report generation,
and master index construction.
"""

Path("manuscript/methods").mkdir(parents=True,exist_ok=True)

with open("manuscript/methods/Methods_Draft.txt","w") as f:
    f.write(text)

print(text)
