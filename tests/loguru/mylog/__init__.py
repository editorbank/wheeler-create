from logging import getLogger as logging_getLogger, Formatter, FileHandler, StreamHandler
from logging import debug, info, warning, error, critical
from logging import DEBUG, INFO, WARNING, ERROR, CRITICAL

def getLogger(
    name=__name__,
    level=INFO,
    filename='.log',
    #format="%(asctime)s [%(levelname).3s] [%(name)s] %(message)s (%(filename)s#%(lineno)d)",
    format="%(asctime)s [%(levelname).3s] [%(name)s] %(message)s (%(pathname)s#%(lineno)d)",
):
	l = logging_getLogger(name)
	l.setLevel(level)
	h = FileHandler(filename) if filename else StreamHandler()
	h.setFormatter(Formatter(format))
	l.addHandler(h)
	return l

if __name__ == "__main__":
    log = getLogger(__name__, level=10)
    log.warning("It's WARNING!!!")

    print('OK')