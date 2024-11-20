cd "$(realpath -m $0/..)"
. ../../ve.sh

[ -d ".tmp" ] || mkdir ".tmp"
jupyter nbconvert --to html --output-dir .tmp ./test_ipywidgets.ipynb
[ -f .tmp/test_ipywidgets.html -a $(stat -c %s .tmp/test_ipywidgets.html) -ge 1000 ]
echo OK
