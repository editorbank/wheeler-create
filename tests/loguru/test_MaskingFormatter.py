import logging
import re
from MaskingFormatter import MaskingFormatter

def test_MaskingFormatter():
    mylogger = logging.getLogger("foobar")
    mylogger.setLevel(logging.DEBUG)
    mylogger.propagate = False

    console = logging.StreamHandler(stream=None)
    console.setLevel(logging.INFO)

    my_formatter = MaskingFormatter(
        fmt="[pid:%(process)d] - %(asctime)s - %(name)s - %(levelname)-8s - %(message).1000s",
        secrets=["ABCDEF"],
        placeholder="***",
    )
    console.setFormatter(my_formatter)
    mylogger.addHandler(console)

    mylogger.info("My password is: 'ABCDEF'")
    print( mylogger.debug("My password is: 'ABCDEF'") , "My password is: '***'")


if __name__=="__main__": test_MaskingFormatter()