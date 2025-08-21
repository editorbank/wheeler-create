from loguru import logger as log

class log_from_class():
    def log_from_method(_):
        log.debug("DEBUG Message for class and method")

def test_1():
    log_from_class().log_from_method()
    log.debug("A DEBUG Message")
    log.info("An INFO")
    log.warning("A WARNING")
    log.error("An ERROR")
    log.critical("A message of CRITICAL severity")

if __name__ == "__main__":
    log.setLevel(20)
    test_1()
    print('OK')