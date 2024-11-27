cp wheeler.ico .pylibs/favicon.ico
ls -1 .pylibs | sort --ignore-case | grep -v -E '^(favicon\.ico|index\.html)$'| python3 make_index_html.py >.pylibs/index.html && echo OK || echo FAIL
