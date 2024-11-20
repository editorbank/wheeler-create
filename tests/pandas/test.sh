cd "$(realpath -m $0/..)"
. ../../ve.sh

pytest tests
echo OK
