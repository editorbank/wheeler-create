cd "$(realpath -m $0/..)"
if [ -d .venv ]
  then
    rm -rf .venv
fi