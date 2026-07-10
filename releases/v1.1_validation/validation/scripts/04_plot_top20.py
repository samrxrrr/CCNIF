import pandas as pd
import matplotlib.pyplot as plt
from pathlib import Path

plt.rcParams["figure.figsize"] = (10,8)

df = pd.read_csv(
    "results/master/Driver_Master_Index.tsv",
    sep="\t"
)

df = df.sort_values(
    "DriverConfidence",
    ascending=False
).head(20)

plt.barh(
    df["Driver"],
    df["DriverConfidence"]
)

plt.gca().invert_yaxis()

plt.xlabel("Driver Confidence Score")
plt.ylabel("Driver")

plt.title("CCNIF Top 20 Driver Genes")

plt.tight_layout()

Path("validation/figures").mkdir(
    parents=True,
    exist_ok=True
)

plt.savefig(
    "validation/figures/Figure1_Top20_Drivers.png",
    dpi=300
)

print("Figure saved.")
