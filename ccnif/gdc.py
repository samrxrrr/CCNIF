"""
CCNIF GDC API Client
"""

from pathlib import Path
import json
import requests

from ccnif.logger import get_logger

logger = get_logger(__name__)

BASE_URL = "https://api.gdc.cancer.gov"


class GDCClient:
    """Simple client for the GDC REST API."""

    def __init__(self):
        self.base_url = BASE_URL

    def check_connection(self):
        url = f"{self.base_url}/status"

        logger.info("Checking GDC API connection...")

        response = requests.get(url, timeout=30)

        response.raise_for_status()

        return response.json()

    def get_project(self, project_id="TCGA-LUAD"):

        fields = [
            "project_id",
            "name",
            "primary_site",
            "disease_type",
            "program.name",
            "summary.case_count",
            "summary.file_count",
            "summary.experimental_strategies.experimental_strategy",
            "summary.data_categories.data_category"
        ]

        params = {
            "filters": json.dumps({
                "op": "=",
                "content": {
                    "field": "project_id",
                    "value": project_id
                }
            }),
            "fields": ",".join(fields),
            "format": "JSON",
            "size": 1
        }

        logger.info(f"Retrieving project metadata for {project_id}")

        response = requests.get(
            f"{self.base_url}/projects",
            params=params,
            timeout=60
        )

        response.raise_for_status()

        return response.json()

    def save_json(self, data, output_path):

        output_path = Path(output_path)

        output_path.parent.mkdir(parents=True, exist_ok=True)

        with open(output_path, "w") as handle:
            json.dump(data, handle, indent=4)

        logger.info(f"Saved {output_path}")
