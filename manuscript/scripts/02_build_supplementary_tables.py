from pathlib import Path
import pandas as pd
import shutil

ROOT=Path(".")
OUT=ROOT/"manuscript"/"supplementary"/"tables"
OUT.mkdir(parents=True,exist_ok=True)

def cp(src,name):
    src=Path(src)
    if src.exists():
        shutil.copy2(src,OUT/name)
        print("OK",name)
    else:
        print("MISSING",src)

###############################################################################
# S1 MASTER DRIVERS
###############################################################################

cp(
"results/master/Driver_Master_Index.tsv",
"Supplementary_Table_S1_Top50_Drivers.tsv"
)

###############################################################################
# S2 VALIDATION
###############################################################################

cp(
"validation/results/benchmark/Benchmark_Results.tsv",
"Supplementary_Table_S2_Benchmark.tsv"
)

###############################################################################
# S3 BIOLOGICAL BENCHMARK
###############################################################################

cp(
"validation/results/biological/Biological_Benchmark_Summary.tsv",
"Supplementary_Table_S3_Biological_Benchmark.tsv"
)

###############################################################################
# S4 VALIDATION SUMMARY
###############################################################################

cp(
"validation/results/Validation_Summary.tsv",
"Supplementary_Table_S4_Validation.tsv"
)

###############################################################################
# S5 FRAMEWORK SUMMARY
###############################################################################

cp(
"validation/tables/Table4_Framework_Summary.tsv",
"Supplementary_Table_S5_Framework.tsv"
)

###############################################################################
# DRIVER TABLES
###############################################################################

master=pd.read_csv(
"results/master/Driver_Master_Index.tsv",
sep="\t"
)

master.to_csv(
OUT/"Supplementary_Table_S6_All_Driver_Scores.tsv",
sep="\t",
index=False
)

master.sort_values(
"DriverConfidence",
ascending=False
).to_csv(
OUT/"Supplementary_Table_S7_Ranked_Drivers.tsv",
sep="\t",
index=False
)

master.groupby(
"ConfidenceTier"
).size().reset_index(name="Count").to_csv(
OUT/"Supplementary_Table_S8_Confidence_Tiers.tsv",
sep="\t",
index=False
)

master.groupby(
"QualityTier"
).size().reset_index(name="Count").to_csv(
OUT/"Supplementary_Table_S9_Quality_Tiers.tsv",
sep="\t",
index=False
)

###############################################################################
# S10 SOFTWARE
###############################################################################

software=pd.DataFrame({
"Software":[
"R",
"Python",
"clusterProfiler",
"ReactomePA",
"DOSE",
"fgsea",
"data.table",
"pandas"
]
})

software.to_csv(
OUT/"Supplementary_Table_S10_Software.tsv",
sep="\t",
index=False
)

###############################################################################
# EMPTY PLACEHOLDERS
###############################################################################

for i,name in [
(11,"GO_Results"),
(12,"KEGG_Results"),
(13,"Reactome_Results"),
(14,"DiseaseOntology_Results"),
(15,"GSEA_Results")
]:
    pd.DataFrame({
        "Status":["Generated per driver"],
        "Location":["results/evidence/*"]
    }).to_csv(
        OUT/f"Supplementary_Table_S{i}_{name}.tsv",
        sep="\t",
        index=False
    )

print()
print("="*60)
print("SUPPLEMENTARY TABLES COMPLETE")
print("="*60)

for f in sorted(OUT.glob("*.tsv")):
    print(f.name)
