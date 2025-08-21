from the_module import test_1

from logging import debug, info, warning, error, critical
from logging import getLogger
log = getLogger(__name__)

LOG_CONFIG_DICT={
    "version": 1
    ,
    "formatters": {
        "sensitive": {
            "class": "SensitiveFormatter.SensitiveFormatter",
            "format": "%(asctime)s [%(levelname).3s] [%(name)s] %(message)s (%(filename)s#%(lineno)d)",
            "secrets": []
        }
    }
    ,
    "handlers": {
        "console": {
            "class" : "logging.StreamHandler",
            "formatter": "sensitive",
            "stream": "ext://sys.stdout",  # Default is stderr
        }
        ,
        "file": {
            "class" : "logging.FileHandler",
            "formatter": "sensitive",
            "level"   : "DEBUG",
            "filename": "file.log"
        }
    }
    ,
    "loggers": {
        "root": {
            "level"   : "DEBUG",
            "handlers": ["console","file"]
        }
        ,
        "__main__": {
            "level"   : "DEBUG",
            "handlers": ["console","file"]
        }
    }
}



if __name__ == "__main__":
    import logging.config
    logging.config.dictConfig(LOG_CONFIG_DICT)
    info("%s.START",__name__)
    test_1()
    info("%s.DONE",__name__)