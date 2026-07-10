from pathlib import Path
import pandas as pd
import glob

OUT = Path("manuscript/supplementary/tables")
OUT.mkdir(parents=True, exist_ok=True)

###############################################################################
# Collect enrichment results across all drivers
###############################################################################

datasets = {
    "GO_BP":"GO/GO_BP.tsv",
    "GO_MF":"GO/GO_MF.tsv",
    "GO_CC":"GO/GO_CC.tsv",
    "KEGG":"KEGG/KEGG.tsv",
    "Reactome":"Reactome/Reactome.tsv",
    "DO":"DiseaseOntology/DO.tsv",
    "GSEA":"GSEA/Hallmark_GSEA.tsv"
}

mapping = {
    "GO_BP":"Supplementary_Table_S11_GO_BP.tsv",
    "GO_MF":"Supplementary_Table_S11_GO_MF.tsv",
    "GO_CC":"Supplementary_Table_S11_GO_CC.tsv",
    "KEGG":"Supplementary_Table_S12_KEGG.tsv",
    "Reactome":"Supplementary_Table_S13_Reactome.tsv",
    "DO":"Supplementary_Table_S14_DiseaseOntology.tsv",
    "GSEA":"Supplementary_Table_S15_GSEA.tsv"
}

for key,rel in datasets.items():

    frames=[]

    for f in glob.glob("results/evidence/*/"+rel):

        driver=f.split("/")[2]

        try:
            df=pd.read_csv(f,sep="\t")
        except:
            continue

        df.insert(0,"Driver",driver)

        frames.append(df)

    outfile=OUT/mapping[key]

    if len(frames)==0:

        pd.DataFrame({
            "Status":["No data found"],
            "ExpectedLocation":[rel]
        }).to_csv(outfile,sep="\t",index=False)

        print(key,"-> placeholder")

    else:

        merged=pd.concat(frames,ignore_index=True)

        merged.to_csv(outfile,sep="\t",index=False)

        print(
            key,
            "Drivers:",
            merged.Driver.nunique(),
            "Rows:",
            len(merged)
        )

print("\nFinished.")
