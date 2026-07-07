"""
CCNIF Project State Management
"""

import json
from pathlib import Path
from datetime import datetime

STATE_FILE = Path("results/project_state.json")


class ProjectState:
    """Manage the CCNIF project state."""

    def __init__(self):
        STATE_FILE.parent.mkdir(parents=True, exist_ok=True)

        if STATE_FILE.exists():
            with open(STATE_FILE, "r") as handle:
                self.state = json.load(handle)
        else:
            self.state = {
                "project": "CCNIF",
                "version": "0.1.0",
                "current_stage": None,
                "completed_stages": [],
                "last_run": None,
                "datasets": {}
            }

    def update_stage(self, stage: str):
        self.state["current_stage"] = stage
        self.state["last_run"] = datetime.now().isoformat()

        if stage not in self.state["completed_stages"]:
            self.state["completed_stages"].append(stage)

    def save(self):
        with open(STATE_FILE, "w") as handle:
            json.dump(self.state, handle, indent=4)
