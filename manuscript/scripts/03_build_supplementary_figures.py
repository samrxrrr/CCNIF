from pathlib import Path
import shutil

SRC=Path("validation/figures")
OUT=Path("manuscript/supplementary/figures")

OUT.mkdir(parents=True,exist_ok=True)

mapping={
"Figure1_Top20_Drivers.png":"Supplementary_Figure_S1_Top20_Drivers.png",
"Figure2_Confidence_Distribution.png":"Supplementary_Figure_S2_Confidence_Distribution.png",
"Figure3_Quality_Distribution.png":"Supplementary_Figure_S3_Quality_Distribution.png",
"Figure4_Confidence_vs_Quality.png":"Supplementary_Figure_S4_Confidence_vs_Quality.png",
"Figure5_Confidence_Tiers.png":"Supplementary_Figure_S5_Confidence_Tiers.png",
}

for src,dst in mapping.items():
    f=SRC/src
    if f.exists():
        shutil.copy2(f,OUT/dst)
        print("OK",dst)
    else:
        print("Missing",src)

print("\nGenerating placeholders...")

for i,title in [
(6,"Pipeline_Workflow"),
(7,"Evidence_Integration"),
(8,"Benchmark_Overview")
]:
    with open(OUT/f"Supplementary_Figure_S{i}_{title}.txt","w") as f:
        f.write(f"{title} placeholder\n")

print("\nDone.")
