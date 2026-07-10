"""
Simple logger test for CCNIF.
"""

from ccnif.logger import get_logger

logger = get_logger("CCNIF")

logger.info("Logger initialized successfully.")
logger.warning("This is a test warning.")
logger.error("This is a test error.")
