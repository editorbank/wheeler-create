import sys

class _logger():
    def _emit(self,msg,*args,**kwargs):
        logrec = {**kwargs,**self.__dict__}
        msg = (msg % args) if args else (msg % logrec if kwargs else msg)
        msg = ("%(name)s [%(levelname)s] " % logrec) + msg
        sys.stderr.write(msg + "\n")
        sys.stderr.flush()

    def __init__(self,name="root"):
        self.name = name or "root"

    def debug(self,msg,*args,**kwargs):
        return self._emit(msg,*args,levelname="DEBUG",**kwargs)
    def info(self,msg,*args,**kwargs):
        return self._emit(msg,*args,levelname="INFO",**kwargs)
    def warning(self,msg,*args,**kwargs):
        return self._emit(msg,*args,levelname="WARNING",**kwargs)
    def error(self,msg,*args,**kwargs):
        return self._emit(msg,*args,levelname="ERROR",**kwargs)
    def critical(self,msg,*args,**kwargs):
        return self._emit(msg,*args,levelname="CRITICAL",**kwargs)

def getLogger(name="root"):
    return _logger()

__all__ = ["getLogger"]

if __name__=="__main__":
    log = getLogger(__name__)
    log.debug("'xxx'==%(key1)r, 'yyy'=%(key2)r", key1="xxx", key2="yyy")
    log.info("'xxx'==%(key1)r, 'yyy'=%(key2)r", key1="xxx", key2="yyy")
    log.warning("'xxx'==%(key1)r, 'yyy'=%(key2)r", key1="xxx", key2="yyy")
    log.error("'xxx'==%(key1)r, 'yyy'=%(key2)r", key1="xxx", key2="yyy")
    log.critical("'xxx'==%(key1)r, 'yyy'=%(key2)r", key1="xxx", key2="yyy")
