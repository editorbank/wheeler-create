import logging
from logging.handlers import SysLogHandler
import time

from service import find_syslog, Service

class test_service(Service):
    def __init__(self, *args, **kwargs):
        super(test_service, self).__init__(*args, **kwargs)
        self.logger.addHandler(SysLogHandler(address=find_syslog(), facility=SysLogHandler.LOG_DAEMON))
        self.logger.addHandler(logging.FileHandler('test_service.log', mode='a', encoding=None, delay=False, errors=None))
        self.logger.setLevel(logging.DEBUG)
        self.logger.info("%s Started.", self.name)

    def run(self):
        while not self.got_sigterm():
            self.logger.info("%s I'm working...", self.name)
            #time.sleep(5)

if __name__ == '__main__':
    import sys
    

    if len(sys.argv) != 2:
        sys.exit('Syntax: %s COMMAND' % sys.argv[0])

    cmd = sys.argv[1].lower()
    service = test_service('test_service', pid_dir='/tmp')

    if cmd == 'start':
        service.start()
    elif cmd == 'stop':
        service.stop()
    elif cmd == 'status':
        if service.is_running():
            print("Service is running.")
        else:
            print("Service is not running.")
    else:
        sys.exit('Unknown command "%s".' % cmd)