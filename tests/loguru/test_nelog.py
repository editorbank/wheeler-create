from nelog import getLogger; LOG=getLogger(__name__)

def test_mylog():
	print(LOG)
	LOG.debug("debug")
	LOG.info("info")
	LOG.error("error")
	LOG.critical("critical")

if __name__ == "__main__":
	test_mylog()
