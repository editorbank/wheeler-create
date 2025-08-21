import logging as LOG

class log_from_class():
    def log_from_method(_):
        LOG.debug("DEBUG Message for class and method")

def test_1():
    log_from_class().log_from_method()

    LOG.info("This is a password: ABCDEF")
    LOG.debug("A DEBUG Message")
    LOG.info("An INFO")
    LOG.warning("A WARNING")
    LOG.error("An ERROR", exc_info=True)
    LOG.critical("A message of CRITICAL severity", exc_info=True)

if __name__ == "__main__": test_1()
