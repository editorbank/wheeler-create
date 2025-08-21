from loguru import logger

class log_from_class():
    def log_from_method(_):
        logger.debug("DEBUG Message for class and method")

def test_1():
    log_from_class().log_from_method()
    logger.debug("That's it, beautiful and simple logging!")

if __name__ == "__main__":
    test_1()
    print('OK')