"""
CCNIF Logging Utilities

Provides a standardized logger for all CCNIF modules.
"""

import logging
from pathlib import Path


def get_logger(name: str) -> logging.Logger:
    """
    Create or return a configured logger.

    Parameters
    ----------
    name : str
        Logger name.

    Returns
    -------
    logging.Logger
    """

    log_dir = Path("logs")
    log_dir.mkdir(exist_ok=True)

    logger = logging.getLogger(name)

    if logger.handlers:
        return logger

    logger.setLevel(logging.INFO)

    formatter = logging.Formatter(
        fmt="%(asctime)s | %(levelname)s | %(name)s | %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
    )

    file_handler = logging.FileHandler(log_dir / "ccnif.log")
    file_handler.setFormatter(formatter)

    stream_handler = logging.StreamHandler()
    stream_handler.setFormatter(formatter)

    logger.addHandler(file_handler)
    logger.addHandler(stream_handler)

    return logger
