[ -f .pylibs/favicon.ico ] || cp favicon.ico .pylibs/favicon.ico
ls -1 .pylibs | sort --ignore-case | python make_index_html.py >.pylibs/index.html && echo OK || echo FAIL
