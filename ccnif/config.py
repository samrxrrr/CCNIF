"""
CCNIF Configuration Management
"""

from pathlib import Path
import yaml

PROJECT_ROOT = Path(__file__).resolve().parent.parent

CONFIG_DIR = PROJECT_ROOT / "config"

def load_yaml(filename: str):
    filepath = CONFIG_DIR / filename

    with open(filepath, "r") as handle:
        return yaml.safe_load(handle)

DATASETS = load_yaml("datasets.yaml")
PATHS = load_yaml("paths.yaml")
