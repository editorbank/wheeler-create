from the_module import test_1
from the_module_root import test_1 as test_1_root

if __name__ == "__main__":
    from logging import getLogger; log = getLogger(__name__)
    from logging.config import dictConfig
    from yaml import safe_load as load, YAMLError
    
    with open("log.yml") as log_config_file:
        try:
            LOG_CONFIG_DICT = load(log_config_file)
        except YAMLError as exc:
            log.error(exc, exc_info=True)
    
    dictConfig(LOG_CONFIG_DICT)
    log.info("---START---")
    test_1()
    test_1_root()
    log.info("---DONE---")