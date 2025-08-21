import sys

class _logger():
    #def __init__(self,name="root"):

    def debug(self,msg,*args,**kwargs):
        pass
    def info(self,msg,*args,**kwargs):
        pass
    def warning(self,msg,*args,**kwargs):
        pass
    def error(self,msg,*args,**kwargs):
        pass
    def critical(self,msg,*args,**kwargs):
        pass

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
