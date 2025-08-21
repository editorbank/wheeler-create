import logging
import re

class SensitiveFormatter(logging.Formatter):
    """Formatter that removes sensitive information in logs."""

    @staticmethod
    def _filter(s):
        # Filter out the password with regex
        # or replace etc.
        # Replace here with your own regex..
        return re.sub(r"ABCDEF", r"<MASKED>", s)

    def format(self, record):
        original = logging.Formatter.format(self, record)  # call parent method
        return self._filter(original)
