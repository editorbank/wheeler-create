import logging
import re
from nelog import getLogger; LOG = getLogger(__name__)


class MaskingFormatter(logging.Formatter):
    def __init__(self, *args, secrets=None, placeholder=None, **kwargs):
        LOG.debug("Creating MaskingFormatter.__init__(... secrets=%r, placeholder=%r ...)", secrets, placeholder)
        self.secrets = secrets or []
        self.placeholder = placeholder or "*MASKED*"
        super().__init__(*args, **kwargs)
        LOG.debug("Created MaskingFormatter.self: secrets=%r, placeholder=%r", self.secrets, self.placeholder)

    def _filter(self, msg):
        LOG.debug("_filter. In  Message: %r", msg)
        for mask in self.secrets:
            msg = re.sub(mask, self.placeholder, msg)
        LOG.debug("_filter. Out Message: %r", msg)
        return msg

    def format(self, record):
        original = super().format(record)  # call parent method
        return self._filter(original)

if __name__ == "__main__":
    mf = MaskingFormatter(secrets=["ABCDEF"])
    lr = logging.LogRecord(name="x", level=10, pathname="x", lineno=1, msg="My password is 'ABCDEF'", args=[], exc_info=None)
    print( mf.format(lr) )
