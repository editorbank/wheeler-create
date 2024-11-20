cd "$(realpath -m $0/..)"
set -e
PIP_CONFIG_FILE="$PWD/.venv/pip.ini"
whl_dir="$(realpath -m ../../.pylibs)"

if [ -f requirements.txt -a ! -d ".venv" ] ; then
  echo Found requirements.txt.
  echo Create virtual environment ...
  python -m venv ".venv"
fi
if [ -f ".venv/bin/activate" ] ; then source ".venv/bin/activate" ; fi
if [ -z "$VIRTUAL_ENV" ] ; then >&2 echo "Not init virtual environment!" ; exit 1 ; fi

if [ -d "$whl_dir" -a ! -f "$PIP_CONFIG_FILE" ] ; then
    echo Found local whl dir "$whl_dir".
    echo Create pip.ini ...
    cat <<EOF>"$PIP_CONFIG_FILE"
[global]
no-index=true
find-links=$whl_dir
EOF
fi

if [ -f "$PIP_CONFIG_FILE" ] ;then export PIP_CONFIG_FILE ; fi

if [ -f requirements.txt -a ! -f ".venv/requirements.log" ] ; then
  echo Install requirements...
  pip --require-virtualenv install -qqq --log ".venv/requirements.log" -r requirements.txt 
fi

[ -d ".tmp" ] || mkdir ".tmp"
jupyter nbconvert --to html --output-dir .tmp ./test_ipywidgets.ipynb
[ -f .tmp/test_ipywidgets.html -a $(stat -c %s .tmp/test_ipywidgets.html) -ge 1000 ]
echo OK
