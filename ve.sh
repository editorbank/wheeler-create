set -e
WHELLER_DIR="${WHELLER_DIR:-$(realpath ../../.pylibs)}"
if [ -z "${WHELLER_DIR}" -o ! -d "${WHELLER_DIR}" ] ; then 1>&2 echo Not set or not exists WHELLER_DIR!; exit 1 ; fi
export WHELLER_DIR
venv_dir="$PWD/.venv"
PIP_CONFIG_FILE="$venv_dir/pip.ini"

if [ -f requirements.txt -a ! -d "$venv_dir" ] ; then
  echo Found requirements.txt.
  echo Create virtual environment ...
  python -m venv "$venv_dir"
fi
if [ -f "$venv_dir/bin/activate" ] ; then source "$venv_dir/bin/activate" ; fi
if [ -z "$VIRTUAL_ENV" ] ; then >&2 echo "Not init virtual environment!" ; exit 1 ; fi

if [ -d "${WHELLER_DIR:-}" -a ! -f "$PIP_CONFIG_FILE" ] ; then
  echo "Found local WHELLER_DIR=\"$WHELLER_DIR\"."
  echo Create pip.ini ...
  cat <<EOF>"$PIP_CONFIG_FILE"
[global]
no-index=true
find-links=$WHELLER_DIR
EOF
fi

if [ -f "$PIP_CONFIG_FILE" ] ;then export PIP_CONFIG_FILE ; fi

if [ -f requirements.txt -a ! -f "$venv_dir/requirements.log" ] ; then
  echo Install requirements...
  pip --require-virtualenv install -qqq --log "$venv_dir/requirements.log" -r requirements.txt 
fi

$*