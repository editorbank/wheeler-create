import sys
from urllib.parse import quote_plus as url_escape

def main(lines):
    EOL = "\r\n"
    BODY = ""
    for line in lines:
        NAME = line.strip()
        URL =  url_escape(NAME)
        BODY += '<li><a href="'+URL+'">'+NAME+'</a></li>'+EOL
    return """<html>"""+EOL+BODY+"""</html>"""+EOL

if __name__ == "__main__" : sys.stdout.write(main(sys.stdin.readlines()))
