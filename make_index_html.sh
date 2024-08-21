cp wheeler.ico .pylibs/favicon.ico
ls -1 .pylibs | sort --ignore-case | grep -v -E '^(favicon\.ico|index\.html)$'| python make_index_html.py >.pylibs/index.html && echo OK || echo FAIL
