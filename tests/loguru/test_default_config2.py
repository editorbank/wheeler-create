from logging import debug, info, warning, error, critical

class log_from_class():
    def log_from_method(_):
        debug("DEBUG Message for class and method")

def test_1():
    log_from_class().log_from_method()

    debug("A DEBUG Message")
    info("An INFO")
    warning("A WARNING")
    error("An ERROR", exc_info=True)
    critical("A message of CRITICAL severity", exc_info=True)

if __name__ == "__main__":
    import logging.config
    logging.config.fileConfig('log.ini', disable_existing_loggers=False)
    test_1()
    print('OK')