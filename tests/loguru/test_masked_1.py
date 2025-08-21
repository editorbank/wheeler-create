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

#Затем используйте его в своих обработчиках:

# Create the specific logger
mylogger = logging.getLogger("foobar")
mylogger.setLevel(logging.DEBUG)
mylogger.propagate = False

# Create the handler
streamhandler = logging.StreamHandler()
streamhandler.setLevel(logging.INFO)

# Create the specific formatter
sensitive_formatter = SensitiveFormatter(
    fmt="[pid:%(process)d] - %(asctime)s - %(name)s - %(levelname)-8s - %(message).1000s"
)
streamhandler.setFormatter(sensitive_formatter)

mylogger.addHandler(streamhandler)

mylogger.info("This is a password: ABCDEF")